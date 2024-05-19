import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gps_student_attendance/core/widget/custom_button.dart';
import 'package:gps_student_attendance/core/widget/custom_drop_down.dart';
import 'package:gps_student_attendance/core/widget/custom_input.dart';
import 'package:gps_student_attendance/features/auth/provider/new_user_provider.dart';
import 'package:gps_student_attendance/utils/styles.dart';

class BioDataPage extends ConsumerWidget {
  const BioDataPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var styles = CustomStyles(context: context);
    var provider = ref.watch(newUserProvider);
    var notifier = ref.read(newUserProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'New User Registration',
            style: styles.textStyle(
                color: primaryColor,
                mobile: 25,
                desktop: 35,
                tablet: 28,
                fontWeight: FontWeight.bold),
          ),
          const Divider(
            thickness: 3,
            color: secondaryColor,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('Choose your prefix ?',
                          style: styles.textStyle(
                              mobile: 18, desktop: 25, tablet: 20)),
                      subtitle: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomDropDown(
                            items: [
                              'Mr.',
                              'Mrs.',
                              'Miss',
                              'Dr.',
                              'Prof.',
                            ]
                                .map((e) =>
                                    DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                            hintText: 'Select Prefix',
                            onChanged: (value) {
                              notifier.setPrefix(value.toString());
                            },
                          ))),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('What is your full name ?',
                          style: styles.textStyle(
                              mobile: 18, desktop: 25, tablet: 20)),
                      subtitle: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: CustomDropDown(
                                  items: [
                                    'Mr.',
                                    'Mrs.',
                                    'Miss',
                                    'Dr.',
                                    'Prof.',
                                  ]
                                      .map((e) => DropdownMenuItem(
                                          value: e, child: Text(e)))
                                      .toList(),
                                  hintText: 'Select Prefix',
                                  onChanged: (value) {
                                    notifier.setPrefix(value.toString());
                                  },
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: CustomTextFields(
                                  color: Colors.pink[700]!,
                                  hintText: 'Enter Full Name',
                                  onChanged: (value) {
                                    notifier.setFullName(value);
                                  },
                                ),
                              ),
                            ],
                          ))),
                  //email
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('What is your email address ?',
                          style: styles.textStyle(
                              mobile: 18, desktop: 25, tablet: 20)),
                      subtitle: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomTextFields(
                            color: Colors.red[700]!,
                            hintText: 'Enter Email Address',
                            onChanged: (value) {
                              notifier.setEmail(value);
                            },
                          ))),
                  //phone
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('What is your phone number ?',
                          style: styles.textStyle(
                              mobile: 18, desktop: 25, tablet: 20)),
                      subtitle: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomTextFields(
                            color: Colors.blue[700]!,
                            hintText: 'Enter Phone Number',
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              notifier.setPhone(value);
                            },
                          ))),
                  //password
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('What is your password ?',
                          style: styles.textStyle(
                              mobile: 18, desktop: 25, tablet: 20)),
                      subtitle: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomTextFields(
                            color: Colors.green[700]!,
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
                            onChanged: (value) {
                              notifier.setPassword(value);
                            },
                          ))),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    notifier.createUser(ref: ref, context: context);
                  },
                  text: 'Create Account',
                  radius: 10,
                  color: primaryColor,
                  icon: const Icon(
                    Icons.create,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
