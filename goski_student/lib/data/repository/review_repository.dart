import 'package:get/get.dart';
import 'package:goski_student/data/data_source/review_service.dart';
import 'package:goski_student/data/model/default_dto.dart';
import 'package:goski_student/data/model/review_request.dart';
import 'package:goski_student/data/model/review_tag_response.dart';

class ReviewRepository {
  final reviewService = Get.find<ReviewService>();

  Future<DefaultDTO?> writeReview(Review review) async {
    return reviewService.writeReview(review.toReviewRequest());
  }

  Future<List<ReviewTag>> getReviewTagList() async {
    List<ReviewTagResponse> reviewTagResponse =
        await reviewService.getReviewTagList();

    return reviewTagResponse
        .map<ReviewTag>((response) => response.toReviewTag())
        .toList();
  }
}
