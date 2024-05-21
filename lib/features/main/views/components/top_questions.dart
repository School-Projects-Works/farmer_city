import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

class TopQuestions extends ConsumerStatefulWidget {
  const TopQuestions({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TopQuestionsState();
}

class _TopQuestionsState extends ConsumerState<TopQuestions> {

  @override
  Widget build(BuildContext context) {
    var breakPoint = ResponsiveBreakpoints.of(context);
    return Container(
      width:  breakPoint.screenWidth,
      child: Wrap(children: [],),
    );
  }
}