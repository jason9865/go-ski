import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:goski_instructor/ui/I004.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/text_theme.dart';
import 'package:goski_instructor/const/util/custom_dio.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:goski_instructor/data/data_source/auth_service.dart';
import 'package:goski_instructor/data/data_source/coupon_service.dart';
import 'package:goski_instructor/data/data_source/lesson_list_service.dart';
import 'package:goski_instructor/data/data_source/notification_service.dart';
import 'package:goski_instructor/data/data_source/review_service.dart';
import 'package:goski_instructor/data/data_source/schedule_service.dart';
import 'package:goski_instructor/data/data_source/team_service.dart';
import 'package:goski_instructor/data/data_source/user_service.dart';
import 'package:goski_instructor/data/repository/auth_repository.dart';
import 'package:goski_instructor/data/repository/coupon_repository.dart';
import 'package:goski_instructor/data/repository/lesson_list_repository.dart';
import 'package:goski_instructor/data/repository/notification_repository.dart';
import 'package:goski_instructor/data/repository/review_repository.dart';
import 'package:goski_instructor/data/repository/schedule_repository.dart';
import 'package:goski_instructor/data/repository/team_repository.dart';
import 'package:goski_instructor/data/repository/user_repository.dart';
import 'package:goski_instructor/fcm/fcm_config.dart';
import 'package:goski_instructor/firebase_options.dart';
import 'package:goski_instructor/ui/common/i001_login.dart';
import 'package:goski_instructor/ui/instructor/i004_instructor_main.dart';
import 'package:goski_instructor/ui/instructor/i010_coupon.dart';
import 'package:goski_instructor/ui/instructor/i011_review_list.dart';
import 'package:goski_instructor/ui/instructor/i012_lesson_list.dart';
import 'package:goski_instructor/view_model/coupon_view_model.dart';
import 'package:goski_instructor/view_model/instructor_main_view_model.dart';
import 'package:goski_instructor/view_model/lesson_list_view_model.dart';
import 'package:goski_instructor/view_model/login_view_model.dart';
import 'package:goski_instructor/view_model/notification_view_model.dart';
import 'package:goski_instructor/view_model/review_view_model.dart';
import 'package:goski_instructor/view_model/signup_view_model.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
// import 'package:goski_instructor/ui/component/goski_sub_header.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();
final screenSizeController = Get.put(ScreenSizeController());
FlutterSecureStorage secureStorage = const FlutterSecureStorage();

void initDependencies() {
  Get.put(AuthService(), permanent: true);
  Get.put(UserService(), permanent: true);
  Get.put(TeamService(), permanent: true);
  Get.put(ScheduleService(), permanent: true);
  Get.put(NotificationService(), permanent: true);

  Get.put(AuthRepository(), permanent: true);
  Get.put(UserRespository(), permanent: true);
  Get.put(TeamRepository(), permanent: true);
  Get.put(ScheduleRepository(), permanent: true);
  Get.put(NotificationRepository(), permanent: true);

  Get.put(LoginViewModel(), permanent: true);
  Get.put(SignupViewModel(), permanent: true);
  Get.put(InstructorMainViewModel(), permanent: true);
  Get.put(NotificationViewModel(), permanent: true);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await FlutterConfig.loadEnvVariables();
  await dotenv.load(fileName: ".env");
  CustomDio.initialize();
  await EasyLocalization.ensureInitialized();
  final kakaoApiKey = dotenv.env['KAKAO_API_KEY'];
  KakaoSdk.init(nativeAppKey: kakaoApiKey);
  initDependencies();
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

  @override
  Widget build(BuildContext context) {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    // secureStorage.delete(key: "isLoggedIn");
    return GetMaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      getPages: [
        GetPage(
            name: '/coupon',
            page: () => CouponScreen(),
            binding: BindingsBuilder(() {
              Get.lazyPut(() => CouponRepository());
              Get.lazyPut(() => CouponService());
              Get.lazyPut(() => CouponViewModel());
            })),
        GetPage(
            name: '/lessonList',
            page: () => LessonListScreen(),
            binding: BindingsBuilder(() {
              Get.lazyPut(() => LessonListRepository());
              Get.lazyPut(() => LessonListService());
              Get.lazyPut(() => LessonListViewModel());
            })),
        GetPage(
            name: '/reviewList',
            page: () => const ReviewListScreen(),
            binding: BindingsBuilder(() {
              Get.lazyPut(() => ReviewRepository());
              Get.lazyPut(() => ReviewService());
              Get.lazyPut(() => ReviewViewModel());
            })),
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
          logger.d(
              "ScreenHeight: ${screenSizeController.height}, ScreenWidth: ${screenSizeController.width}");

          if (snapshot.data == null) {
            return const LoginScreen();
          } else {
            return const InstructorMainScreen();
          }
        },
      ),
    );
  }
}
