import 'package:get/get.dart';
import 'package:goski_instructor/data/model/review_response.dart';
import 'package:goski_instructor/data/repository/review_repository.dart';

class ReviewViewModel extends GetxController {
  final ReviewRepository reviewRepository = Get.find<ReviewRepository>();
  RxList<Review> reviewList = <Review>[].obs;
  RxBool isLoadingReviewList = true.obs;

  Future<void> getReviewList() async {
    isLoadingReviewList.value = true;
    List<Review> response = await reviewRepository.getReviewList();

    reviewList.value = response.toList();
    isLoadingReviewList.value = false;
  }
}
