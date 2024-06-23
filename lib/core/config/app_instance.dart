
import 'package:card_game/core/config/app_config.dart';
import 'package:card_game/core/persistence/in_memory_user.dart';

class AppInstance {
  AppConfig? _appConfig; // AppConfig instance for storing the application configuration
  UserInMemoryStorage? inMemoryStorage; // UserInMemoryStorage instance for storing user data

  static final AppInstance _singleton = AppInstance.internal(); // Singleton instance of app instance

  factory AppInstance() {
    return _singleton; // Factory method to return singleton instance
  }
  // Method to set the application configuration 
  void setConfig(AppConfig appConfig) {
    _appConfig = appConfig;
    inMemoryStorage = UserInMemoryStorage(model: null);
  }
  // Method to update the user model in the inMemoryStorage
  void updateModel(UserModel model) {
    inMemoryStorage = UserInMemoryStorage(model: model);
  }
  // Getter method to get the use model in user memory storage
  UserModel get user => inMemoryStorage!.model!;
  // Getter method to get the application configuration
  AppConfig? config() => _appConfig;
  // Private constructor for singleton patterm
  AppInstance.internal();
}
