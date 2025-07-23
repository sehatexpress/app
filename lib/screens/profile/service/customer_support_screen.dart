import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../config/extensions.dart'
    show DateTimeExtensions, ScreenTypeExtension;
import '../../../config/typo_config.dart' show typoConfig;
import '../../../providers/lists_provider.dart'
    show queryCommentsListProvider, queryListProvider;
import '../../../widgets/generic/loader_widget.dart';
import '../../../widgets/profile/post_comment_widget.dart';
import '../../../widgets/profile/comments_list_widget.dart';
import 'raise_query_screen.dart';

class CustomerSupportScreen extends ConsumerWidget {
  const CustomerSupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lists = ref.watch(queryListProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Support'),
        actions: [
          TextButton.icon(
            icon: Icon(
              Icons.add_rounded,
              color: Colors.white,
            ),
            label: Text(
              'Raise Query',
              style: typoConfig.textStyle.largeCaptionLabel3Regular
                  .copyWith(color: Colors.white),
            ),
            onPressed: () => context.push(const RaiseQueryScreen()),
          ),
        ],
      ),
      body: lists.when(
        data: (data) {
          if (data.isEmpty) {
            return Center(
              child: Text('No query found!'),
            );
          }
          return ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16),
            itemBuilder: (_, i) {
              final query = data[i];
              return GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  useSafeArea: true,
                  constraints: const BoxConstraints(
                    maxHeight: double.infinity,
                  ),
                  scrollControlDisabledMaxHeightRatio: 1,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Column(
                        children: [
                          // PostCommentTitleWidget(query: query),
                          Expanded(
                            child: ref
                                .watch(queryCommentsListProvider(query.id!))
                                .when(
                                  data: (comments) {
                                    if (comments.isEmpty) {
                                      return Center(
                                        child: Text('No comments found!'),
                                      );
                                    }
                                    return CommentsListWidget(
                                      comments: comments,
                                    );
                                  },
                                  error: (error, stackTrace) => Center(
                                    child: Text(
                                      error.toString(),
                                      maxLines: 5,
                                    ),
                                  ),
                                  loading: () => const Center(
                                    child: LoaderWidget(),
                                  ),
                                ),
                          ),
                          PostCommentWidget(
                            queryId: query.id!,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${query.createdAt!.formattedDate} ${query.createdAt!.formattedTime}',
                        style: typoConfig.textStyle.smallSmall.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        query.message,
                        maxLines: 10,
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, i) => const SizedBox(height: 12),
            itemCount: data.length,
          );
        },
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
        loading: () => Center(
          child: LoaderWidget(),
        ),
      ),
    );
  }
}
