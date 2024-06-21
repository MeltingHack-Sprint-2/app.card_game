import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart';

import 'user_token.dart';

// An interface that defines methods for interacting with the secure storage manager
abstract class IsSecureStorageManager {
  // Checks if a user token exists in the storage
  Future<bool> hasToken();

  // Saves a user token to the storage
  Future<void> setToken(UserToken token);

  Future<void> setGToken(UserToken token);

  // Saves session id
  Future<void> setSessionId(String sessionId);

  // Retrieves the stored user token (if any)
  Future<String?> getToken();

  Future<String?> getGToken();

  // Retrieves session id
  Future<String?> getSessionId();

  //  Store token expiration time
  Future<void> setTokenExpirationTime(String tokenExpTime);

  // Clears all data from local storage
  Future<void> nukeLocalStorage();

  // Stores the user name in storage
  Future<void> setUserName(String username);

  // Store user number
  Future<void> setUserPhoneNumber(String phoneNumber);

  // Stores the user id in storage
  Future<void> setUserId(String userId);

  // Stores the user profile image in storage
  Future<void> setUserProfileImage(String profileImage);

  // Retrieves the user name (if any)
  Future<String?> getUsername();

  // Retrieves user phone number (if any)
  Future<String?> getUserPhoneNumber();

  // Retrieves the user id (if any)
  Future<String?> getUserId();

  // Retrieves the user image (if any)
  Future<String?> getUserImage();

  // Retrieve token expiration time
  Future<DateTime?> getTokenExpirationTime();
}

// Concrete implementation of the IsSecureStorage manager interface
class SecureStorageManager extends IsSecureStorageManager {
  // Key used to store the user token
  final _userTokenKey = 'DCG_USER_TOKEN';
  final _userGTokenKey = 'GOOGLE_USER_TOKEN';

  // Key for token expiration time
  final _tokenExpKey = 'TOKEN_EXP_KEY';

  // Key for user phone number
  final _userPhoneNumberKey = 'USER_PHONE_NUMBER';

  // Key used to store the user name
  final _userName = 'USER_NAME';

  // Key used to store the user id
  final _userID = 'USER_ID';

  // Key used to store the user profile image
  final _userProfileImage = 'USER_PROFILE_IMAGE';

  // Key for session id
  final _sessionId = 'USER_SESSION_ID';

  // Instance of the FlutterSecureStorage class  for secure storage access
  final _storage = const FlutterSecureStorage();

  // Creates a SecureStorageManager instance
  SecureStorageManager();

  @override
  Future<bool> hasToken() async {
    // Checks if the user toKen exist in storage
    bool userToken = await _storage.containsKey(key: _userTokenKey);
    bool googleToken = await _storage.containsKey(key: _userGTokenKey);
    return userToken || googleToken;
  }

  @override
  Future<void> setToken(UserToken token) async {
    // Stores user token in storage
    return _storage.write(key: _userTokenKey, value: token.token);
  }

  @override
  Future<void> setSessionId(String sessionId) async {
    // Stores users session id in storage
    return _storage.write(key: _sessionId, value: sessionId);
  }

  @override
  Future<void> setUserPhoneNumber(String phoneNumber) async {
    // Stores user token in storage
    return _storage.write(key: _userPhoneNumberKey, value: phoneNumber);
  }

  @override
  Future<void> setGToken(UserToken token) async {
    return _storage.write(key: _userGTokenKey, value: token.token);
  }

  @override
  Future<String?> getToken() async {
    // Retrieves user toKen from storage
    return _storage.read(key: _userTokenKey);
  }

  @override
  Future<String?> getGToken() async {
    return _storage.read(key: _userGTokenKey);
  }

  @override
  Future<void> setTokenExpirationTime(String tokenExpTime) async {
    return _storage.write(key: _tokenExpKey, value: tokenExpTime);
  }

  @override
  Future<String?> getUserPhoneNumber() async {
    return _storage.read(key: _userPhoneNumberKey);
  }

  @override
  Future<String?> getSessionId() async {
    return _storage.read(key: _sessionId);
  }

  @override
  Future<void> nukeLocalStorage() async {
    // Clears the whole local storage
    return _storage.deleteAll();
  }

  @override
  Future<void> setUserName(String username) async {
    // Stores user name in storage
    return _storage.write(key: _userName, value: username);
  }

  @override
  Future<void> setUserId(String userId) async {
    // Stores user ID in storage
    return _storage.write(key: _userID, value: userId);
  }

  @override
  Future<void> setUserProfileImage(String profileImage) async {
    // Stores user profile image in storage
    return _storage.write(key: _userProfileImage, value: profileImage);
  }

  @override
  Future<String?> getUsername() async {
    // Retrieves user name from storage (if any)
    return _storage.read(key: _userName);
  }

  @override
  Future<String?> getUserId() async {
    // Retrieves the user token and decodes it to extract userID
    var token = await getToken();
    if (token == null) {
      return null; // Return null if no token exist
    }
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    final userId = decodedToken['sub'];

    return userId;
    // return _storage.read(key: _userID);
  }

  @override
  Future<String?> getUserImage() async {
    // Retrieves stored profile image (if any)
    return _storage.read(key: _userProfileImage);
  }

  @override
  Future<DateTime?> getTokenExpirationTime() async {
    // Retrieves the user token and decodes it to extract token exp time
    var time = await _storage.read(key: _tokenExpKey);
    if (time == null) {
      return null; // Return null if no token exist
    }
    try {
      final expiryTime = DateTime.tryParse(time);
      return expiryTime;
    } catch (e) {
      // Handle decoding error (e.g., log the error)
      Logger().e('Error decoding token: $e');
      return null;
    }
  }
}
