/// Route names for navigation
class Routes {
  // Private constructor
  Routes._();

  /// Auth Routes
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String connectWallet = '/connect-wallet';

  /// Main Routes
  static const String home = '/home';
  static const String notifications = '/notifications';
  static const String notificationSettings = '/notification-settings';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String wallet = '/wallet';
  static const String dao = '/dao';

  /// Post Routes
  static const String createPost = '/create-post';
  static const String postDetail = '/post/:id';
  static String postDetailById(String id) => '/post/$id';

  /// User Routes
  static const String userProfile = '/user/:walletAddress';
  static String userProfileByWallet(String walletAddress) => '/user/$walletAddress';
}
