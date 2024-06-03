import 'package:firmer_city/features/auth/views/pages/registration_pages/bio_data_page.dart';
import 'package:firmer_city/features/auth/views/pages/registration_pages/user_type_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../provider/register_screen_provider.dart';

class RegistrationPage extends ConsumerStatefulWidget {
  const RegistrationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegistrationPageState();
}

class _RegistrationPageState extends ConsumerState<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Scaffold(
          body: Center(
            child: Card(
              elevation: 0,
              child: Container(
                decoration: const BoxDecoration(color: Colors.white),
                height: ResponsiveBreakpoints.of(context).screenHeight,
                width: ResponsiveBreakpoints.of(context).isMobile
                    ? ResponsiveBreakpoints.of(context).screenWidth
                    : ResponsiveBreakpoints.of(context).isTablet
                        ? ResponsiveBreakpoints.of(context).screenWidth * 0.8
                        : ResponsiveBreakpoints.of(context).screenWidth > 900 &&
                                ResponsiveBreakpoints.of(context).screenWidth <
                                    1280
                            ? ResponsiveBreakpoints.of(context).screenWidth *
                                0.6
                            : ResponsiveBreakpoints.of(context).screenWidth *
                                0.3,
                child: () {
                  switch (ref.watch(currentScreenProvider)) {
                    case 0:
                      return const UserTypeScreen();
                    case 1:
                      return  BioDataPage();

                    default:
                      return Container();
                  }
                }(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
