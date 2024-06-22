import 'package:firmer_city/core/widget/custom_button.dart';
import 'package:firmer_city/core/widget/custom_input.dart';
import 'package:firmer_city/features/assistant/data/chat_model.dart';
import 'package:firmer_city/features/assistant/data/messages_model.dart';
import 'package:firmer_city/features/assistant/provider/actions_provider.dart';
import 'package:firmer_city/features/assistant/provider/chat_provider.dart';
import 'package:firmer_city/features/auth/provider/login_provider.dart';
import 'package:firmer_city/generated/assets.dart';
import 'package:firmer_city/utils/colors.dart';
import 'package:firmer_city/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../core/functions/time_functions.dart';
import '../../../core/widget/custom_dialog.dart';

class AssitantPage extends ConsumerStatefulWidget {
  const AssitantPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AssitantPageState();
}

class _AssitantPageState extends ConsumerState<AssitantPage> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var breakPoint = ResponsiveBreakpoints.of(context);
    return Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 20),
        child: breakPoint.smallerOrEqualTo(TABLET)
            ? Scaffold(
                drawer: Drawer(
                  child: _buildChatHistory(),
                ),
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  // title: const Text('Assistant'),
                ),
                body: _buildAiChat())
            : Row(
                children: [
                  _buildChatHistory(),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: _buildAiChat(),
                  )
                ],
              ));
  }

  Widget _buildAiChat() {
    var breakPoint = ResponsiveBreakpoints.of(context);
    var currentChat = ref.watch(gptProvider);
    return Container(
      color: Colors.white30,
      padding: const EdgeInsets.all(5),
      width: double.infinity,
      height: breakPoint.screenHeight,
      child: Column(
        children: [
          Expanded(
            child: currentChat.chat.id != null &&
                    currentChat.messages.isNotEmpty
                ? ListView.builder(
                    itemCount: currentChat.messages.length,
                    itemBuilder: (context, index) {
                      var message = currentChat.messages[index];
                      return _buildMessage(
                        message: message,
                      );
                    })
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        margin: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Assets.imagesFarmerIcon))),
                      ),
                      _buildInitCards(),
                    ],
                  ),
          ),
          const SizedBox(
            height: 10,
          ),
          if (ref.watch(sendingMessageProvider))
            SizedBox(
              width: breakPoint.isMobile ? double.infinity : 400,
              child: const Column(
                children: [
                  Text('Processing question...'),
                  SizedBox(
                    height: 10,
                  ),
                  LinearProgressIndicator(
                    backgroundColor: Colors.white,
                    minHeight: 5,
                  ),
                ],
              ),
            )
          else
            _buildInput()
        ],
      ),
    );
  }

  Widget _buildChatHistory() {
    var breakPoint = ResponsiveBreakpoints.of(context);
    var chatStream = ref.watch(chatStreamProvider);
    return Container(
      color: Colors.grey.shade100,
      padding: const EdgeInsets.all(10),
      width: 400,
      height: breakPoint.screenHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recent Assistance',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor)),
          const SizedBox(
            height: 10,
          ),
          if (ref.watch(gptProvider).chat.id != null)
            ListTile(
              style: ListTileStyle.drawer,
              onTap: () {
                ref.read(gptProvider.notifier).setChat(ChatModel());
              },
              leading: const Icon(Icons.add),
              title: const Text('New Chat'),
            ),
          Expanded(
            child: chatStream.when(
                data: (chats) {
                  if (chats.isEmpty) {
                    return const Center(
                      child: Text('No chat history'),
                    );
                  }
                  return ListView.builder(
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        var chat = chats[index];
                        return ListTile(
                          style: ListTileStyle.drawer,
                          onTap: () {
                            if (ref.watch(gptProvider).chat.id != chat.id) {
                              ref.read(gptProvider.notifier).setChat(chat);
                            }
                          },
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                image: const DecorationImage(
                                    image:
                                        AssetImage(Assets.imagesFarmerIcon))),
                          ),
                          title: Text(chat.firstQuestion ?? ''),
                          subtitle: Text(TimeUtils.formatDateTime(
                              chat.createdAt!,
                              onlyDate: true)),
                        );
                      });
                },
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                error: (error, stackTrace) {
                  return Center(
                    child: Text('Error: $error'),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget _buildInitCards() {
    var breakPoint = ResponsiveBreakpoints.of(context);
    var styles = Styles(context);
    return breakPoint.screenWidth < 800
        ? Column(
            children: [
              Container(
                width: double.infinity,
                height: 120,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: primaryColor.withOpacity(.6),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Click 'Upload' to select existing images or use your device's camera to snap a new photo of the sick plant.",
                      style: styles.body(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          desktop: 15,
                          mobile: 15,
                          tablet: 15),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 120,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(.6),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "The platform analyzes your image to predict the plant disease.",
                  style: styles.body(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      desktop: 15,
                      mobile: 15,
                      tablet: 15),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 120,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(.6),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "Type any farm-related question in the chat box to receive expert answers powered by GPT-4.",
                  style: styles.body(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      desktop: 15,
                      mobile: 15,
                      tablet: 15),
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: primaryColor.withOpacity(.6),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Click 'Upload' to select existing images or use your device's camera to snap a new photo of the sick plant.",
                      textAlign: TextAlign.center,
                      style: styles.body(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          desktop: 15,
                          mobile: 15,
                          tablet: 15),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 200,
                height: 200,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(.6),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "The platform analyzes your image to predict the plant disease.",
                  textAlign: TextAlign.center,
                  style: styles.body(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      desktop: 15,
                      mobile: 15,
                      tablet: 15),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 200,
                height: 200,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(.6),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "Type any farm-related question in the chat box to receive expert answers powered by GPT-4.",
                  textAlign: TextAlign.center,
                  style: styles.body(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      desktop: 15,
                      mobile: 15,
                      tablet: 15),
                ),
              ),
            ],
          );
  }

  Widget _buildInput() {
    var breakPoint = ResponsiveBreakpoints.of(context);
    var pressProvider = ref.watch(uploadPressProvider);
    var pressNotifier = ref.read(uploadPressProvider.notifier);
    var user = ref.watch(userProvider);
    return Row(
      children: [
        ResponsiveVisibility(
            visible: breakPoint.isMobile && !pressProvider,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CustomButton(
                text: '',
                radius: 10,
                onPressed: () {
                  pressNotifier.state = true;
                },
                icon: 
                  Icons.upload_file,
                  
              ),
            )),
        ResponsiveVisibility(
          visible: breakPoint.largerOrEqualTo(TABLET) || pressProvider,
          child: breakPoint.isMobile
              ? Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            CustomButton(
                              text: 'Upload Sick plant',
                              onPressed: () {
                                if (user.id == null) {
                                  CustomDialog.showError(
                                      message: 'Please login to continue');
                                  return;
                                }
                                ref.read(gptProvider.notifier).askWithImage(
                                      source: ImageSource.gallery,
                                      ref: ref,
                                      user: user,
                                    );
                              },
                              radius: 10,
                              icon:
                                Icons.upload_file,
                                
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CustomButton(
                              text: 'Snap Sick plant',
                              radius: 10,
                              onPressed: () {
                                if (user.id == null) {
                                  CustomDialog.showError(
                                      message: 'Please login to continue');
                                  return;
                                }
                                ref.read(gptProvider.notifier).askWithImage(
                                      source: ImageSource.camera,
                                      ref: ref,
                                      user: user,
                                    );
                              },
                              icon: 
                                Icons.camera,
                               
                            ),
                            if (pressProvider)
                              const SizedBox(
                                width: 5,
                              ),
                            if (pressProvider)
                              CustomButton(
                                text: '',
                                radius: 10,
                                color: Colors.red,
                                icon:Icons.cancel,
                                onPressed: () {
                                  pressNotifier.state = false;
                                },
                              )
                          ],
                        ),
                      )),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    children: [
                      CustomButton(
                        text: 'Upload Sick plant',
                        onPressed: () {
                          if (user.id == null) {
                            CustomDialog.showError(
                                message: 'Please login to continue');
                            return;
                          }
                          ref.read(gptProvider.notifier).askWithImage(
                                source: ImageSource.gallery,
                                ref: ref,
                                user: user,
                              );
                        },
                        radius: 10,
                        icon: 
                          Icons.upload_file,
                         
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomButton(
                        text: 'Snap Sick plant',
                        radius: 10,
                        onPressed: () {
                          if (user.id == null) {
                            CustomDialog.showError(
                                message: 'Please login to continue');
                            return;
                          }
                          ref.read(gptProvider.notifier).askWithImage(
                                source: ImageSource.camera,
                                ref: ref,
                                user: user,
                              );
                        },
                        icon: 
                          Icons.camera,
                          
                      ),
                      if (pressProvider && breakPoint.isMobile)
                        const SizedBox(
                          width: 5,
                        ),
                      if (pressProvider && breakPoint.isMobile)
                        CustomButton(
                          text: '',
                          radius: 10,
                          color: Colors.red,
                          icon: Icons.cancel,
                          onPressed: () {
                            pressNotifier.state = false;
                          },
                        )
                    ],
                  ),
                ),
        ),
        if (!pressProvider)
          Expanded(
              child: CustomTextFields(
            maxLines: 3,
            hintText: 'What is wrong with your Farm',
            controller: _controller,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(5.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  if (user.id == null) {
                    CustomDialog.showError(message: 'Please login to continue');
                    return;
                  } else if (_controller.text.isEmpty ||
                      _controller.text.length < 5) {
                    CustomDialog.showToast(message: 'Please enter a question');
                    return;
                  }
                  ref.read(gptProvider.notifier).createMessagesByText(
                      question: _controller.text, ref: ref, user: user);
                  _controller.clear();
                },
              ),
            ),
          )),
      ],
    );
  }

  Widget _buildMessage({required MessagesModel message}) {
    var breakPoint = ResponsiveBreakpoints.of(context);
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
          color: primaryColor.withOpacity(.2),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 15,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'You',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              if (message.questionType == 'image')
                Container(
                  width: 250,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(message.question),
                          fit: BoxFit.cover)),
                )
              else
                Text(
                  message.question,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage(Assets.imagesFarmerIcon),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Assistant',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            //: 400,
            width: breakPoint.screenWidth < 800
                ? double.infinity
                : breakPoint.screenWidth * .5,
            child: Markdown(
              shrinkWrap: true,
              selectable: true,
              data: message.response,
              styleSheet: MarkdownStyleSheet(
                  p: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500)),
            ),
          ),
        ],
      ),
    );
  }
}
