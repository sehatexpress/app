import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show ConsumerWidget, WidgetRef;

import '../../models/comment_model.dart';
import '../../providers/auth_provider.dart' show authUidProvider;

class CommentsListWidget extends ConsumerWidget {
  final List<CommentModel> comments;
  const CommentsListWidget({super.key, required this.comments});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(authUidProvider);
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      itemBuilder: (_, i) {
        bool currentUser = uid == comments[i].commntBy;
        return Row(
          mainAxisAlignment:
              currentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * .8,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(20),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ).copyWith(
                  bottomLeft: uid == comments[i].commntBy
                      ? Radius.zero
                      : const Radius.circular(10),
                  bottomRight:
                      !currentUser ? Radius.zero : const Radius.circular(10),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
              child: Text(
                comments[i].comment,
                maxLines: 10,
              ),
            ),
          ],
        );
      },
      separatorBuilder: (_, i) => const Divider(thickness: 0),
      itemCount: comments.length,
    );
  }
}
