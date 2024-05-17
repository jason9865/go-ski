import 'package:get/get.dart';
import 'package:goski_instructor/data/data_source/review_service.dart';
import 'package:goski_instructor/data/model/review_response.dart';

class ReviewRepository {
  final reviewService = Get.find<ReviewService>();

  Future<List<Review>> getReviewList() async {
    List<ReviewResponse> reviewResponse = await reviewService.getReviewList();

    return reviewResponse
        .map<Review>((response) => response.toReviewList())
        .toList();
  }
}
