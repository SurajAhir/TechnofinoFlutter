import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technofino/data_classes/pagination/Pagination.dart';

import '../data_classes/login_response/UserData.dart';
import '../main_data_class/MyDataClass.dart';
import '../services/ApiClient.dart';
import '../shared_preferences/DarkThemePreference.dart';

class MyProvider extends ChangeNotifier {
  bool isLoading = false;

  void setLoading(bool val) {
    this.isLoading = val;
    notifyListeners();
  }

  bool isLoadingThreads = false;

  void setisLoadingThreads(bool val) {
    isLoadingThreads = val;
    notifyListeners();
  }

  bool isLoadingHomeThreads = false;

  void setisLoadingHomeThreads(bool val) {
    isLoadingHomeThreads = val;
    notifyListeners();
  }

  var isPaginationAval = false;

  void setPagination(bool isPaginationAval) {
    this.isPaginationAval = isPaginationAval;
    notifyListeners();
  }

  var isFirstLoadingPosts = true;

  void setisFirstLoadingPosts(bool val) {
    isFirstLoadingPosts = val;
    notifyListeners();
  }

  bool isLoadingUserThreads = false;

  void setisLoadingUserThreads(bool val) {
    isLoadingUserThreads = val;
    notifyListeners();
  }

  bool isLoadingProfilePosts = false;

  void setisLoadingProfilePosts(bool val) {
    isLoadingProfilePosts = val;
    notifyListeners();
  }

  bool isLoadingConversations = false;

  void setisLoadingConversations(bool val) {
    isLoadingConversations = val;
    notifyListeners();
  }

  bool isLoadingConversationsMessages = false;

  void setisLoadingConversationsMessages(bool val) {
    isLoadingConversationsMessages = val;
    notifyListeners();
  }

  bool isLoadingNotifications = false;

  void setisLoadingNotifications(bool val) {
    isLoadingNotifications = val;
    notifyListeners();
  }

  var isReacted = false;

  void setIsReacted(bool val) {
    this.isReacted = val;
    notifyListeners();
  }

  var language = "English";

  setLanguage(String val) {
    language = val;
    notifyListeners();
  }

  //*************ThemeWork
  late DarkThemePreference darkThemePreference;
  late bool _darkTheme;

  bool get darkTheme => _darkTheme;

  MyProvider() {
    darkThemePreference = DarkThemePreference();
    _darkTheme = false;
    getThemePreferences();
    checkNetwork();
    getTotalConversationsCount();
    getTotalAlertsCount();
  }

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }

  getThemePreferences() async {
    _darkTheme = await darkThemePreference.getTheme();
    notifyListeners();
  }

  //End of Themework

//Connectivity check************
  var isNetworkAvail;

  bool isNetworkAvailable() {
    checkNetwork();
    return isNetworkAvail;
  }

  checkNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      isNetworkAvail = true;
      notifyListeners();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      isNetworkAvail = true;
      notifyListeners();
    } else {
      isNetworkAvail = false;
      notifyListeners();
    }
  }

  //total conversation count
  var isConversationsAvail = false;
  var totalConversations = 0;

  void getTotalConversationsCount() async {
    var prefs = await SharedPreferences.getInstance();
    var isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
    if (isLoggedIn) {
      debugPrint(
          "total ${MyDataClass.myUserId} and ${prefs.getString("email")}");
      var email = prefs.getString("email").toString();
      var response =
          await ApiClient(Dio(BaseOptions(contentType: "application/json")))
              .findUserEmail(MyDataClass.api_key, 1, email);
      MyDataClass.loginResponse = response["user"] as UserData;
      MyDataClass.isUserLoggedIn = true;
      MyDataClass.myUserId = (response["user"] as UserData).user_id;
      var responseAlerts =
          await ApiClient(Dio(BaseOptions(contentType: "application/json")))
              .getUnViewedConversations(
                  MyDataClass.api_key, MyDataClass.myUserId, true);
      var pagination = responseAlerts.pagination as Pagination;
      debugPrint("total ${pagination.total}${MyDataClass.myUserId}");
      if (pagination.total > 0) {
        isConversationsAvail = true;
        totalConversations = pagination.total;
      }
    }
    notifyListeners();
  }

  //total alerts count
  var isAlertsAvail = false;
  var totalAlerts = 0;

  void getTotalAlertsCount() async {
    var prefs = await SharedPreferences.getInstance();
    var isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
    if (isLoggedIn) {
      var email = prefs.getString("email").toString();
      var response =
          await ApiClient(Dio(BaseOptions(contentType: "application/json")))
              .findUserEmail(MyDataClass.api_key, 1, email);
      MyDataClass.loginResponse = response["user"] as UserData;
      MyDataClass.isUserLoggedIn = true;
      MyDataClass.myUserId = (response["user"] as UserData).user_id;
      var responseAlerts =
          await ApiClient(Dio(BaseOptions(contentType: "application/json")))
              .getUnViewedAlerts(
                  MyDataClass.api_key, MyDataClass.myUserId, true);
      var pagination = responseAlerts.pagination as Pagination;
      if (pagination.total > 0) {
        isAlertsAvail = true;
        totalAlerts = pagination.total;
      }
    }
    notifyListeners();
  }

  //ToChangeReaction
  var reactMap = Map<int, int>();

  void changeReaction(int index, int reaction_id) {
    if (reactMap.containsKey(index)) {
      reactMap.remove(index);
    }
    reactMap.putIfAbsent(index, () => reaction_id);
    notifyListeners();
  }

  //ToChangeReactionOfComment
  var reactMapOfComment = Map<int, Map<int, int>>();

  void changeReactionOfComment(
      int index,Map<int, int> map ) {
    if (reactMapOfComment.containsKey(index)) {
      reactMapOfComment.remove(index);
    }
    reactMapOfComment.putIfAbsent(index, () => map);
    notifyListeners();
  }
}
