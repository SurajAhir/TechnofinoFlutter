
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:technofino/data_classes/pagination/Pagination.dart';

import '../shared_preferences/DarkThemePreference.dart';

class MyProvider extends ChangeNotifier{



  bool isLoading=false;
  void setLoading(bool val){
    this.isLoading=val;
    notifyListeners();
  }

  bool isLoadingThreads=false;
  void setisLoadingThreads(bool val){
    isLoadingThreads=val;
    notifyListeners();
  }

  bool isLoadingHomeThreads=false;
  void setisLoadingHomeThreads(bool val){
    isLoadingHomeThreads=val;
    notifyListeners();
  }

 var isPaginationAval=false;
  void setPagination(bool isPaginationAval){
    this.isPaginationAval=isPaginationAval;
    notifyListeners();
  }

  var isFirstLoadingPosts=true;
  void setisFirstLoadingPosts(bool val){
    isFirstLoadingPosts=val;
    notifyListeners();
  }

  bool isLoadingUserThreads=false;
  void setisLoadingUserThreads(bool val){
    isLoadingUserThreads=val;
    notifyListeners();
  }

  bool isLoadingProfilePosts=false;
  void setisLoadingProfilePosts(bool val){
    isLoadingProfilePosts=val;
    notifyListeners();
  }

  bool isLoadingConversations=false;
  void setisLoadingConversations(bool val){
    isLoadingConversations=val;
    notifyListeners();
  }

  bool isLoadingConversationsMessages=false;
  void setisLoadingConversationsMessages(bool val){
    isLoadingConversationsMessages=val;
    notifyListeners();
  }

  bool isLoadingNotifications=false;
  void setisLoadingNotifications(bool val){
    isLoadingNotifications=val;
    notifyListeners();
  }

  var isReacted=false;
  void setIsReacted(bool val){
    this.isReacted=val;
    notifyListeners();
  }

  var language="English";
  setLanguage(String val){
    language=val;
    notifyListeners();
  }


  //*************ThemeWork
  late DarkThemePreference darkThemePreference;
  late bool _darkTheme;
  bool get darkTheme => _darkTheme;
  MyProvider(){
    darkThemePreference=DarkThemePreference();
    _darkTheme=false;
    getThemePreferences();
    checkNetwork();
  }
  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
  getThemePreferences() async{
    _darkTheme=await darkThemePreference.getTheme();
    notifyListeners();
  }
  //End of Themework


//Connectivity check************
  var isNetworkAvail;
  bool isNetworkAvailable(){
    checkNetwork();
    return isNetworkAvail;
  }
  checkNetwork() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      isNetworkAvail=true;
      notifyListeners();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      isNetworkAvail=true;
      notifyListeners();
    }else{
      isNetworkAvail=false;
      notifyListeners();
    }
  }

}