import 'package:firmer_city/config/router/router.dart';
import 'package:firmer_city/config/router/router_info.dart';
import 'package:firmer_city/core/functions/time_functions.dart';
import 'package:firmer_city/core/widget/custom_dialog.dart';
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
    var styles = Styles(context);
    var user = ref.watch(userProvider);
    var commentsStream = ref.watch(commentsStreamProvider(widget.post.id!));
    return InkWell(
      onTap: () {
        MyRouter(context: context, ref: ref).navigateToNamed(
            item: RouterInfo.postDetailRoute,
            pathParms: {'id': widget.post.id ?? ''});
      },
      child: Card(
        child: Container(
          // height: 450,
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
              if (widget.post.images.isNotEmpty &&
                  widget.post.images.first.isNotEmpty)
                Expanded(
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.topRight,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(widget.post.images.first),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: widget.post.authorId == user.id
                        ? PopupMenuButton<int>(
                            itemBuilder: (context) {
                              return [
                                const PopupMenuItem(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  value: 0,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(width: 5),
                                      Text('Edit'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  value: 1,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      SizedBox(width: 5),
                                      Text('Delete'),
                                    ],
                                  ),
                                ),
                              ];
                            },
                            onSelected: (value) {
                              if (value == 0) {
                                MyRouter(context: context, ref: ref)
                                    .navigateToNamed(
                                        item: RouterInfo.editPostRoute,
                                        pathParms: {'id': widget.post.id!});
                              } else {
                                CustomDialog.showInfo(
                                    message:
                                        'Are you sure you want to delete this post?',
                                    buttonText: 'Delete',
                                    onPressed: () {
                                      ref
                                          .read(postProvider.notifier)
                                          .deletePost(widget.post.id!);
                                    });
                              }
                            },
                          )
                        : const SizedBox.shrink(),
                  ),
                )
              else
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Stack(
                      children: [
                        if (widget.post.authorId == user.id)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: PopupMenuButton<int>(
                              itemBuilder: (context) {
                                return [
                                  const PopupMenuItem(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    value: 0,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        ),
                                        SizedBox(width: 5),
                                        Text('Edit'),
                                      ],
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    value: 1,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        SizedBox(width: 5),
                                        Text('Delete'),
                                      ],
                                    ),
                                  ),
                                ];
                              },
                              onSelected: (value) {
                                if (value == 0) {
                                  MyRouter(context: context, ref: ref)
                                      .navigateToNamed(
                                          item: RouterInfo.editPostRoute,
                                          pathParms: {'id': widget.post.id!});
                                } else {
                                  CustomDialog.showInfo(
                                      message:
                                          'Are you sure you want to delete this post?',
                                      buttonText: 'Delete',
                                      onPressed: () {
                                        ref
                                            .read(postProvider.notifier)
                                            .deletePost(widget.post.id!);
                                      });
                                }
                              },
                            ),
                          ),
                        const Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Icon(
                            Icons.image,
                            color: Colors.grey,
                            size: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.post.title?.toUpperCase() ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: styles.body(
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
                          style: styles.body(
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
                        style: styles.body(
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
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: styles.body(
                      fontWeight: FontWeight.w500,
                      mobile: 14,
                      desktop: 15,
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
                                    style: styles.body(
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
                            style: styles.body(
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
