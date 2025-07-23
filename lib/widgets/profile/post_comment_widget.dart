import 'package:flutter/material.dart';

import '../inputs/custom_input_widget.dart';

class PostCommentWidget extends StatelessWidget {
  final String queryId;
  const PostCommentWidget({
    super.key,
    required this.queryId,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController comment = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(16.0).copyWith(top: 8),
      child: CustomInputWidget(
        controller: comment,
        hintText: 'Comment back...',
        suffixIcon: IconButton(
          onPressed: null,
          // onPressed: () => queryService
          //     .commentQuery(queryId, comment.text.trim())
          //     .then((_) => comment.clear()),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            iconColor: Colors.green,
          ),
          icon: const Icon(Icons.send),
        ),
      ),
    );
  }
}
