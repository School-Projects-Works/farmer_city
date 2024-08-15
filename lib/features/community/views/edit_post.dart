import 'package:firmer_city/config/router/router_info.dart';
import 'package:firmer_city/core/widget/custom_button.dart';
import 'package:firmer_city/core/widget/custom_input.dart';
import 'package:firmer_city/features/auth/provider/login_provider.dart';
import 'package:firmer_city/features/community/provider/community_provider.dart';
import 'package:firmer_city/utils/colors.dart';
import 'package:firmer_city/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../config/router/router.dart';

class EditPost extends ConsumerStatefulWidget {
  const EditPost({super.key, required this.postId});
  final String postId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditPostState();
}

class _EditPostState extends ConsumerState<EditPost> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var notifier = ref.read(editPostProvider.notifier);
    var breakPoint = ResponsiveBreakpoints.of(context);
    var styles = Styles(context);
    var user = ref.watch(userProvider);
    var post = ref.watch(selectedPost(widget.postId));
    //check if widget is done building
    return Container(
        padding:
            const EdgeInsets.only(top: 100, left: 15, right: 15, bottom: 15),
        alignment: Alignment.topCenter,
        child: Container(
          width: breakPoint.isMobile
              ? double.infinity
              : breakPoint.isTablet
                  ? breakPoint.screenWidth * 0.6
                  : breakPoint.screenWidth * 0.4,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: post.when(
                  data: (post) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            //back button
                            IconButton(
                              onPressed: () {
                                MyRouter(context: context, ref: ref)
                                    .navigateToRoute(RouterInfo.communityRoute);
                              },
                              icon: const Icon(Icons.close),
                              iconSize: 30,
                              color: primaryColor,
                            ),
                            Expanded(
                              child: Text(
                                'Edit post',
                                textAlign: TextAlign.center,
                                style: styles.body(
                                    fontWeight: FontWeight.bold,
                                    mobile: 30,
                                    desktop: 36,
                                    tablet: 34,
                                    color: primaryColor),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          thickness: 3,
                          color: primaryColor,
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        CustomTextFields(
                          label: 'Post Title',
                          hintText: 'Enter post title',
                          controller: TextEditingController(text: post!.title),
                          onSaved: (value) {
                            notifier.setTitle(value);
                          },
                          validator: (title) {
                            if (title!.isEmpty) {
                              return 'Title is required';
                            } else if (title.length < 5) {
                              return 'Title must be at least 5 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        CustomTextFields(
                          label: 'Post Content',
                          controller:
                              TextEditingController(text: post.description),
                          hintText: 'Enter post content',
                          onSaved: (value) {
                            notifier.setContent(value);
                          },
                          validator: (content) {
                            if (content!.isEmpty) {
                              return 'Content is required';
                            } else if (content.length < 10) {
                              return 'Content must be at least 10 characters';
                            }
                            return null;
                          },
                          maxLines: 5,
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        CustomButton(
                          text: 'Update Post',
                          icon: MdiIcons.update,
                          onPressed: () {
                            if (user.id == null) {
                              MyRouter(context: context, ref: ref)
                                  .navigateToRoute(RouterInfo.loginRoute);
                              return;
                            }
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              notifier.updatePost(
                                ref: ref,
                                context: context,
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (error, stack) => Center(
                    child: Text('Error: $error'),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
