import 'package:carousel_slider/carousel_slider.dart';
import 'package:firmer_city/core/functions/time_functions.dart';
import 'package:firmer_city/core/widget/custom_input.dart';
import 'package:firmer_city/features/auth/data/user_model.dart';
import 'package:firmer_city/features/auth/provider/login_provider.dart';
import 'package:firmer_city/features/comments/provider/comments_provider.dart';
import 'package:firmer_city/features/community/data/community_post_model.dart';
import 'package:firmer_city/features/community/provider/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/styles.dart';

class PostDetailPage extends ConsumerStatefulWidget {
  const PostDetailPage({super.key, required this.postId});
  final String postId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends ConsumerState<PostDetailPage> {
  @override
  Widget build(BuildContext context) {
    var post = ref.watch(getPostProvider(widget.postId));
    var user = ref.watch(userProvider);
    var styles = CustomStyles(context: context);
    var breakPoint = ResponsiveBreakpoints.of(context);
    return SizedBox(
      width: breakPoint.screenWidth,
      height: breakPoint.screenHeight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: post.when(data: (data) {
          if (data == null) {
            return const Center(
              child: Text('Post not found'),
            );
          }
          if (breakPoint.largerThan(TABLET)) {
            return Row(
              children: [
                Expanded(
                  child: _buildPostDetail(post: data, user: user),
                ),
                const SizedBox(width: 10),
                _buildSideList(user: user)
              ],
            );
          } else {
            return _buildPostDetail(post: data, user: user);
          }
        }, error: (error, stack) {
          return Center(
            child: Text('Error: $error'),
          );
        }, loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }

  final CarouselController pageController = CarouselController();
  final TextEditingController _commentController = TextEditingController();
  Widget _buildPostDetail({required PostModel post, required UserModel user}) {
    var styles = CustomStyles(context: context);
    var breakPoint = ResponsiveBreakpoints.of(context);
    var commentsStream = ref.watch(commentsStreamProvider(post.id!));
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  right: 5, left: breakPoint.largerThan(MOBILE) ? 25 : 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Image Section of the post
                  if (post.images.isNotEmpty)
                    //slide show of images with next and previous button
                    CarouselSlider(
                      carouselController: pageController,
                      options: CarouselOptions(
                          height: 400,
                          viewportFraction: 1.0,
                          autoPlay: false,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal),
                      items: post.images.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: breakPoint.screenWidth,
                                alignment: Alignment.bottomCenter,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(i), fit: BoxFit.fill),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      IconButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                          shape: MaterialStateProperty.all(
                                              const CircleBorder()),
                                        ),
                                        icon: const Icon(
                                            Icons.navigate_before_outlined),
                                        onPressed: () {
                                          pageController.previousPage(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeIn);
                                        },
                                      ),
                                      const SizedBox(width: 25),
                                      IconButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                          shape: MaterialStateProperty.all(
                                              const CircleBorder()),
                                        ),
                                        icon: const Icon(
                                            Icons.navigate_next_outlined),
                                        onPressed: () {
                                          pageController.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeIn);
                                        },
                                      ),
                                    ],
                                  ),
                                ));
                          },
                        );
                      }).toList(),
                    ),
                  //title of the post
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      post.title?.toUpperCase() ?? '',
                      style: styles.textStyle(
                          fontWeight: FontWeight.w700,
                          mobile: 22,
                          desktop: 30,
                          tablet: 28),
                    ),
                  ),
                  //description of the post
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      post.description ?? '',
                      textAlign: TextAlign.justify,
                      style: styles.textStyle(
                          fontWeight: FontWeight.w400,
                          mobile: 16,
                          desktop: 20,
                          height: 1.8,
                          tablet: 18),
                    ),
                  ),
                  //author of the post
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundImage:
                                  NetworkImage(post.authorImage ?? ''),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              post.authorName ?? '',
                              style: styles.textStyle(
                                fontWeight: FontWeight.w500,
                                mobile: 14,
                                desktop: 16,
                              ),
                            ),
                          ],
                        ),
                        if (breakPoint.smallerThan(TABLET))
                          const Spacer()
                        else
                          const SizedBox(width: 20),
                        Text(
                            TimeUtils.formatDateTime(post.createdAt!,
                                onlyDate: true),
                            style: styles.textStyle(
                              fontWeight: FontWeight.w500,
                              mobile: 13,
                              desktop: 14,
                              tablet: 11,
                              color: Colors.grey,
                            )),
                        if (breakPoint.largerThan(MOBILE)) const Spacer(),
                        if (breakPoint.largerThan(MOBILE))
                          InkWell(
                            onTap: () {
                              //Todo like or unlike post
                            },
                            child: Row(
                              children: [
                                Icon(
                                  post.likes.contains(user.id)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: post.likes.contains(user.id)
                                      ? Colors.red
                                      : Colors.grey,
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  post.likes.length.toString(),
                                  style: styles.textStyle(
                                    fontWeight: FontWeight.w500,
                                    mobile: 14,
                                    desktop: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  //Comments Section
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: commentsStream.when(data: (data) {
                        if (data.isEmpty) {
                          return const SizedBox(
                            height: 100,
                            child: Center(
                              child: Text('No comment yet'),
                            ),
                          );
                        }
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var comment = data[index];
                              return ListTile(
                                title: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: primaryColor,
                                      backgroundImage: comment
                                              .writerImage.isNotEmpty
                                          ? NetworkImage(comment.writerImage)
                                          : null,
                                      child: comment.writerImage.isEmpty
                                          ? const Icon(Icons.person)
                                          : null,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      comment.writerName,
                                      style: styles.textStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Text(
                                    comment.content,
                                    textAlign: TextAlign.justify,
                                    style: styles.textStyle(
                                        fontWeight: FontWeight.w400,
                                        height: 1.6),
                                  ),
                                ),
                              );
                            });
                      }, error: (error, stack) {
                        return const SizedBox(
                          height: 100,
                          child: Center(
                            child: Text('Unable to get Comments'),
                          ),
                        );
                      }, loading: () {
                        return const SizedBox(
                          height: 100,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      })),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: CustomTextFields(
            controller: _commentController,
            hintText: 'Add a comment',
            maxLines: 3,
            suffixIcon: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                //Todo add comment
              },
            ),
            onSubmitted: (value) {
              //Todo add comment
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSideList({required UserModel user}) {
    var styles = CustomStyles(context: context);
    var breakPoint = ResponsiveBreakpoints.of(context);
    return Container(
      width: breakPoint.screenWidth * .3,
    );
  }
}
