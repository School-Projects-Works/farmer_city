import 'package:firmer_city/features/auth/provider/register_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/router/router_info.dart';
import '../../../core/widget/custom_dialog.dart';
import '../data/user_model.dart';
import '../services/auth_services.dart';

final newUserProvider = StateNotifierProvider<NewUserProvider, UserModel>(
    (ref) => NewUserProvider());

class NewUserProvider extends StateNotifier<UserModel> {
  NewUserProvider() : super(UserModel());

  void setGender(String s) {
    state = state.copyWith(gender: () => s);
  }

  void setUserType(String s) {
    state = state.copyWith(userType: () => s);
    if (s != 'Farmer') {
      state = state.copyWith(farmType: [], productType: []);
    }
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
    if (state.gender == null) {
      CustomDialog.showToast(message: 'Please select gender');
    } else if (state.userType == null) {
      CustomDialog.showToast(
        message: 'Please select user type',
      );
    } else if (state.userType == 'Farmer') {
      if (state.farmType.isEmpty) {
        CustomDialog.showToast(
          message: 'Please select Type of product you produce',
        );
      } else if (state.farmType.contains('Crops') ||
          state.farmType.contains('Livestock')) {
        if (state.productType.isEmpty) {
          CustomDialog.showToast(
            message: 'Please select type farm product you produce',
          );
        } else {
          ref.read(currentScreenProvider.notifier).state = 1;
        }
      } else {
        ref.read(currentScreenProvider.notifier).state = 1;
      }
    } else {
      ref.read(currentScreenProvider.notifier).state = 1;
    }
  }

  void addFarmType(String s) {
    var lits = state.farmType.toList();
    if (lits.contains(s)) {
      lits.remove(s);
      state = state.copyWith(productType: []);
    } else {
      lits.add(s);
    }
    state = state.copyWith(farmType: lits);
  }

  void addProduct(String s) {
    var list = state.productType.toList();
    if (list.contains(s)) {
      list.remove(s);
    } else {
      list.add(s);
    }
    state = state.copyWith(productType: list);
  }

  void setIdNumber(String? value) {
    state = state.copyWith(ghId: () => value);
  }

  void createUser(
      {required WidgetRef ref, required BuildContext context}) async {
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

final absecuredProvider = StateProvider<bool>((ref) => true);
