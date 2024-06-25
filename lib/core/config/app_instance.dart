
import 'package:card_game/core/config/app_config.dart';


class AppInstance {
  AppConfig? _appConfig; // AppConfig instance for storing the application configuration

  static final AppInstance _singleton = AppInstance.internal(); // Singleton instance of app instance

  factory AppInstance() {
    return _singleton; // Factory method to return singleton instance
  }
  // Method to set the application configuration 
  void setConfig(AppConfig appConfig) {
    _appConfig = appConfig;
  }
  // Getter method to get the application configuration
  AppConfig? config() => _appConfig;
  // Private constructor for singleton patterm
  AppInstance.internal();
}
