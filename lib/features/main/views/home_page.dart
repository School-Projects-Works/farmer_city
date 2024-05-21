import 'package:firmer_city/core/widget/footer_page.dart';
import 'package:firmer_city/features/main/views/components/featured_products.dart';
import 'package:firmer_city/features/main/views/components/landing_page.dart';
import 'package:firmer_city/features/main/views/components/top_questions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    var breakPoint = ResponsiveBreakpoints.of(context);
    return SizedBox(
      width: breakPoint.screenWidth,
      height: breakPoint.screenHeight,
      child:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Column(
            children: [
              LandingPage(),
              const FeaturedProducts(),
              const TopQuestions(),
              const FooterPage(),
            ],
          ),
        ),
      ),
    );
  }
}
