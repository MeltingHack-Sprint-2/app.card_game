// import 'package:flutter/material.dart';

// class UserProvider extends ChangeNotifier {
//   LoginModel? _user;

//   LoginModel? get user => _user;

//   String get userName {
//     if (user?.firstName != null && user?.lastName != null) {
//       return "${user!.firstName} ${user!.lastName}";
//     } else {
//       return "***";
//     }
//   }

//   String get userPhoneNumber {
//     if (user?.phone != null) {
//       return user!.phone!;
//     }
//     return "***";
//   }

//   void setUserData(LoginModel data) {
//     _user = data;
//     notifyListeners();
//   }
// }
