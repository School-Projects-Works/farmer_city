import 'package:firmer_city/config/router/router.dart';
import 'package:firmer_city/config/router/router_info.dart';
import 'package:firmer_city/core/widget/custom_button.dart';
import 'package:firmer_city/core/widget/custom_input.dart';
import 'package:firmer_city/core/widget/footer_page.dart';
import 'package:firmer_city/features/auth/provider/login_provider.dart';
import 'package:firmer_city/features/community/provider/community_provider.dart';
import 'package:firmer_city/features/community/provider/switch_provider.dart';
import 'package:firmer_city/utils/colors.dart';
import 'package:firmer_city/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../provider/post_provider.dart';
import 'components/post_item.dart';

class CommunityPage extends ConsumerStatefulWidget {
  const CommunityPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommunityPageState();
}

class _CommunityPageState extends ConsumerState<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    var post = ref.watch(postStream);
    var breakPoint = ResponsiveBreakpoints.of(context);
    var styles = Styles(context);
    var user = ref.watch(userProvider);
    return Container(
      width: breakPoint.screenWidth,
      height: breakPoint.screenHeight,
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 70,
                left: 5,
                right: 5,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          if (breakPoint.smallerThan(DESKTOP) &&
                              ref.watch(isSearching))
                            const SizedBox.shrink()
                          else
                            Text(
                              'Recent Posts',
                              style: styles.body(
                                  fontWeight: FontWeight.bold,
                                  mobile: 30,
                                  desktop: 36,
                                  tablet: 34,
                                  color: primaryColor),
                            ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (breakPoint.largerOrEqualTo(DESKTOP))
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: breakPoint.screenWidth * .3,
                                        child: CustomTextFields(
                                          hintText: 'Search post',
                                          onChanged: (value) {
                                            ref
                                                .read(filterProvider.notifier)
                                                .state = value;
                                          },
                                          suffixIcon: const Icon(Icons.search),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      CustomButton(
                                          text: 'Ask Community',
                                          color: secondaryColor,
                                          icon: Icons.add,
                                          onPressed: () {
                                            if (user.id == null) {
                                              MyRouter(
                                                      context: context,
                                                      ref: ref)
                                                  .navigateToRoute(
                                                      RouterInfo.loginRoute);
                                              return;
                                            }
                                            MyRouter(context: context, ref: ref)
                                                .navigateToRoute(
                                                    RouterInfo.createPostRoute);
                                          }),
                                    ],
                                  ),
                                if (breakPoint.smallerThan(DESKTOP))
                                  if (ref.watch(isSearching))
                                    SizedBox(
                                      width: breakPoint.isMobile
                                          ? double.infinity
                                          : breakPoint.screenWidth * .6,
                                      child: CustomTextFields(
                                        hintText: 'Search post',
                                        onChanged: (value) {
                                          ref
                                              .read(filterProvider.notifier)
                                              .state = value;
                                        },
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            ref
                                                .read(filterProvider.notifier)
                                                .state = '';
                                            ref
                                                .read(isSearching.notifier)
                                                .state = false;
                                          },
                                          icon: const Icon(Icons.close),
                                        ),
                                      ),
                                    )
                                  else
                                    Row(
                                      children: [
                                        CustomButton(
                                          text: '',
                                          radius: 10,
                                          onPressed: () {
                                            ref
                                                .read(isSearching.notifier)
                                                .state = true;
                                          },
                                          icon: Icons.search,
                                          color: primaryColor,
                                        ),
                                        const SizedBox(width: 10),
                                        CustomButton(
                                          text: '',
                                          radius: 10,
                                          onPressed: () {
                                            if (user.id == null) {
                                              MyRouter(
                                                      context: context,
                                                      ref: ref)
                                                  .navigateToRoute(
                                                      RouterInfo.loginRoute);
                                              return;
                                            }
                                            MyRouter(context: context, ref: ref)
                                                .navigateToRoute(
                                                    RouterInfo.createPostRoute);
                                          },
                                          icon: Icons.add,
                                          color: secondaryColor,
                                        ),
                                      ],
                                    ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      post.when(data: (data) {
                        var filterdPost = ref.watch(filteredPostProvider);
                        if (filterdPost.isEmpty) {
                          return const Center(
                            child: Text('No post available'),
                          );
                        }
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: breakPoint.screenWidth <= 600
                                ? 1
                                : breakPoint.screenWidth > 600 &&
                                        breakPoint.screenWidth <= 900
                                    ? 2
                                    : breakPoint.screenWidth > 900 &&
                                            breakPoint.screenWidth <= 1300
                                        ? 3
                                        : 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.9,
                          ),
                          itemCount: filterdPost.length,
                          itemBuilder: (context, index) =>
                              PostItem(filterdPost[index]),
                        );
                      }, error: (error, stack) {
                        return const Center(
                          child: Text('Unable to get post '),
                        );
                      }, loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const FooterPage()
        ],
      ),
    );
  }
}
