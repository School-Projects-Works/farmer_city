import 'package:firmer_city/features/auth/provider/register_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/router/router_info.dart';
import '../../../core/widget/custom_dialog.dart';
import '../data/user_model.dart';
import '../services/auth_services.dart';


final newUserProvider =
    StateNotifierProvider<NewUserProvider, UserModel>((ref) => NewUserProvider());

class NewUserProvider extends StateNotifier<UserModel> {
  NewUserProvider() : super(UserModel());

  void setGender(String s) {
    state = state.copyWith(gender: () => s);
  }

  void setUserType(String s) {
    state = state.copyWith(userType: () => s);
  }

  void setFullName(String value) {
    state = state.copyWith(name: () => value);
  }

  void setEmail(String value) {
    state = state.copyWith(email: () => value);
  }

  void setPhone(String value) {
    state = state.copyWith(phone: () => value);
  }

  void setPassword(String value) {
    state = state.copyWith(password: () => value);
  }

  void validateUserType({required WidgetRef ref}) {
    if (state.userType == null) {
      CustomDialog.showToast(
        message: 'Please select user type',
      );
    } else if (state.userType == 'Student' && state.farmType.isEmpty) {
      CustomDialog.showToast(
        message: 'Please select farm type',
      );
    } else {
      ref.read(currentScreenProvider.notifier).state = 1;
    }
  }

  bool validateBio() {
    if (state.name == null) {
      CustomDialog.showToast(message: 'Please enter full name');
      return false;
    } else if (state.phone == null || state.phone!.length < 10) {
      CustomDialog.showToast(message: 'Please enter a valid phone number');
      return false;
    } else if (state.email == null ||
        RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                .hasMatch(state.email!) ==
            false) {
      CustomDialog.showToast(message: 'Please enter email address');
      return false;
    } else if (state.password == null || state.password!.length < 6) {
      CustomDialog.showToast(
          message: 'Please enter password with at least 6 characters');
      return false;
    }
    return true;
  }

  void createUser(
      {required WidgetRef ref, required BuildContext context}) async {
    if (validateBio()) {
      CustomDialog.showLoading(message: 'Creating user.....');
      var (succes, message) = await AuthServices.createUser(state);
      if (succes) {
        CustomDialog.dismiss();
        CustomDialog.showSuccess(message: message);
        state = UserModel();
        context.go(RouterInfo.loginRoute.path);
      } else {
        CustomDialog.dismiss();
        CustomDialog.showError(message: message);
      }
    }
  }
}

final absecuredProvider = StateProvider<bool>((ref) => true);
