import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/review.dart';

class ReviewRepository {
  final _db = FirebaseFirestore.instance;

  Future<void> addReview(Review review) async {
    await _db.collection('reviews').add(review.toJson());
  }

  Future<List<Review>> fetchReviews(double mapX, double mapY) async {
    final query = await _db
        .collection('reviews')
        .where('mapX', isEqualTo: mapX)
        .where('mapY', isEqualTo: mapY)
        .orderBy('createdAt', descending: true)
        .get();

    return query.docs.map((doc) => Review.fromJson(doc.data())).toList();
  }
}
