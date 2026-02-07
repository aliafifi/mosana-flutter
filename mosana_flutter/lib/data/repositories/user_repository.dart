import '../core/services/api_service.dart';
import '../core/utils/logger.dart';
import '../data/models/user_model.dart';
import '../data/models/post_model.dart';

/// Result type for repository operations
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends Result<T> {
  final String error;
  const Failure(this.error);
}

/// Repository for user operations
class UserRepository {
  final ApiService _apiService;
  
  UserRepository({required ApiService apiService})
      : _apiService = apiService;
  
  /// Get user profile by wallet address
  Future<Result<UserModel>> getUserProfile(String walletAddress) async {
    try {
      AppLogger.logInfo('Fetching user profile: $walletAddress');
      
      final response = await _apiService.getUser(walletAddress);
      
      if (response.isSuccess && response.data != null) {
        final user = UserModel.fromJson(response.data!);
        AppLogger.logInfo('✅ Fetched user profile: ${user.username}');
        return Success(user);
      } else {
        final error = response.error ?? 'Failed to fetch user profile';
        AppLogger.logError('❌ Failed to fetch user profile: $error');
        return Failure(error);
      }
    } catch (e, stackTrace) {
      AppLogger.logError('Error fetching user profile: $e', e, stackTrace);
      return Failure(e.toString());
    }
  }
  
  /// Update user profile
  Future<Result<UserModel>> updateProfile({
    String? username,
    String? bio,
    String? avatarUrl,
  }) async {
    try {
      AppLogger.logInfo('Updating user profile');
      
      final updates = <String, dynamic>{
        if (username != null) 'username': username,
        if (bio != null) 'bio': bio,
        if (avatarUrl != null) 'avatarUrl': avatarUrl,
      };
      
      final response = await _apiService.updateProfile(updates);
      
      if (response.isSuccess && response.data != null) {
        final user = UserModel.fromJson(response.data!);
        AppLogger.logInfo('✅ Profile updated successfully');
        return Success(user);
      } else {
        final error = response.error ?? 'Failed to update profile';
        AppLogger.logError('❌ Failed to update profile: $error');
        return Failure(error);
      }
    } catch (e, stackTrace) {
      AppLogger.logError('Error updating profile: $e', e, stackTrace);
      return Failure(e.toString());
    }
  }
  
  /// Follow a user
  Future<Result<void>> followUser(String userId) async {
    try {
      AppLogger.logInfo('Following user: $userId');
      
      final response = await _apiService.followUser(userId);
      
      if (response.isSuccess) {
        AppLogger.logInfo('✅ User followed successfully');
        return const Success(null);
      } else {
        final error = response.error ?? 'Failed to follow user';
        AppLogger.logError('❌ Failed to follow user: $error');
        return Failure(error);
      }
    } catch (e, stackTrace) {
      AppLogger.logError('Error following user: $e', e, stackTrace);
      return Failure(e.toString());
    }
  }
  
  /// Unfollow a user
  Future<Result<void>> unfollowUser(String userId) async {
    try {
      AppLogger.logInfo('Unfollowing user: $userId');
      
      final response = await _apiService.unfollowUser(userId);
      
      if (response.isSuccess) {
        AppLogger.logInfo('✅ User unfollowed successfully');
        return const Success(null);
      } else {
        final error = response.error ?? 'Failed to unfollow user';
        AppLogger.logError('❌ Failed to unfollow user: $error');
        return Failure(error);
      }
    } catch (e, stackTrace) {
      AppLogger.logError('Error unfollowing user: $e', e, stackTrace);
      return Failure(e.toString());
    }
  }
  
  /// Get user's posts
  Future<Result<List<PostModel>>> getUserPosts(
    String walletAddress, {
    int page = 1,
    int limit = 20,
  }) async {
    try {
      AppLogger.logInfo('Fetching user posts: $walletAddress (page: $page)');
      
      final response = await _apiService.getUserPosts(
        walletAddress,
        page: page,
        limit: limit,
      );
      
      if (response.isSuccess && response.data != null) {
        final posts = response.data!
            .map((json) => PostModel.fromJson(json))
            .toList();
        
        AppLogger.logInfo('✅ Fetched ${posts.length} user posts');
        return Success(posts);
      } else {
        final error = response.error ?? 'Failed to fetch user posts';
        AppLogger.logError('❌ Failed to fetch user posts: $error');
        return Failure(error);
      }
    } catch (e, stackTrace) {
      AppLogger.logError('Error fetching user posts: $e', e, stackTrace);
      return Failure(e.toString());
    }
  }
  
  /// Get user's followers
  Future<Result<List<UserModel>>> getFollowers(
    String userId, {
    int page = 1,
    int limit = 20,
  }) async {
    try {
      AppLogger.logInfo('Fetching followers: $userId (page: $page)');
      
      final response = await _apiService.getFollowers(
        userId,
        page: page,
        limit: limit,
      );
      
      if (response.isSuccess && response.data != null) {
        final followers = response.data!
            .map((json) => UserModel.fromJson(json))
            .toList();
        
        AppLogger.logInfo('✅ Fetched ${followers.length} followers');
        return Success(followers);
      } else {
        final error = response.error ?? 'Failed to fetch followers';
        AppLogger.logError('❌ Failed to fetch followers: $error');
        return Failure(error);
      }
    } catch (e, stackTrace) {
      AppLogger.logError('Error fetching followers: $e', e, stackTrace);
      return Failure(e.toString());
    }
  }
  
  /// Get users that this user is following
  Future<Result<List<UserModel>>> getFollowing(
    String userId, {
    int page = 1,
    int limit = 20,
  }) async {
    try {
      AppLogger.logInfo('Fetching following: $userId (page: $page)');
      
      final response = await _apiService.getFollowing(
        userId,
        page: page,
        limit: limit,
      );
      
      if (response.isSuccess && response.data != null) {
        final following = response.data!
            .map((json) => UserModel.fromJson(json))
            .toList();
        
        AppLogger.logInfo('✅ Fetched ${following.length} following');
        return Success(following);
      } else {
        final error = response.error ?? 'Failed to fetch following';
        AppLogger.logError('❌ Failed to fetch following: $error');
        return Failure(error);
      }
    } catch (e, stackTrace) {
      AppLogger.logError('Error fetching following: $e', e, stackTrace);
      return Failure(e.toString());
    }
  }
  
  /// Search users
  Future<Result<List<UserModel>>> searchUsers(
    String query, {
    int page = 1,
    int limit = 20,
  }) async {
    try {
      AppLogger.logInfo('Searching users: "$query" (page: $page)');
      
      final response = await _apiService.searchUsers(
        query,
        page: page,
        limit: limit,
      );
      
      if (response.isSuccess && response.data != null) {
        final users = response.data!
            .map((json) => UserModel.fromJson(json))
            .toList();
        
        AppLogger.logInfo('✅ Found ${users.length} users');
        return Success(users);
      } else {
        final error = response.error ?? 'Failed to search users';
        AppLogger.logError('❌ Failed to search users: $error');
        return Failure(error);
      }
    } catch (e, stackTrace) {
      AppLogger.logError('Error searching users: $e', e, stackTrace);
      return Failure(e.toString());
    }
  }
  
  /// Get user stats (posts, followers, following, tips received)
  Future<Result<Map<String, int>>> getUserStats(String userId) async {
    try {
      AppLogger.logInfo('Fetching user stats: $userId');
      
      final response = await _apiService.getUserStats(userId);
      
      if (response.isSuccess && response.data != null) {
        final stats = {
          'posts': response.data!['postsCount'] as int? ?? 0,
          'followers': response.data!['followersCount'] as int? ?? 0,
          'following': response.data!['followingCount'] as int? ?? 0,
          'tipsReceived': response.data!['tipsReceived'] as int? ?? 0,
          'impactScore': response.data!['impactScore'] as int? ?? 0,
        };
        
        AppLogger.logInfo('✅ Fetched user stats');
        return Success(stats);
      } else {
        final error = response.error ?? 'Failed to fetch user stats';
        AppLogger.logError('❌ Failed to fetch user stats: $error');
        return Failure(error);
      }
    } catch (e, stackTrace) {
      AppLogger.logError('Error fetching user stats: $e', e, stackTrace);
      return Failure(e.toString());
    }
  }
}
