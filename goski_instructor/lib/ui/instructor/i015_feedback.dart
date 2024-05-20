import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/ui/component/goski_card.dart';
import 'package:goski_instructor/ui/component/goski_container.dart';
import 'package:goski_instructor/ui/component/goski_sub_header.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';
import 'package:goski_instructor/ui/component/goski_textfield.dart';

class FeedbackScreen extends StatefulWidget {
  final String resortName;
  final String teamName;
  final DateTime startTime;
  final DateTime endTime;

  const FeedbackScreen({
    super.key,
    required this.resortName,
    required this.teamName,
    required this.startTime,
    required this.endTime,
  });

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  List<String> feedbackImages = [];
  List<String> feedbackVideos = [];
  String feedbackImage = "";
  String feedbackVideo = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoskiSubHeader(
        title: tr('createFeedback'),
      ),
      body: GoskiContainer(
        buttonName: tr('letSave'),
        onConfirm: () => {print("저장하기 버튼")},
        child: SingleChildScrollView(
          child: Column(
            children: [
              GoskiCard(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GoskiText(
                              text: widget.resortName, size: goskiFontLarge),
                          const GoskiText(text: " - ", size: goskiFontLarge),
                          GoskiText(
                              text: widget.teamName, size: goskiFontLarge),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GoskiText(
                            text: tr(DateFormat('yyyy.MM.dd (E) HH:mm')
                                .format(widget.startTime)
                                .toString()),
                            size: goskiFontSmall,
                            color: goskiDarkGray,
                          ),
                          GoskiText(
                            text: tr(DateFormat('~HH:mm')
                                .format(widget.endTime)
                                .toString()),
                            size: goskiFontSmall,
                            color: goskiDarkGray,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              GoskiCard(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GoskiText(text: tr('feedback'), size: goskiFontLarge),
                      GoskiTextField(
                        hintText: tr('feedbackHelp'),
                        maxLines: 10,
                        onTextChange: (text) => 0,
                      )
                    ],
                  ),
                ),
              ),
              GoskiCard(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GoskiText(
                            text: tr("feedbackImage"),
                            size: goskiFontLarge,
                            isExpanded: true,
                          ),
                          IconButton(
                            onPressed: pickFeedbackImage,
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      feedbackImages.isNotEmpty
                          ? buildFeedbackImageList()
                          : Container(),
                    ],
                  ),
                ),
              ),
              GoskiCard(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GoskiText(
                            text: tr("feedbackVideo"),
                            size: goskiFontLarge,
                            isExpanded: true,
                          ),
                          IconButton(
                            onPressed: pickFeedbackVideo,
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      feedbackVideos.isNotEmpty
                          ? buildFeedbackVideoList()
                          : Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFeedbackImageList() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: feedbackImages.length,
          itemBuilder: (context, index) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Image.asset(
                    feedbackImages[index],
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
                    onPressed: () => removeFeedbackImage(index),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> pickFeedbackImage() async {
    // 추후에 디바이스에서 사진 가져올 때 사용할 변수들
    // final ImagePicker picker = ImagePicker();
    // final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      // 일단 assets 폴더에 있는 이미지의 경로를 리스트에 추가
      feedbackImages.add("assets/images/person1.png");
    });
  }

  void removeFeedbackImage(int index) {
    setState(() {
      feedbackImages.removeAt(index);
    });
  }

  Widget buildFeedbackVideoList() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: feedbackVideos.length,
          itemBuilder: (context, index) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Image.asset(
                    feedbackVideos[index],
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
                    onPressed: () => removeFeedbackVideo(index),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> pickFeedbackVideo() async {
    // 추후에 디바이스에서 사진 가져올 때 사용할 변수들
    // final ImagePicker picker = ImagePicker();
    // final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      // 일단 assets 폴더에 있는 이미지의 경로를 리스트에 추가
      feedbackVideos.add("assets/images/person2.png");
    });
  }

  void removeFeedbackVideo(int index) {
    setState(() {
      feedbackVideos.removeAt(index);
    });
  }
}

class _FeedbackScreen {}
