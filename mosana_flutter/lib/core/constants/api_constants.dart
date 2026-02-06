/// API endpoint constants
class ApiConstants {
  // Private constructor
  ApiConstants._();

  /// Auth Endpoints
  static const String authBase = '/auth';
  static const String connectWallet = '$authBase/connect';
  static const String verifyWallet = '$authBase/verify';

  /// User Endpoints
  static const String usersBase = '/users';
  static String userProfile(String walletAddress) => '$usersBase/$walletAddress';
  static const String updateProfile = '$usersBase/profile';
  static const String registerFcmToken = '$usersBase/fcm-token';
  static const String removeFcmToken = '$usersBase/fcm-token';
  static String followUser(String walletAddress) => '$usersBase/follow/$walletAddress';
  static String unfollowUser(String walletAddress) => '$usersBase/follow/$walletAddress';

  /// Notification Endpoints
  static const String notificationsBase = '/notifications';
  static const String getNotifications = notificationsBase;
  static const String unreadNotifications = '$notificationsBase/unread';
  static const String markAsRead = '$notificationsBase/mark-read';
  static const String markAllAsRead = '$notificationsBase/mark-all-read';
  static const String notificationPreferences = '$notificationsBase/preferences';

  /// Post Endpoints
  static const String postsBase = '/posts';
  static const String createPost = postsBase;
  static const String getFeed = postsBase;
  static String getPost(String postId) => '$postsBase/$postId';
  static String likePost(String postId) => '$postsBase/$postId/like';
  static String commentPost(String postId) => '$postsBase/$postId/comment';

  /// Tipping Endpoints
  static const String tippingBase = '/tipping';
  static const String sendTip = '$tippingBase/tip';
  static const String getSentTips = '$tippingBase/sent';
  static const String getReceivedTips = '$tippingBase/received';
  static String getPostTips(String postId) => '$tippingBase/post/$postId';

  /// DAO Endpoints
  static const String daoBase = '/dao';
  static const String createDao = daoBase;
  static String getDao(String daoId) => '$daoBase/$daoId';
  static String joinDao(String daoId) => '$daoBase/$daoId/join';
  static String getDaoProposals(String daoId) => '$daoBase/$daoId/proposals';
  static String voteProposal(String daoId, String proposalId) => '$daoBase/$daoId/proposals/$proposalId/vote';
}
