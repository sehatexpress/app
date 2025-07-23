import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider;

import '../config/extensions.dart' show FirebaseErrorHandler;
import '../config/string_constants.dart'
    show CollectionConstants, FirestoreFields;
import '../models/comment_model.dart';
import '../models/query_model.dart';

class QueryService {
  final String uid;
  QueryService(this.uid);

  final _ref = CollectionConstants.queries;

  // submit query
  Future<void> submitQuery({
    required String name,
    required String mobile,
    required String message,
  }) async {
    try {
      QueryModel query = QueryModel(
        uid: uid,
        message: message,
        mobile: mobile,
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
          .where(FirestoreFields.uid, isEqualTo: uid)
          .orderBy(FirestoreFields.createdAt, descending: true)
          .snapshots()
          .map((docs) =>
              docs.docs.map((e) => QueryModel.fromSnapshot(e)).toList());
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
          .orderBy(FirestoreFields.createdAt, descending: true)
          .snapshots()
          .map((docs) =>
              docs.docs.map((e) => CommentModel.fromSnapshot(e)).toList());
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
        FirestoreFields.status: 'in-process',
        FirestoreFields.updatedBy: uid,
        FirestoreFields.updatedAt: updatedAt,
      });
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }
}

final queryServiceProvider =
    Provider.family<QueryService, String>((_, userId) => QueryService(userId));
