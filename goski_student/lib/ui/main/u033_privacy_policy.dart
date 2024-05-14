import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/ui/component/goski_sub_header.dart';
import 'package:goski_student/ui/component/goski_text.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  late Future<String> _privacyPolicyContent;

  @override
  void initState() {
    super.initState();
    _privacyPolicyContent = loadPrivacyPolicy();
  }

  Future<String> loadPrivacyPolicy() async {
    return await rootBundle
        .loadString('assets/policy/GOSKI_Privacy_Policy.txt');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoskiSubHeader(title: tr('privacyPolicy')),
      body: Container(
        decoration: const BoxDecoration(
          color: goskiBackground,
        ),
        child: FutureBuilder<String>(
          future: _privacyPolicyContent,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: GoskiText(
                    text: snapshot.data ?? 'No policy available.',
                    size: goskiFontSmall,
                  ));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
