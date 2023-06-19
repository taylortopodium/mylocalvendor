import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_local_vendor/app/services/auth_service.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'app/provider/api_provider.dart';
import 'app/routes/Theme1AppPages.dart';
import 'app/services/firebase_messaging_service.dart';
import 'app/services/settings_service.dart';
import 'app/services/translation_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> initServices() async {
  Get.log('starting services ...');
  await Firebase.initializeApp();
  await GetStorage.init();
  await Get.putAsync(() => TranslationService().init());
  await Get.putAsync(() => SettingsService().init());
  Get.putAsync(() => FireBaseMessagingService().init());
  await Get.put(AuthService());
  await Get.put(APIProvider());
  await Get.putAsync(() => APIProvider().init());
  // Stripe.publishableKey = 'pk_test_51LdTWyC2YEc8eoyMs0BcqyXgVTGNl3Sr1SWFjKtofkSDQTOy1LpgmA9B6zRGtTnz1txaxUTn5829X1CZDeZY8twc00cDrsusKx';
  // Stripe.merchantIdentifier = 'any string works';
  // await Stripe.instance.applySettings();
  Get.log('All services started...');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: child!,
          );
        },
        title: 'My local Vendor',
        initialRoute: Theme1AppPages.INITIAL,
        getPages: Theme1AppPages.routes,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: Get.find<TranslationService>().supportedLocales(),
        translationsKeys: Get.find<TranslationService>().translations,
        locale: Get.find<SettingsService>().getLocale(),
        fallbackLocale: Get.find<TranslationService>().fallbackLocale,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Nunito',
        ),
        // home: MyHomePage(title: 'Romaan Khan')
      );
    });
  }

  // TODO : Facebook login in IOS
  // TODO : Google login in IOS
  // TODO : Apple login in IOS

}
