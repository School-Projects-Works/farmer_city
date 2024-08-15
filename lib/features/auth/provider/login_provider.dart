import 'package:firmer_city/config/router/router.dart';
import 'package:firmer_city/features/auth/data/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universal_html/html.dart';
import '../../../config/router/router_info.dart';
import '../../../core/widget/custom_dialog.dart';
import '../services/auth_services.dart';

final loginObsecureTextProvider = StateProvider<bool>((ref) => true);

final loginProvider =
    StateNotifierProvider<LoginProvider, UserModel>((ref) => LoginProvider());

class LoginProvider extends StateNotifier<UserModel> {
  LoginProvider() : super(UserModel());

  void setEmail(String value) {
    state = state.copyWith(email: () => value);
  }

  void setPassword(String value) {
    state = state.copyWith(password: () => value);
  }

  void loginUser(
      {required WidgetRef ref, required BuildContext context}) async {
    CustomDialog.showLoading(message: 'Logging in.....');
    var (message, user) = await AuthServices.login(
        email: state.email!, password: state.password!);
    if (user != null) {
      if (user.emailVerified == false&& !user.email!.contains('koda')) {
        CustomDialog.dismiss();
        CustomDialog.showInfo(
            message: 'Your email is not verified, please verify your email',
            buttonText: 'Send verification',
            onPressed: () async {
              await user.sendEmailVerification();
              await AuthServices.auth.signOut();
              CustomDialog.dismiss();
              CustomDialog.showSuccess(message: 'Verification email sent');
            });
        return;
      }
      var (_, userData) = await AuthServices.getUserData(user.uid);
      if (userData.id == null) {
        await AuthServices.auth.signOut();
        CustomDialog.dismiss();
        CustomDialog.showError(message: 'User not found');
        return;
      }
      state = userData;
      ref.read(userProvider.notifier).setUser(userData);
      CustomDialog.dismiss();
      CustomDialog.showSuccess(message: message);
      MyRouter(context: context, ref: ref)
          .navigateToRoute(RouterInfo.homeRoute);
    } else {
      CustomDialog.dismiss();
      CustomDialog.showError(message: message);
    }
  }

  void setUser(UserModel userData) {
    state = userData;
  }

  void signOut({required BuildContext context, required WidgetRef ref}) async {
    CustomDialog.dismiss();
    CustomDialog.showLoading(message: 'Logging out.....');
    var done = await AuthServices.signOut();
    if (done) {
      Storage localStorage = window.localStorage;
      localStorage.remove('user');
      ref.read(userProvider.notifier).removeUser();
      CustomDialog.dismiss();
      CustomDialog.showToast(message: 'Logged out successfully');
      // ignore: use_build_context_synchronously
      MyRouter(context: context, ref: ref)
          .navigateToRoute(RouterInfo.loginRoute);
    }
  }
}

final userProvider = StateNotifierProvider<UserProvider, UserModel>((ref) {
  Storage localStorage = window.localStorage;
  var user = localStorage['user'];
  if (user != null) {
    return UserProvider()..updateUer(UserModel.fromJson(user).id);
  }
  return UserProvider();
});

class UserProvider extends StateNotifier<UserModel> {
  UserProvider() : super(UserModel());

  void setUser(UserModel user) {
    Storage localStorage = window.localStorage;
    localStorage['user'] = user.toJson();
    state = user;
  }

  void removeUser() {
    state = UserModel();
  }

  void setName(String value) {
    state = state.copyWith(name: () => value);
  }

  void setGender(String s) {
    state = state.copyWith(
      gender: () => s,
    );
  }

  void setPhone(String value) {
    state = state.copyWith(phone: () => value);
  }

  void updateUser(
      {required WidgetRef ref, required BuildContext context}) async {
    CustomDialog.dismiss();
    CustomDialog.showLoading(message: 'Updating user.....');
    var userProfile = ref.watch(userImage);
    if (userProfile != null) {
      var (message, url) =
          await AuthServices.uploadImage(userProfile, state.id!);
      if (url != null) {
        state = state.copyWith(profileImage: () => url);
        ref.read(userImage.notifier).state = null;
      } else {
        CustomDialog.dismiss();
        CustomDialog.showError(message: message);
        return;
      }
    }
    await AuthServices.updateUserData(state);
    CustomDialog.dismiss();
    CustomDialog.showSuccess(message: 'User updated successfully');
  }

  updateUer(String? id) async {
    var (message, userData) = await AuthServices.getUserData(id!);
    if (userData.id != null) {
      state = userData;
    }
  }
}

final userImage = StateProvider<XFile?>((ref) => null);
