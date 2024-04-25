import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:goski_instructor/ui/component/goski_card.dart';
import 'package:goski_instructor/ui/component/goski_container.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();
final screenSizeController = Get.find<ScreenSizeController>();

class InviteTeamScreen extends StatefulWidget {
  const InviteTeamScreen({super.key});

  @override
  State<InviteTeamScreen> createState() => _InviteTeamScreenState();
}

class _InviteTeamScreenState extends State<InviteTeamScreen> {
  List<TeamMember> members = [];
  List<TeamMember> filteredMembers = [];

  @override
  void initState() {
    super.initState();
    members = getMembers();
    filteredMembers = getMembers();
  }

  void filterMembers(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredMembers = getMembers();
      } else {
        filteredMembers = members
            .where((member) => member.phoneNumber.contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoskiContainer(
      buttonName: tr('invite'),
      onConfirm: () => 0,
      child: GoskiCard(
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.all(screenSizeController.getWidthByRatio(0.035)),
              child: TextField(
                cursorColor: goskiDarkGray,
                cursorErrorColor: goskiRed,
                onChanged: filterMembers,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: goskiLightGray,
                  contentPadding: EdgeInsets.all(
                      screenSizeController.getHeightByRatio(0.01)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: goskiDarkGray,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  hintText: tr('searchByPhoneNumber'),
                  hintStyle: const TextStyle(
                    color: goskiDarkGray,
                    fontSize: bodyMedium,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredMembers.length,
                itemBuilder: (context, index) {
                  return memberRow(filteredMembers[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget memberRow(TeamMember member) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: screenSizeController.getHeightByRatio(0.01)),
      child: ListTile(
          leading: Container(
            width: screenSizeController.getWidthByRatio(0.13),
            height: screenSizeController.getHeightByRatio(0.13),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(member.profileImage),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          title: Text(
            member.name,
            style: const TextStyle(
              fontSize: bodyMedium,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Transform.translate(
            offset: const Offset(15.0, 0.0),
            child: Checkbox(
              value: member.isSelected,
              onChanged: (bool? value) {
                setState(() {
                  member.isSelected = value ?? false;
                });
              },
              shape: const CircleBorder(),
              side: const BorderSide(
                color: goskiDarkGray,
                width: 1.5,
              ),
              activeColor: goskiDarkGray,
              checkColor: goskiWhite,
            ),
          )),
    );
  }
}

class TeamMember {
  final String name;
  final String phoneNumber;
  final String profileImage;
  bool isSelected = false;

  TeamMember(
      {required this.name,
      required this.phoneNumber,
      required this.profileImage});
}

List<TeamMember> getMembers() {
  return [
    TeamMember(
        name: '고승민',
        phoneNumber: '01099955107',
        profileImage: 'assets/images/person3.png'),
    TeamMember(
        name: '김태훈',
        phoneNumber: '01041765158',
        profileImage: 'assets/images/person2.png'),
    TeamMember(
        name: '임종율',
        phoneNumber: '01057379814',
        profileImage: 'assets/images/person1.png'),
    TeamMember(
        name: '임종율',
        phoneNumber: '01012341234',
        profileImage: 'assets/images/person1.png'),
    TeamMember(
        name: '임종율',
        phoneNumber: '01012341234',
        profileImage: 'assets/images/person1.png'),
    TeamMember(
        name: '임종율',
        phoneNumber: '01012341234',
        profileImage: 'assets/images/person1.png'),
    TeamMember(
        name: '임종율',
        phoneNumber: '01012341234',
        profileImage: 'assets/images/person1.png'),
  ];
}
