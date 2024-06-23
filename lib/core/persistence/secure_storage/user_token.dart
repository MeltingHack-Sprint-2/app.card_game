// Represents user's auth token
class UserToken {
  // The rawa access string token received from the server
  final String _rawToken;
  // Provides read only access to the raw-token string
  String get token => _rawToken;
  // Creates a 'UserToken' object from a JSON response
  factory UserToken.fromJson(Map<String, dynamic> json) {
    // Updates the raw token with the access token received from the server's response
    final rawToken = json['accessToken'];
    // 
    return UserToken(rawToken: rawToken);
  }
  // Constructor for creating "UserToken" object
  UserToken({
    // The rawToken is required
    required String rawToken,
  }) : _rawToken = rawToken;
}
