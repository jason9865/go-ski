import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_text.dart';
import 'package:goski_student/view_model/main_view_model.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class SelectResortBottomSheet extends StatelessWidget {
  final mainViewModel = Get.find<MainViewModel>();

  SelectResortBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final resortList = mainViewModel.skiResortList;

    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: screenSizeController.getHeightByRatio(0.5),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: resortList.length,
                itemBuilder: (context, index) {
                  return GoskiCard(
                    child: InkWell(
                      onTap: () {
                        mainViewModel.selectedSkiResort.value =
                            resortList[index];
                        mainViewModel.getWeather();
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(
                                screenSizeController.getHeightByRatio(0.025),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GoskiText(
                                    text: resortList[index].resortName,
                                    size: goskiFontMedium,
                                    isBold: true,
                                  ),
                                  SizedBox(
                                    height: screenSizeController
                                        .getHeightByRatio(0.005),
                                  ),
                                  GoskiText(
                                    text: resortList[index].resortLocation,
                                    size: goskiFontSmall,
                                    isBold: false,
                                    color: goskiDarkGray,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: screenSizeController.getHeightByRatio(0.01),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: screenSizeController.getHeightByRatio(0.03),
          ),
        ],
      ),
    );
  }
}
