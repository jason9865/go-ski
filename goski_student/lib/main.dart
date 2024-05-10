import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/text_theme.dart';
import 'package:goski_student/const/util/custom_dio.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';
import 'package:goski_student/data/data_source/auth_service.dart';
import 'package:goski_student/data/data_source/cancel_lesson_service.dart';
import 'package:goski_student/data/data_source/coupon_service.dart';
import 'package:goski_student/data/data_source/feedback_service.dart';
import 'package:goski_student/data/data_source/instructor_profile_service.dart';
import 'package:goski_student/data/data_source/main_service.dart';
import 'package:goski_student/data/data_source/notification_service.dart';
import 'package:goski_student/data/data_source/reservation_service.dart';
import 'package:goski_student/data/data_source/review_service.dart';
import 'package:goski_student/data/data_source/settlement_service.dart';
import 'package:goski_student/data/data_source/ski_resort_service.dart';
import 'package:goski_student/data/data_source/user_service.dart';
import 'package:goski_student/data/repository/auth_repository.dart';
import 'package:goski_student/data/repository/cancel_lesson_repository.dart';
import 'package:goski_student/data/repository/coupon_repository.dart';
import 'package:goski_student/data/repository/feedback_repository.dart';
import 'package:goski_student/data/repository/instructor_profile_repository.dart';
import 'package:goski_student/data/repository/main_repository.dart';
import 'package:goski_student/data/repository/notification_repository.dart';
import 'package:goski_student/data/repository/reservation_repository.dart';
import 'package:goski_student/data/repository/review_repository.dart';
import 'package:goski_student/data/repository/settlement_repository.dart';
import 'package:goski_student/data/repository/ski_resort_repository.dart';
import 'package:goski_student/data/repository/user_repository.dart';
import 'package:goski_student/fcm/fcm_config.dart';
import 'package:goski_student/ui/main/u003_student_main.dart';
import 'package:goski_student/ui/reservation/u018_reservation_select.dart';
import 'package:goski_student/ui/user/u001_login.dart';
import 'package:goski_student/view_model/cancel_lesson_view_model.dart';
import 'package:goski_student/view_model/coupon_view_model.dart';
import 'package:goski_student/view_model/feedback_view_model.dart';
import 'package:goski_student/view_model/instructor_profile_view_model.dart';
import 'package:goski_student/view_model/lesson_list_view_model.dart';
import 'package:goski_student/view_model/login_view_model.dart';
import 'package:goski_student/view_model/main_view_model.dart';
import 'package:goski_student/view_model/notification_view_model.dart';
import 'package:goski_student/view_model/reservation_view_model.dart';
import 'package:goski_student/view_model/review_view_model.dart';
import 'package:goski_student/view_model/settlement_view_model.dart';
import 'package:goski_student/view_model/signup_view_model.dart';
import 'package:goski_student/view_model/ski_resort_view_model.dart';
import 'package:goski_student/view_model/use_view_model.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:logger/logger.dart';

import 'data/data_source/lesson_list_service.dart';
import 'data/repository/lesson_list_repository.dart';
import 'firebase_options.dart';

Logger logger = Logger();

void initDependencies() {
  Get.put(AuthService(), permanent: true);
  Get.put(SkiResortService(), permanent: true);
  Get.put(UserService(), permanent: true);
  Get.put(NotificationService(), permanent: true);
  Get.put(MainService(), permanent: true);
  Get.put(LessonListService(), permanent: true);
  Get.put(SettlementService(), permanent: true);
  Get.put(FeedbackService(), permanent: true);
  Get.put(ReservationService(), permanent: true);
  Get.put(ReviewService(), permanent: true);
  Get.put(CancelLessonService(), permanent: true);
  Get.put(InstructorProfileService(), permanent: true);
  Get.put(CouponService(), permanent: true);

  Get.put(AuthRepository(), permanent: true);
  Get.put(SkiResortRepository(), permanent: true);
  Get.put(UserRepository(), permanent: true);
  Get.put(NotificationRepository(), permanent: true);
  Get.put(MainRepository(), permanent: true);
  Get.put(LessonListRepository(), permanent: true);
  Get.put(SettlementRepository(), permanent: true);
  Get.put(FeedbackRepository(), permanent: true);
  Get.put(ReservationRepository(), permanent: true);
  Get.put(ReviewRepository(), permanent: true);
  Get.put(CancelLessonRepository() , permanent: true);
  Get.put(InstructorProfileRepository(), permanent: true);
  Get.put(CouponRepository(), permanent: true);

  Get.put(LoginViewModel(), permanent: true);
  Get.put(SignupViewModel(), permanent: true);
  Get.put(UserViewModel(), permanent: true);
  Get.put(SkiResortViewModel(), permanent: true);
  Get.put(NotificationViewModel(), permanent: true);
  Get.put(MainViewModel(), permanent: true);
  Get.put(LessonListViewModel(), permanent: true);
  Get.put(SettlementViewModel(), permanent: true);
  Get.put(FeedbackViewModel(), permanent: true);
  Get.put(ReservationViewModel(), permanent: true);
  Get.put(ReviewViewModel(), permanent: true);
  Get.put(CancelLessonViewModel() , permanent: true);
  Get.put(InstructorProfileViewModel(), permanent: true);
  Get.put(CouponViewModel(), permanent: true);
  Get.lazyPut(() => ReservationService());
  Get.lazyPut(() => ReservationRepository());
  Get.lazyPut(() => ReservationViewModel());
  Get.lazyPut(() => LessonTeamListViewModel());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await dotenv.load(fileName: ".env");
  CustomDio.initialize();
  await EasyLocalization.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);
  initDependencies();
  final kakaoApiKey = dotenv.env['KAKAO_API_KEY'];
  KakaoSdk.init(nativeAppKey: kakaoApiKey);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setFCM();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ko', 'KR')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ko', 'KR'),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      getPages: [
        GetPage(
          name: '/reservation',
          page: () => const ReservationSelectScreen(),
        )
      ],
      theme: ThemeData(
        fontFamily: 'Jua',
        textTheme: AppTextTheme.lightTextTheme,
      ),
      home: FutureBuilder(
        future: secureStorage.read(key: "isLoggedIn"),
        builder: (context, snapshot) {
          final mediaQueryData = MediaQuery.of(context);
          final screenSizeController = Get.put(ScreenSizeController());
          screenSizeController.setScreenSize(
            mediaQueryData.size.width,
            mediaQueryData.size.height,
          );
          if (snapshot.data != null) {
            return StudentMainScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
