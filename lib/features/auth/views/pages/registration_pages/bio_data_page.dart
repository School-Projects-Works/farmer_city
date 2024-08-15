import 'package:firmer_city/config/router/router.dart';
import 'package:firmer_city/config/router/router_info.dart';
import 'package:firmer_city/features/auth/provider/register_screen_provider.dart';
import 'package:firmer_city/utils/colors.dart';
import 'package:firmer_city/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/widget/custom_button.dart';
import '../../../../../core/widget/custom_input.dart';
import '../../../provider/new_user_provider.dart';

class BioDataPage extends ConsumerWidget {
  BioDataPage({super.key});

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var styles = Styles(context);
    var notifier = ref.read(newUserProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (ref.watch(currentScreenProvider) == 0) {
                    MyRouter(context: context, ref: ref)
                        .navigateToRoute(RouterInfo.loginRoute);
                  } else {
                    ref.read(currentScreenProvider.notifier).state = 0;
                  }
                },
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'New User Registration'.toUpperCase(),
                  style: styles.body(
                      color: primaryColor,
                      mobile: 20,
                      desktop: 30,
                      tablet: 23,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 3,
            color: secondaryColor,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text('What is your Identification No.?',
                              style: styles.body(
                                  mobile: 18, desktop: 25, tablet: 20)),
                          subtitle: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: CustomTextFields(
                                color: Colors.pink[700]!,
                                hintText:
                                    'Enter Ghana Card No. eg. GHA-12345678-2',
                                isCapitalized: true,
                                validator: (number) {
                                  if (number!.isEmpty) {
                                    return 'Please enter a valid Ghana Card Number';
                                  } else if (number.length < 14) {
                                    return 'Enter a valid Id number';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  notifier.setIdNumber(value);
                                },
                              ))),
                      ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text('What is your full name ?',
                              style: styles.body(
                                  mobile: 18, desktop: 25, tablet: 20)),
                          subtitle: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: CustomTextFields(
                                color: Colors.pink[700]!,
                                hintText: 'Enter Full Name',
                                validator: (name) {
                                  if (name!.isEmpty) {
                                    return 'Please enter a valid name';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  notifier.setFullName(value!);
                                },
                              ))),
                      //email
                      ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text('What is your email address ?',
                              style: styles.body(
                                  mobile: 18, desktop: 25, tablet: 20)),
                          subtitle: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: CustomTextFields(
                                color: Colors.pink[700]!,
                                hintText: 'Enter Email Address',
                                validator: (email) {
                                  if (email!.isEmpty) {
                                    return 'Please enter a valid email';
                                  } else if (RegExp(
                                              r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                          .hasMatch(email) ==
                                      false) {
                                    return 'Enter a valid email';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  notifier.setEmail(value!);
                                },
                              ))),
                      //phone
                      ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text('What is your phone number ?',
                              style: styles.body(
                                  mobile: 18, desktop: 25, tablet: 20)),
                          subtitle: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: CustomTextFields(
                                color: Colors.pink[700]!,
                                hintText: 'Enter Phone Number',
                                keyboardType: TextInputType.phone,
                                validator: (phone) {
                                  if (phone!.isEmpty) {
                                    return 'Please enter a valid phone number';
                                  } else if (phone.length < 10) {
                                    return 'Enter a valid phone number';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  notifier.setPhone(value!);
                                },
                              ))),
                      //password
                      ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text('What is your password ?',
                              style: styles.body(
                                  mobile: 18, desktop: 25, tablet: 20)),
                          subtitle: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: CustomTextFields(
                                color: Colors.pink[700]!,
                                suffixIcon: IconButton(
                                  icon: Icon(ref.watch(absecuredProvider)
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    ref.read(absecuredProvider.notifier).state =
                                        !ref.read(absecuredProvider);
                                  },
                                ),
                                hintText: 'Enter Password',
                                obscureText: ref.watch(absecuredProvider),
                                onSaved: (value) {
                                  notifier.setPassword(value!);
                                },
                              ))),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      notifier.createUser(ref: ref, context: context);
                    }
                  },
                  text: 'Create Account',
                  radius: 10,
                  color: primaryColor,
                  icon: Icons.create,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
