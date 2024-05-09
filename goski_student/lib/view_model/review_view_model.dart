import 'package:get/get.dart';
import 'package:goski_student/data/model/default_dto.dart';
import 'package:goski_student/data/model/review_request.dart';
import 'package:goski_student/data/model/review_tag_response.dart';
import 'package:goski_student/data/repository/review_repository.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class ReviewViewModel extends GetxController {
  final reviewRepository = Get.find<ReviewRepository>();
  final RxList<ReviewTag> reviewTagList = <ReviewTag>[].obs;
  final RxInt rating = 0.obs;
  final RxString content = ''.obs;
  final RxList<int> reviewTags = <int>[].obs;
  final RxList<bool> isSelected = <bool>[].obs;

  void initReview() {
    rating.value = 0;
    content.value = '';
    reviewTags.clear();
    isSelected.value = List.filled(reviewTagList.length, false);
  }

  Future<bool> writeReview(int lessonId) async {
    for (int i = 0; i < reviewTagList.length; i++) {
      if (isSelected[i]) {
        reviewTags.add(reviewTagList[i].tagReviewId);
      }
    }

    Review review = Review(
      lessonId: lessonId,
      rating: rating.value,
      content: content.value,
      reviewTags: reviewTags,
    );

    logger.d(review);

    DefaultDTO? response = await reviewRepository.writeReview(review);

    if (response != null && response.status == 'success') {
      return true;
    }

    return false;
  }

  Future<void> getReviewTagList() async {
    List<ReviewTag> response = await reviewRepository.getReviewTagList();
    reviewTagList.value = response;
  }
}
