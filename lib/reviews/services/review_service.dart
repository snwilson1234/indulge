import 'package:indulge/database/db_service.dart';
import 'package:indulge/reviews/models/review.dart';


class ReviewService {
  
  Future<int> insertReview(Review review) async {
    final db = await DatabaseService.database;
    return await db.insert('Review', review.toMap());
  }

  Future<List<Review>> getAllReviews() async {
    final db = await DatabaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('Review');

    return List.generate(maps.length, (i) {
      return Review.fromMap(maps[i]);
    });
  }

  Future<List<Review>> getReviewByRestaurantId(int restaurantId) async {
    final db = await DatabaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Review',
      where: 'restaurantId = ?',
      whereArgs: [restaurantId],
    );

    return List.generate(maps.length, (i) {
      return Review.fromMap(maps[i]);
    });
  }

  Future<int> updateReview(Review review) async {
    final db = await DatabaseService.database;
    return await db.update(
      'Review',
      review.toMap(),
      where: 'id = ?',
      whereArgs: [review.id],
    );
  }

  Future<int> deleteReview(int id) async {
    final db = await DatabaseService.database;
    return await db.delete(
      'Review',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}