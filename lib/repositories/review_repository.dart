import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/review.dart';

class ReviewRepository {
  final _db = FirebaseFirestore.instance;

  Future<Review> addReview({
    required double mapX,
    required double mapY,
    required String content,
  }) async {
    final review = Review(
      id: const Uuid().v4(),
      content: content,
      mapX: mapX,
      mapY: mapY,
      createdAt: DateTime.now(),
    );

    await _db.collection('reviews').doc(review.id).set(review.toJson());

    return review;
  }

  Future<List<Review>> getReviews({
    required double mapX,
    required double mapY,
  }) async {
    final snapshot = await _db
        .collection('reviews')
        .where('mapX', isEqualTo: mapX)
        .where('mapY', isEqualTo: mapY)
        .get();

    return snapshot.docs.map((doc) => Review.fromJson(doc.data())).toList();
  }
}
