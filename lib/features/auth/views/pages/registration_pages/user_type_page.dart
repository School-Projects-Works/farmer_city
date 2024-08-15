import 'package:firmer_city/config/router/router.dart';
import 'package:firmer_city/config/router/router_info.dart';
import 'package:firmer_city/features/auth/provider/register_screen_provider.dart';
import 'package:firmer_city/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
    var styles = Styles(context);
    var provider = ref.watch(newUserProvider);
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('Which of the following best describes you?',
                          style:
                              styles.body(mobile: 18, desktop: 25, tablet: 20)),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          spacing: 10,
                          runAlignment: WrapAlignment.start,
                          runSpacing: 10,
                          children: [
                            CustomSelector(
                                width: 130,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                radius: 10,
                                colors: Colors.deepPurple,
                                isSelected: provider.userType == 'Farmer',
                                icon: MdiIcons.cow,
                                onPressed: () {
                                  notifier.setUserType('Farmer');
                                },
                                title: 'Farmer'),
                            CustomSelector(
                                width: 140,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                radius: 10,
                                colors: Colors.deepPurple,
                                isSelected: provider.userType == 'Consumer',
                                icon: MdiIcons.account,
                                onPressed: () {
                                  notifier.setUserType('Consumer');
                                },
                                title: 'Consumer'),
                            CustomSelector(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                radius: 10,
                                colors: Colors.deepPurple,
                                isSelected: provider.userType == 'Farm Expert',
                                icon: MdiIcons.accountGroup,
                                onPressed: () {
                                  notifier.setUserType('Farm Expert');
                                },
                                title: 'Farm Expert'),
                            CustomSelector(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                radius: 10,
                                width: 160,
                                colors: Colors.deepPurple,
                                isSelected:
                                    provider.userType == 'Agric Officer',
                                icon: MdiIcons.accountStar,
                                onPressed: () {
                                  notifier.setUserType('Agric Officer');
                                },
                                title: 'Agric Officer'),
                            CustomSelector(
                                width: 130,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                radius: 10,
                                colors: Colors.deepPurple,
                                isSelected: provider.userType == 'Investor',
                                icon: MdiIcons.accountCash,
                                onPressed: () {
                                  notifier.setUserType('Investor');
                                },
                                title: 'Investor'),
                            CustomSelector(
                                width: 200,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                radius: 10,
                                colors: Colors.deepPurple,
                                isSelected:
                                    provider.userType == 'Agric Input Dealer',
                                icon: MdiIcons.accountTie,
                                onPressed: () {
                                  notifier.setUserType('Agric Input Dealer');
                                },
                                title: 'Agric Input Dealer'),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('What is your gender ?',
                          style:
                              styles.body(mobile: 18, desktop: 25, tablet: 20)),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          spacing: 10,
                          runAlignment: WrapAlignment.start,
                          runSpacing: 10,
                          children: [
                            CustomSelector(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                radius: 10,
                                icon: MdiIcons.genderMale,
                                colors: secondaryColor,
                                isSelected: provider.gender == 'Male',
                                onPressed: () {
                                  notifier.setGender('Male');
                                },
                                title: 'Male'),
                            CustomSelector(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 45),
                                radius: 10,
                                colors: secondaryColor,
                                isSelected: provider.gender == 'Female',
                                icon: MdiIcons.genderFemale,
                                onPressed: () {
                                  notifier.setGender('Female');
                                },
                                title: 'Female'),
                          ],
                        ),
                      ),
                    ),
                    ResponsiveVisibility(
                        visible: provider.userType == 'Farmer',
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text('Which of these do you produce?',
                              style: styles.body(
                                  mobile: 18, desktop: 25, tablet: 20)),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              spacing: 10,
                              runAlignment: WrapAlignment.start,
                              runSpacing: 10,
                              children: [
                                CustomSelector(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    radius: 10,
                                    width: 150,
                                    colors: Colors.indigo,
                                    isSelected:
                                        provider.farmType.contains('Crops'),
                                    icon: MdiIcons.sprout,
                                    onPressed: () {
                                      notifier.addFarmType('Crops');
                                    },
                                    title: 'Crops'),
                                CustomSelector(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    radius: 10,
                                    width: 150,
                                    colors: Colors.indigo,
                                    isSelected:
                                        provider.farmType.contains('Livestock'),
                                    icon: MdiIcons.cow,
                                    onPressed: () {
                                      notifier.addFarmType('Livestock');
                                    },
                                    title: 'Livestock'),
                                CustomSelector(
                                    width: 150,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    radius: 10,
                                    colors: Colors.indigo,
                                    isSelected:
                                        provider.farmType.contains('Fishery'),
                                    icon: MdiIcons.fish,
                                    onPressed: () {
                                      notifier.addFarmType('Fishery');
                                    },
                                    title: 'Fishery'),
                              ],
                            ),
                          ),
                        )),
                    ResponsiveVisibility(
                        visible: provider.farmType.contains('Livestock'),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                              'Which of these Livestock do you produce?',
                              style: styles.body(
                                  mobile: 18, desktop: 25, tablet: 20)),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              spacing: 10,
                              runAlignment: WrapAlignment.start,
                              runSpacing: 10,
                              children: [
                                CustomSelector(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    radius: 10,
                                    width: 120,
                                    colors: primaryColor,
                                    isSelected:
                                        provider.productType.contains('Cattle'),
                                    icon: MdiIcons.cow,
                                    onPressed: () {
                                      notifier.addProduct('Cattle');
                                    },
                                    title: 'Cattle'),
                                CustomSelector(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    radius: 10,
                                    width: 120,
                                    colors: primaryColor,
                                    isSelected:
                                        provider.productType.contains('Pigs'),
                                    icon: MdiIcons.pigVariant,
                                    onPressed: () {
                                      notifier.addProduct('Pigs');
                                    },
                                    title: 'Pigs'),
                                CustomSelector(
                                    width: 150,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    radius: 10,
                                    colors: primaryColor,
                                    isSelected: provider.productType
                                        .contains('Poultry'),
                                    icon: MdiIcons.bird,
                                    onPressed: () {
                                      notifier.addProduct('Poultry');
                                    },
                                    title: 'Poultry'),
                              ],
                            ),
                          ),
                        )),
                    ResponsiveVisibility(
                        visible: provider.farmType.contains('Crops'),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text('Which of these Crops do you produce?',
                              style: styles.body(
                                  mobile: 18, desktop: 25, tablet: 20)),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              spacing: 10,
                              runAlignment: WrapAlignment.start,
                              runSpacing: 10,
                              children: [
                                CustomSelector(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    radius: 10,
                                    width: 120,
                                    colors: primaryColor,
                                    isSelected: provider.productType
                                        .contains('Cereals'),
                                    icon: MdiIcons.corn,
                                    onPressed: () {
                                      notifier.addProduct('Cereals');
                                    },
                                    title: 'Cereals'),
                                CustomSelector(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    radius: 10,
                                    width: 140,
                                    colors: primaryColor,
                                    isSelected: provider.productType
                                        .contains('Vegetables'),
                                    icon: MdiIcons.carrot,
                                    onPressed: () {
                                      notifier.addProduct('Vegetables');
                                    },
                                    title: 'Vegetables'),
                                CustomSelector(
                                    width: 150,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    radius: 10,
                                    colors: primaryColor,
                                    isSelected:
                                        provider.productType.contains('Fruits'),
                                    icon: MdiIcons.foodApple,
                                    onPressed: () {
                                      notifier.addProduct('Fruits');
                                    },
                                    title: 'Fruits'),
                                CustomSelector(
                                    width: 150,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    radius: 10,
                                    colors: primaryColor,
                                    isSelected:
                                        provider.productType.contains('Others'),
                                    icon: MdiIcons.foodVariant,
                                    onPressed: () {
                                      notifier.addProduct('Others');
                                    },
                                    title: 'Others'),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
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
                    style: styles.body(fontWeight: FontWeight.w800),
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
                    icon: Icons.arrow_forward_outlined,
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
