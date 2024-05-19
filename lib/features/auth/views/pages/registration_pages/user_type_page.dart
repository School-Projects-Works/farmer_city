import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gps_student_attendance/core/constants/departments.dart';
import 'package:gps_student_attendance/core/widget/custom_button.dart';
import 'package:gps_student_attendance/core/widget/custom_drop_down.dart';
import 'package:gps_student_attendance/core/widget/custom_input.dart';
import 'package:gps_student_attendance/core/widget/custom_selector.dart';
import 'package:gps_student_attendance/features/auth/provider/new_user_provider.dart';
import 'package:gps_student_attendance/utils/styles.dart';
import 'package:responsive_framework/responsive_framework.dart';

class UserTypeScreen extends ConsumerStatefulWidget {
  const UserTypeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends ConsumerState<UserTypeScreen> {
  @override
  Widget build(BuildContext context) {
    var breakPoint = ResponsiveBreakpoints.of(context);
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
                    title: Text('What is your gender ?',
                        style: styles.textStyle(
                            mobile: 18, desktop: 25, tablet: 20)),
                    subtitle: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomSelector(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 45),
                              radius: 10,
                              colors: secondaryColor,
                              isSelected: provider.gender == 'Male',
                              onPressed: () {
                                notifier.setGender('Male');
                              },
                              title: 'Male'),
                          const SizedBox(width: 10),
                          CustomSelector(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 45),
                              radius: 10,
                              colors: secondaryColor,
                              isSelected: provider.gender == 'Female',
                              onPressed: () {
                                notifier.setGender('Female');
                              },
                              title: 'Female'),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Which of the following best describes you?',
                        style: styles.textStyle(
                            mobile: 18, desktop: 25, tablet: 20)),
                    subtitle: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomSelector(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 45),
                              radius: 10,
                              colors: Colors.deepPurple,
                              isSelected: provider.userType == 'Student',
                              onPressed: () {
                                notifier.setUserType('Student');
                              },
                              title: 'Student'),
                          const SizedBox(width: 10),
                          CustomSelector(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 45),
                              radius: 10,
                              colors: Colors.deepPurple,
                              isSelected: provider.userType == 'Lecturer',
                              onPressed: () {
                                notifier.setUserType('Lecturer');
                              },
                              title: 'Lecturer'),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: provider.userType == 'Student',
                    child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text('What is your Indexnumber?',
                            style: styles.textStyle(
                                mobile: 18, desktop: 25, tablet: 20)),
                        subtitle: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: CustomTextFields(
                              max: 10,
                              isDigitOnly: true,
                              isPhoneInput: true,
                              keyboardType: TextInputType.number,
                              color: Colors.yellow[700]!,
                              hintText: 'Enter Program name',
                              onChanged: (value) {
                                notifier.setIndexNumber(value);
                              },
                            ))),
                  ),
                  Visibility(
                    visible: provider.userType == 'Student',
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('Which Level are you?',
                          style: styles.textStyle(
                              mobile: 18, desktop: 25, tablet: 20)),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            SizedBox(
                              width: 100,
                              child: CustomSelector(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  radius: 10,
                                  colors: Colors.green[800]!,
                                  isSelected: provider.level == '100',
                                  onPressed: () {
                                    notifier.setLevel('100');
                                  },
                                  title: '100'),
                            ),
                            SizedBox(
                              width: 100,
                              child: CustomSelector(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  radius: 10,
                                  colors: Colors.green[800]!,
                                  isSelected: provider.level == '200',
                                  onPressed: () {
                                    notifier.setLevel('200');
                                  },
                                  title: '200'),
                            ),
                            SizedBox(
                              width: 100,
                              child: CustomSelector(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  radius: 10,
                                  colors: Colors.green[800]!,
                                  isSelected: provider.level == '300',
                                  onPressed: () {
                                    notifier.setLevel('300');
                                  },
                                  title: '300'),
                            ),
                            SizedBox(
                              width: 100,
                              child: CustomSelector(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  radius: 10,
                                  colors: Colors.green[800]!,
                                  isSelected: provider.level == '400',
                                  onPressed: () {
                                    notifier.setLevel('400');
                                  },
                                  title: '400'),
                            ),
                            SizedBox(
                              width: 150,
                              child: CustomSelector(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  radius: 10,
                                  colors: Colors.green[800]!,
                                  isSelected: provider.level == 'Graduate',
                                  onPressed: () {
                                    notifier.setLevel('Graduate');
                                  },
                                  title: 'Graduate'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Select your Department?',
                        style: styles.textStyle(
                            mobile: 18, desktop: 25, tablet: 20)),
                    subtitle: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomDropDown(
                          hintText: 'Select Department',
                          color: Colors.teal,
                          value: provider.department,
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a department';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            notifier.setDepartment(value.toString());
                          },
                          items: departmentList
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                        )),
                  ),
                  Visibility(
                    visible: provider.userType == 'Student',
                    child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text('What Program do you offer?',
                            style: styles.textStyle(
                                mobile: 18, desktop: 25, tablet: 20)),
                        subtitle: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: CustomTextFields(
                              color: Colors.yellow[700]!,
                              hintText: 'Enter Program name',
                              onChanged: (value) {
                                notifier.setProgram(value);
                              },
                            ))),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (breakPoint.isMobile)
                TextButton.icon(
                  onPressed: () {
                     notifier.validateUserType(ref: ref);
                  },
                  icon: const Icon(Icons.arrow_forward_outlined),
                  label: Text(
                    'Continue',
                    style: styles.textStyle(fontWeight: FontWeight.w800),
                  ),
                )
              else
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      notifier.validateUserType(ref: ref);
                    },
                    text: 'Continue',
                    radius: 10,
                    color: primaryColor,
                    icon: const Icon(
                      Icons.arrow_forward_outlined,
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
