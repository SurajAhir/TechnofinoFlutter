
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technofino/provider/MyProvider.dart';
import 'package:technofino/ui/bottom_navigation_pages/Profile.dart';
import 'package:technofino/ui/conversation/ShowConversations.dart';
import 'package:technofino/ui/HomePage.dart';
import 'package:technofino/ui/login.dart';
import 'package:technofino/ui/splash.dart';

import 'dark_them/Styles.dart';
import 'language_change/LocalString.dart';
void main(){
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterBranchSdk.validateSDKIntegration();
  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MyProvider themeChangeProvider = MyProvider();
  BranchContentMetaData metadata = BranchContentMetaData();
  BranchUniversalObject? buo;
  BranchLinkProperties lp = BranchLinkProperties();
  BranchEvent? eventStandart;
  BranchEvent? eventCustom;

  StreamSubscription<Map>? streamSubscription;
  StreamController<String> controllerData = StreamController<String>();
  StreamController<String> controllerInitSession = StreamController<String>();
  var rising=false;
  @override
  initState(){
    super.initState();
    // listenDynamicLinks();
    // initDeepLinkData();
    getLanguage();
    // getCurrentTheme();
  }
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider<MyProvider>(create: (context)=>MyProvider(),
      child: Consumer<MyProvider>(
          builder: (BuildContext context,MyProvider provider,Widget? child){
            return GetMaterialApp(
              translations: LocalString(),
              locale: Locale('en','US'),
              title: 'technofino_community'.tr,
              debugShowCheckedModeBanner: false,
              theme:     Styles.themeData(provider.darkTheme, context),                                /*ThemeData(
                                                        primarySwatch: Colors.blue,
                                                        splashColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        hoverColor: Colors.transparent,
                                                      ),*/
              home: const SplashScreen(),
              routes: {
                "/login":(context)=>const Login(),
                "/home":(context)=>const HomePage(),
                "/conversations":(context)=>const ShowConversations(),
              },
            );
          }
      ),);

  }

  void getLanguage()async {
    var prefs=await SharedPreferences.getInstance();
    var language= prefs.getString("language")??"English";
    var local=LocalString.locale[language] as Locale;
    updateLanguage(local);
  }
  updateLanguage(Locale locale){
    debugPrint("local"+locale.toString());
    Get.updateLocale(locale);
  }

// void getCurrentTheme()async {
//   themeChangeProvider.darkTheme =
//       await themeChangeProvider.darkThemePreference.getTheme();
// }
//   void listenDynamicLinks() async {
//     streamSubscription = FlutterBranchSdk.initSession().listen((data) async {
//       print('listenDynamicLinks - DeepLink Data: $data');
//       controllerData.sink.add((data.toString()));
//       if (data.containsKey('+clicked_branch_link') &&
//           data['+clicked_branch_link'] == true) {
//         print(
//             '------------------------------------Link clicked----------------------------------------------');
//         print('Custom list number: ${data['custom_list_number']}');
//         print(
//             '------------------------------------------------------------------------------------------------');
//        debugPrint("link clicked"+data["thread_id"]);
//        if(data["thread_id"]=="1"){
//        var prefs=await SharedPreferences.getInstance();
//        debugPrint("now value is stroed");
//        await prefs.setBool("linkClicked", true);
//        debugPrint(prefs.getBool("linkClicked").toString());
//
//        }
//       }
//     }, onError: (error) {
//       print('InitSesseion error: ${error.toString()}');
//     });
//   }
//
//   void initDeepLinkData() {
//     metadata = BranchContentMetaData()
//       ..addCustomMetadata('custom_string', 'abc')
//       ..addCustomMetadata('custom_number', 12345)
//       ..addCustomMetadata('custom_bool', true)
//       ..addCustomMetadata('custom_list_number', [1, 2, 3, 4, 5])
//       ..addCustomMetadata('custom_list_string', ['a', 'b', 'c'])
//     //--optional Custom Metadata
//       ..contentSchema = BranchContentSchema.COMMERCE_PRODUCT
//       ..price = 50.99
//       ..currencyType = BranchCurrencyType.BRL
//       ..quantity = 50
//       ..sku = 'sku'
//       ..productName = 'productName'
//       ..productBrand = 'productBrand'
//       ..productCategory = BranchProductCategory.ELECTRONICS
//       ..productVariant = 'productVariant'
//       ..condition = BranchCondition.NEW
//       ..rating = 100
//       ..ratingAverage = 50
//       ..ratingMax = 100
//       ..ratingCount = 2
//       ..setAddress(
//           street: 'street',
//           city: 'city',
//           region: 'ES',
//           country: 'Brazil',
//           postalCode: '99999-987')
//       ..setLocation(31.4521685, -114.7352207);
//
//     buo = BranchUniversalObject(
//         canonicalIdentifier: 'flutter/branch',
//         //parameter canonicalUrl
//         //If your content lives both on the web and in the app, make sure you set its canonical URL
//         // (i.e. the URL of this piece of content on the web) when building any BUO.
//         // By doing so, we’ll attribute clicks on the links that you generate back to their original web page,
//         // even if the user goes to the app instead of your website! This will help your SEO efforts.
//         canonicalUrl: 'https://flutter.dev',
//         title: 'Flutter Branch Plugin',
//         imageUrl:"",
//         contentDescription: 'Flutter Branch Description',
//         /*
//         contentMetadata: BranchContentMetaData()
//           ..addCustomMetadata('custom_string', 'abc')
//           ..addCustomMetadata('custom_number', 12345)
//           ..addCustomMetadata('custom_bool', true)
//           ..addCustomMetadata('custom_list_number', [1, 2, 3, 4, 5])
//           ..addCustomMetadata('custom_list_string', ['a', 'b', 'c']),
//          */
//         //contentMetadata: metadata,
//         keywords: ['Plugin', 'Branch', 'Flutter'],
//         publiclyIndex: true,
//         locallyIndex: true,
//         expirationDateInMilliSec: DateTime.now()
//             .add(const Duration(days: 365))
//             .millisecondsSinceEpoch);
//
//     lp = BranchLinkProperties(
//         channel: 'facebook',
//         feature: 'sharing',
//         //parameter alias
//         //Instead of our standard encoded short url, you can specify the vanity alias.
//         // For example, instead of a random string of characters/integers, you can set the vanity alias as *.app.link/devonaustin.
//         // Aliases are enforced to be unique** and immutable per domain, and per link - they cannot be reused unless deleted.
//         //alias: 'https://branch.io' //define link url,
//         stage: 'new share',
//         campaign: 'campaign',
//         tags: ['one', 'two', 'three'])
//       ..addControlParam('\$uri_redirect_mode', '1')
//       ..addControlParam('referring_user_id', 'user_id');
//
//     eventStandart = BranchEvent.standardEvent(BranchStandardEvent.ADD_TO_CART)
//     //--optional Event data
//       ..transactionID = '12344555'
//       ..currency = BranchCurrencyType.BRL
//       ..revenue = 1.5
//       ..shipping = 10.2
//       ..tax = 12.3
//       ..coupon = 'test_coupon'
//       ..affiliation = 'test_affiliation'
//       ..eventDescription = 'Event_description'
//       ..searchQuery = 'item 123'
//       ..adType = BranchEventAdType.BANNER
//       ..addCustomData(
//           'Custom_Event_Property_Key1', 'Custom_Event_Property_val1')
//       ..addCustomData(
//           'Custom_Event_Property_Key2', 'Custom_Event_Property_val2');
//
//     eventCustom = BranchEvent.customEvent('Custom_event')
//       ..addCustomData(
//           'Custom_Event_Property_Key1', 'Custom_Event_Property_val1')
//       ..addCustomData(
//           'Custom_Event_Property_Key2', 'Custom_Event_Property_val2');
//   }
//
//   void generateLink(BuildContext context) async {
//     BranchResponse response =
//     await FlutterBranchSdk.getShortUrl(buo: buo!, linkProperties: lp);
//     if (response.success) {
//       debugPrint(response.result);
//     } else {
//       debugPrint('Error : ${response.errorCode} - ${response.errorMessage}');
//     }
//   }
}


