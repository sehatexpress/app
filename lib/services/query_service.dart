import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider;

import '../config/extensions.dart' show FirebaseErrorHandler;
import '../config/string_constants.dart' show CollectionConstants, Fields;
import '../models/comment_model.dart';
import '../models/query_model.dart';

class QueryService {
  final String uid;
  QueryService(this.uid);

  final _ref = CollectionConstants.queries;

  // submit query
  Future<void> submitQuery({
    required String name,
    required String phone,
    required String message,
  }) async {
    try {
      QueryModel query = QueryModel(
        uid: uid,
        message: message,
        phone: phone,
        name: name,
      );
      await _ref.add(query.toMap());
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // list all queries by user
  Stream<List<QueryModel>> getAllQueries() {
    try {
      return _ref
          .where(Fields.uid, isEqualTo: uid)
          .orderBy(Fields.createdAt, descending: true)
          .snapshots()
          .map(
            (docs) => docs.docs.map((e) => QueryModel.fromSnapshot(e)).toList(),
          );
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // get list of all comments for a query
  Stream<List<CommentModel>> getListOfComments(String docId) {
    try {
      return _ref
          .doc(docId)
          .collection('comments')
          .orderBy(Fields.createdAt, descending: true)
          .snapshots()
          .map(
            (docs) =>
                docs.docs.map((e) => CommentModel.fromSnapshot(e)).toList(),
          );
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }

  // comment query
  Future<void> commentQuery(String queryId, String comment) async {
    try {
      int updatedAt = DateTime.now().millisecondsSinceEpoch;
      CommentModel commentModel = CommentModel(comment: comment);

      // Add comment to the subcollection
      await _ref
          .doc(queryId)
          .collection('comments')
          .doc(updatedAt.toString())
          .set(commentModel.toMap());

      // Update query status
      await _ref.doc(queryId).update({
        Fields.status: 'in-process',
        Fields.updatedBy: uid,
        Fields.updatedAt: updatedAt,
      });
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }
}

final queryServiceProvider = Provider.family<QueryService, String>(
  (_, userId) => QueryService(userId),
);
