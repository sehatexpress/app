import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:flutter/foundation.dart' show immutable;

@immutable
class CommentModel {
  final String? id;
  final String comment;
  final String? commntBy;

  const CommentModel({
    this.id,
    required this.comment,
    this.commntBy,
  });

  CommentModel copyWith({
    String? id,
    String? comment,
    String? commntBy,
  }) =>
      CommentModel(
        id: id ?? this.id,
        comment: comment ?? this.comment,
        commntBy: commntBy ?? this.commntBy,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'comment': comment,
        'commntBy': commntBy,
      };

  factory CommentModel.fromSnapshot(DocumentSnapshot snap) => CommentModel(
        id: snap.id,
        comment: snap['comment'],
        commntBy: snap['commntBy'],
      );

  @override
  String toString() =>
      'CommentModel(id: $id, comment: $comment, commntBy: $commntBy)';

  @override
  bool operator ==(covariant CommentModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.comment == comment &&
        other.commntBy == commntBy;
  }

  @override
  int get hashCode => id.hashCode ^ comment.hashCode ^ commntBy.hashCode;
}
