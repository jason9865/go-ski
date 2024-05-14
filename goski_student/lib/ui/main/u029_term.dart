import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_sub_header.dart';
import 'package:goski_student/ui/component/goski_text.dart';

class TermScreen extends StatefulWidget {
  const TermScreen({super.key});

  @override
  _TermScreenState createState() => _TermScreenState();
}

class _TermScreenState extends State<TermScreen> {
  late Future<String> _termsContent;

  @override
  void initState() {
    super.initState();
    _termsContent = loadTerms();
  }

  Future<String> loadTerms() async {
    return await rootBundle.loadString('assets/policy/GOSKI_Service_Terms.txt');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoskiSubHeader(title: tr('termsOfUse')),
      body: GoskiContainer(
        child: FutureBuilder<String>(
          future: _termsContent,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: GoskiText(
                    text: snapshot.data ?? 'No terms available.',
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
