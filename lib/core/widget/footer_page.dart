import 'package:firmer_city/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

class FooterPage extends ConsumerWidget {
  const FooterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var breakPoint = ResponsiveBreakpoints.of(context);
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        color: primaryColor,
        child: breakPoint.largerThan(MOBILE)
            ? const Row(
                children: [
                  Text('© 2024 Firmer City. All rights reserved.',
                      style: TextStyle(color: Colors.white)),
                  Spacer(),
                  Text('Privacy Policy', style: TextStyle(color: Colors.white)),
                  SizedBox(width: 25),
                  Text('Terms of Service',
                      style: TextStyle(color: Colors.white)),
                ],
              )
            : const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Privacy Policy',
                          style: TextStyle(color: Colors.white)),
                      SizedBox(width: 25),
                      Text('Terms of Service',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('© 2024 Firmer City. All rights reserved.',
                      style: TextStyle(color: Colors.white)),
                ],
              ));
  }
}
