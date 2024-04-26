import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:goski_instructor/ui/common/d_i018_add_external_schedule.dart';
import 'package:goski_instructor/ui/component/goski_bottomsheet.dart';
import 'package:goski_instructor/ui/component/goski_build_interval.dart';
import 'package:goski_instructor/ui/component/goski_card.dart';
import 'package:goski_instructor/ui/component/goski_container.dart';
import 'package:goski_instructor/ui/component/goski_day_checkbox.dart';
import 'package:goski_instructor/ui/component/goski_modal.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';
import 'package:goski_instructor/ui/component/goski_textfield.dart';
import 'package:goski_instructor/ui/instructor/d_i013_lesson_detail.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();
final screenSizeController = Get.find<ScreenSizeController>();

class UpdateTeamScreen extends StatefulWidget {
  const UpdateTeamScreen({super.key});

  @override
  State<UpdateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<UpdateTeamScreen> {
  String teamImage = "assets/images/person1.png";
  List<String> teamIntroductionImages = [
    "assets/images/person3.png",
    "assets/images/person3.png",
    "assets/images/person3.png"
  ]; // 팀 소개 이미지 경로를 저장하는 리스트
  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  @override
  Widget build(BuildContext context) {
    return GoskiContainer(
      onConfirm: () => 0,
      buttonName: "update",
      child: SingleChildScrollView(
        child: GoskiCard(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                buildRegisterTeamImage(),
                const BuildInterval(),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenSizeController.getWidthByRatio(0.01)),
                  child: Row(
                    children: [
                      GoskiText(
                        text: tr('teamName'),
                        size: goskiFontLarge,
                        isBold: true,
                        isExpanded: true,
                      ),
                      GoskiTextField(
                        width: screenSizeController.getWidthByRatio(0.6),
                        hintText: tr('팀 이름1'),
                        canEdit: false,
                      ),
                    ],
                  ),
                ),
                const BuildInterval(),
                buildSelectSkiResort(),
                const BuildInterval(),
                buildTeamIntroduction(),
                const BuildInterval(),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GoskiText(
                          text: tr("teamIntroductionImage"),
                          size: goskiFontLarge,
                          isBold: true,
                          isExpanded: true,
                        ),
                        IconButton(
                          onPressed: pickTeamIntroductionImage,
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    teamIntroductionImages.isNotEmpty
                        ? buildTeamIntroductionImageList()
                        : Container(),
                  ],
                ),
                const BuildInterval(),
                buildTeamPriceSetting(),
                const BuildInterval(),
                buildHolidaySetting(),
                Padding(
                  padding: EdgeInsets.all(
                      screenSizeController.getHeightByRatio(0.01)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        tr('deleteTeam'),
                        style: const TextStyle(
                          fontSize: goskiFontMedium,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                          color: goskiDarkGray,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRegisterTeamImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: screenSizeController.getWidthByRatio(0.45),
          height: screenSizeController.getHeightByRatio(0.16),
          decoration: BoxDecoration(
            border: Border.all(color: goskiLightGray, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(14), // Container borderRadius - 1
            child: teamImage == ""
                ? const Icon(Icons.photo, size: 50, color: Colors.grey)
                : Image.asset(teamImage, fit: BoxFit.cover),
          ),
        ),
        SizedBox(height: screenSizeController.getHeightByRatio(0.005)),
        GestureDetector(
          onTap: pickTeamImage,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.photo_outlined),
              GoskiText(
                text: tr("registerProfileImage"),
                size: goskiFontSmall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> pickTeamImage() async {
    // 추후에 디바이스에서 사진 가져올 때 사용할 변수들
    // final ImagePicker picker = ImagePicker();
    // final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      // 일단 assets 폴더에 있는 이미지의 경로를 리스트에 추가
      teamImage = "assets/images/person1.png";
    });
  }

  Future<void> pickTeamIntroductionImage() async {
    // 추후에 디바이스에서 사진 가져올 때 사용할 변수들
    // final ImagePicker picker = ImagePicker();
    // final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      // 일단 assets 폴더에 있는 이미지의 경로를 리스트에 추가
      teamIntroductionImages.add("assets/images/person3.png");
    });
  }

  void removeTeamIntroductionImage(int index) {
    setState(() {
      teamIntroductionImages.removeAt(index);
    });
  }

  Widget buildSelectSkiResort() {
    return Row(
      children: [
        GoskiText(
          text: tr('skiResort'),
          size: goskiFontLarge,
          isBold: true,
          isExpanded: true,
        ),
        // refactoring 필요----------------------------------------------------
        Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: SizedBox(
            width: screenSizeController.getWidthByRatio(0.6),
            child: BorderWhiteContainer(
              child: TextWithIconRow(
                text: tr('selectSkiResort'),
                icon: Icons.keyboard_arrow_down,
                onClicked: () => showGoskiBottomSheet(
                    context: context,
                    child: const SizedBox(
                      height: 300,
                      child: Center(
                        child: Text('바텀시트'),
                      ),
                    )),
              ),
            ),
          ),
        ),
        // --------------------------------------------------------
      ],
    );
  }

  Widget buildTeamIntroduction() {
    return Column(
      children: [
        Row(
          children: [
            GoskiText(
              text: tr('teamIntroduction'),
              size: goskiFontLarge,
              isBold: true,
              isExpanded: true,
            )
          ],
        ),
        const BuildInterval(),
        GoskiTextField(
          hintText: tr('enterTeamIntroduction'),
          maxLines: 3,
        )
      ],
    );
  }

  Widget buildTeamIntroductionImageList() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: teamIntroductionImages.length,
          itemBuilder: (context, index) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Image.asset(
                    teamIntroductionImages[index],
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: -12,
                  top: -10,
                  child: IconButton(
                    icon: const Icon(
                      Icons.remove_circle,
                      color: goskiBlack,
                    ),
                    onPressed: () => removeTeamIntroductionImage(index),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildTeamPriceSetting() {
    return Column(
      children: [
        Row(
          children: [
            GoskiText(
              text: tr('settingTeamPrice'),
              size: goskiFontLarge,
              isBold: true,
              isExpanded: true,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenSizeController.getWidthByRatio(0.03)),
          child: Column(
            children: [
              SizedBox(
                height: screenSizeController.getHeightByRatio(0.01),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GoskiText(
                    text: tr('pricePerPerson'),
                    size: goskiFontMedium,
                    isExpanded: true,
                  ),
                  GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => const GoskiModal(
                        title: 'title',
                        child: SizedBox(
                          height: 300,
                          child: Center(
                            child: Text('Dialog'),
                          ),
                        ),
                      ),
                    ),
                    child: const Text(
                      '수정',
                      style: TextStyle(
                        fontSize: goskiFontMedium,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenSizeController.getHeightByRatio(0.01),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GoskiText(
                    text: tr('pricePerLesson'),
                    size: goskiFontMedium,
                    isExpanded: true,
                  ),
                  const SizedBox(width: 20), // 텍스트 사이의 간격 추가
                  GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => const GoskiModal(
                        title: 'title',
                        child: SizedBox(
                          height: 300,
                          child: Center(
                            child: Text('Dialog'),
                          ),
                        ),
                      ),
                    ),
                    child: const Text(
                      '수정',
                      style: TextStyle(
                        fontSize: goskiFontMedium,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildHolidaySetting() {
    return Column(
      children: [
        Row(
          children: [
            GoskiText(
              text: tr('holiday'),
              size: goskiFontLarge,
              isBold: true,
              isExpanded: true,
            )
          ],
        ),
        const BuildInterval(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: days.map((day) {
            return DayCheckbox(
              day: tr(day),
            );
          }).toList(),
        )
      ],
    );
  }
}
