import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../core/widget/custom_button.dart';
import '../../../../../core/widget/custom_selector.dart';
import '../../../../../utils/styles.dart';
import '../../../provider/new_user_provider.dart';

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
