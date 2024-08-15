import 'package:firmer_city/config/router/router.dart';
import 'package:firmer_city/config/router/router_info.dart';
import 'package:firmer_city/features/community/provider/community_provider.dart';
import 'package:firmer_city/utils/colors.dart';
import 'package:firmer_city/utils/styles.dart';
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
    var post = ref.watch(postStream);
    var styles = Styles(context);
    return Container(
      width: breakPoint.screenWidth * 0.3,
      height: breakPoint.screenHeight,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top Questions',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(
            color: primaryColor,
            thickness: 3,
          ),
          Expanded(
              child: post.when(data: (data) {
            return () {
              if (data.isEmpty) {
                return const Center(child: Text('No data'));
              }
              var topQuestions = data.length > 5 ? data.sublist(0, 5) : data;
              return Column(
                children: topQuestions
                    .map((e) => ListTile(
                          onTap: () {
                            MyRouter(context: context, ref: ref)
                                .navigateToNamed(
                                    pathParms: {'id': e.id!},
                                    item: RouterInfo.postDetailRoute);
                          },
                          title: Text(
                            e.title ?? 'No title',
                            maxLines: 2,
                            style: styles.body(
                                mobile: 15,
                                desktop: 15,
                                tablet: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            e.description ?? '',
                            maxLines: 3,
                          ),
                        ))
                    .toList(),
              );
            }();
          }, error: (error, stack) {
            return Center(child: Text('Error: $error'));
          }, loading: () {
            return const Center(child: CircularProgressIndicator());
          }))
        ],
      ),
    );
  }
}
