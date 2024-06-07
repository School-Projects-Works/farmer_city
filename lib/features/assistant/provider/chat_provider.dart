import 'package:firmer_city/core/widget/custom_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:firmer_city/features/assistant/data/chat_model.dart';
import 'package:firmer_city/features/assistant/data/messages_model.dart';
import 'package:firmer_city/features/assistant/services/chat_services.dart';
import 'package:firmer_city/features/assistant/services/gpt_services.dart';
import 'package:firmer_city/features/assistant/services/messages_services.dart';
import 'package:firmer_city/features/auth/data/user_model.dart';
import 'package:image_picker/image_picker.dart';

import '../../auth/provider/login_provider.dart';

final chatStreamProvider =
    StreamProvider.autoDispose<List<ChatModel>>((ref) async* {
  var user = ref.watch(userProvider);
  if (user.id != null) {
    final chatData = ChatServices.getChats(user.id!);
    await for (final chat in chatData) {
      //order chat by createdAt, recent chat will be on top
      chat.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      yield chat;
    }
  } else {
    yield [];
  }
});

class CurrentChat {
  final ChatModel chat;
  final List<MessagesModel> messages;

  CurrentChat({required this.chat, required this.messages});

  CurrentChat copyWith({
    ChatModel? chat,
    List<MessagesModel>? messages,
  }) {
    return CurrentChat(
      chat: chat ?? this.chat,
      messages: messages ?? this.messages,
    );
  }
}

final gptProvider =
    StateNotifierProvider<GPTProvider, CurrentChat>((ref) => GPTProvider());

class GPTProvider extends StateNotifier<CurrentChat> {
  GPTProvider() : super(CurrentChat(chat: ChatModel(), messages: []));
  Future<void> setChat(ChatModel chat) async {
    if (chat.id == null) {
      state = state.copyWith(messages: [], chat: chat);
    } else {
      CustomDialog.showLoading(message: 'Loading chat...');
      var messages = await MessagesServices.getMessagesByChatId(chat.id!);
      state = CurrentChat(chat: chat, messages: messages);
      CustomDialog.dismiss();
    }
  }

  Future<bool> isQuestionFarmRelated(String question) async {
    final response = await GPTServices.isQuestionFarmRelated(question);
    return response;
  }

  Future<void> createMessagesByText(
      {required String question,
      required WidgetRef ref,
      required UserModel user}) async {
    ref.read(sendingMessageProvider.notifier).state = true;
    try {
      var isFarmRelated = await isQuestionFarmRelated(question);
      if (isFarmRelated) {
        var response = await GPTServices.getFarmRelatedResponse(question);
        if (response != null) {
          if (state.chat.id == null) {
            var chat = ChatModel(
                id: ChatServices.getChatId(),
                userId: user.id!,
                firstQuestion: question,
                createdAt: DateTime.now().millisecondsSinceEpoch);
            await ChatServices.createChat(chat);
            state = state.copyWith(chat: chat);
          }
          var messages = state.messages;
          var message = MessagesModel(
              id: await MessagesServices.getMessagesId(state.chat.id!),
              chatId: state.chat.id ?? '',
              sender: user.id!,
              question: question,
              questionType: 'text',
              response: response,
              createdAt: DateTime.now().millisecondsSinceEpoch);
          await MessagesServices.createMessages(message);
          state = state.copyWith(messages: [...messages, message]);
        }
        ref.read(sendingMessageProvider.notifier).state = false;
      } else {
        ref.read(sendingMessageProvider.notifier).state = false;
        CustomDialog.showError(
            message:
                'Sorry, I am not able to answer this question. Please ask Farm related questions.');
      }
    } catch (e) {
      ref.read(sendingMessageProvider.notifier).state = false;
      CustomDialog.showError(
          message:
              'Sorry, I am not able to answer this question. Something happened.');
    }
  }

  void askWithImage(
      {required ImageSource source,
      required WidgetRef ref,
      required UserModel user}) async {
    
    try {
      var image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        ref.read(sendingMessageProvider.notifier).state = true;
        var imageToBase64 = await image.readAsBytes();
        var isFarmRelated =
            await GPTServices.isFarmRelatedWithImage(imageToBase64);
        if (isFarmRelated) {
          var response =
              await GPTServices.getFarmRelatedResponseWithImage(imageToBase64);
          if (response != null) {
            String imagePath = await GPTServices.uploadImageToFirestore(imageToBase64);
            if (state.chat.id == null) {
              var chat = ChatModel(
                  id: ChatServices.getChatId(),
                  userId: user.id!,
                  firstQuestion: 'Image',
                  createdAt: DateTime.now().millisecondsSinceEpoch);
              await ChatServices.createChat(chat);
              state = state.copyWith(chat: chat);
            }
            var messages = state.messages;
            var message = MessagesModel(
                id: await MessagesServices.getMessagesId(state.chat.id!),
                chatId: state.chat.id ?? '',
                sender: user.id!,
                question: imagePath,
                questionType: 'image',
                response: response,
                createdAt: DateTime.now().millisecondsSinceEpoch);
            await MessagesServices.createMessages(message);
            state = state.copyWith(messages: [...messages, message]);
          }
          ref.read(sendingMessageProvider.notifier).state = false;
        } else {
          ref.read(sendingMessageProvider.notifier).state = false;
          CustomDialog.showError(
              message:
                  'Sorry, I am not able to answer this question. Please ask Farm/agriculture related questions.');
        }
      }
    } catch (e) {
      ref.read(sendingMessageProvider.notifier).state = false;
      CustomDialog.showError(
          message:
              'Sorry, I am not able to answer this question. Something happened.');
    }
  }
}

final sendingMessageProvider = StateProvider<bool>((ref) => false);
