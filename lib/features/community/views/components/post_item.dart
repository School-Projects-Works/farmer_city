import 'package:firmer_city/config/router/router_info.dart';
import 'package:firmer_city/core/functions/navigation.dart';
import 'package:firmer_city/core/functions/time_functions.dart';
import 'package:firmer_city/features/comments/provider/comments_provider.dart';
import 'package:firmer_city/features/community/data/community_post_model.dart';
import 'package:firmer_city/features/community/provider/post_provider.dart';
import 'package:firmer_city/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../auth/provider/login_provider.dart';

class PostItem extends ConsumerStatefulWidget {
  const PostItem(this.post, {super.key});
  final PostModel post;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostItemState();
}

class _PostItemState extends ConsumerState<PostItem> {
  @override
  Widget build(BuildContext context) {
    var breakPoint = ResponsiveBreakpoints.of(context);
    var styles = CustomStyles(context: context);
    var user = ref.watch(userProvider);
    var commentsStream = ref.watch(commentsStreamProvider(widget.post.id!));
    return InkWell(
      onTap: () {
        navigateToName(
            context: context,
            route: RouterInfo.postDetailRoute,
            parameter: {'id': widget.post.id ?? ''});
      },
      child: Card(
        child: Container(
          width: breakPoint.isMobile
              ? breakPoint.screenWidth
              : breakPoint.isTablet
                  ? breakPoint.screenWidth * .45
                  : breakPoint.screenWidth * .3,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                )
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.post.images.isNotEmpty)
                Container(
                  width: double.infinity,
                  height: 350,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(widget.post.images.isNotEmpty
                          ? widget.post.images.first
                          : ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: widget.post.authorId == user.id
                      ? IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            ref
                                .read(postProvider.notifier)
                                .deletePost(widget.post.id!);
                          },
                        )
                      : const SizedBox.shrink(),
                )
              else
                Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.white,
                  child: const Icon(
                    Icons.image,
                    color: Colors.grey,
                    size: 50,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.post.title?.toUpperCase() ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: styles.textStyle(
                    fontWeight: FontWeight.w700,
                    mobile: 16,
                    desktop: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage:
                              NetworkImage(widget.post.authorImage ?? ''),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.post.authorName ?? '',
                          style: styles.textStyle(
                            fontWeight: FontWeight.w500,
                            mobile: 14,
                            desktop: 16,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                        TimeUtils.formatDateTime(widget.post.createdAt!,
                            onlyDate: true),
                        style: styles.textStyle(
                          fontWeight: FontWeight.w500,
                          mobile: 13,
                          desktop: 14,
                          tablet: 11,
                          color: Colors.grey,
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.post.description ?? '',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: styles.textStyle(
                      fontWeight: FontWeight.w500,
                      mobile: 14,
                      desktop: 16,
                      color: Colors.grey,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: commentsStream.when(
                            loading: () => const SizedBox.shrink(),
                            error: (error, stack) => const SizedBox.shrink(),
                            data: (comments) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.comment,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Comments (${comments.length})',
                                    style: styles.textStyle(
                                      fontWeight: FontWeight.w500,
                                      mobile: 14,
                                      desktop: 16,
                                    ),
                                  ),
                                ],
                              );
                            })),
                    InkWell(
                      onTap: () {
                        //Todo like or unlike post
                      },
                      child: Row(
                        children: [
                          Icon(
                            widget.post.likes.contains(user.id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: widget.post.likes.contains(user.id)
                                ? Colors.red
                                : Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.post.likes.length.toString(),
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
            ],
          ),
        ),
      ),
    );
  }
}
