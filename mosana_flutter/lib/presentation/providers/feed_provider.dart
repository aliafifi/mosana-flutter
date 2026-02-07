import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/post_repository.dart';
import 'auth_provider.dart';

// ===================== FEED STATE =====================

/// Feed state provider
final feedProvider = StateNotifierProvider<FeedNotifier, FeedState>((ref) {
  final repository = ref.watch(postRepositoryProvider);
  return FeedNotifier(repository: repository);
});

/// Feed state notifier
class FeedNotifier extends StateNotifier<FeedState> {
  final PostRepository _repository;
  int _currentPage = 1;
  String? _nextCursor;

  FeedNotifier({required PostRepository repository})
      : _repository = repository,
        super(const FeedState.initial()) {
    // Load initial feed
    loadFeed();
  }

  /// Load feed (initial load or refresh)
  Future<void> loadFeed({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _nextCursor = null;
      state = const FeedState.loading(isRefresh: true);
    } else {
      state = const FeedState.loading(isRefresh: false);
    }

    final result = await _repository.getFeed(
      page: _currentPage,
      cursor: _nextCursor,
    );

    if (result.success && result.posts != null) {
      state = FeedState.loaded(
        posts: result.posts!,
        hasMore: result.hasMore,
      );
      _nextCursor = result.nextCursor;
    } else {
      state = FeedState.error(result.error ?? 'Failed to load feed');
    }
  }

  /// Load more posts (pagination)
  Future<void> loadMore() async {
    // Don't load if already loading or no more posts
    if (state is _FeedStateLoading || !_hasMore()) {
      return;
    }

    final currentPosts = _getPosts();
    state = FeedState.loadingMore(posts: currentPosts);

    _currentPage++;
    final result = await _repository.getFeed(
      page: _currentPage,
      cursor: _nextCursor,
    );

    if (result.success && result.posts != null) {
      // Append new posts to existing ones
      final allPosts = [...currentPosts, ...result.posts!];
      state = FeedState.loaded(
        posts: allPosts,
        hasMore: result.hasMore,
      );
      _nextCursor = result.nextCursor;
    } else {
      // Keep current posts on error
      state = FeedState.loaded(
        posts: currentPosts,
        hasMore: _hasMore(),
      );
    }
  }

  /// Refresh feed (pull to refresh)
  Future<void> refresh() async {
    await loadFeed(refresh: true);
  }

  /// Toggle like on a post (optimistic update)
  Future<void> toggleLike(String postId) async {
    final posts = _getPosts();
    final postIndex = posts.indexWhere((p) => p['id'] == postId);
    
    if (postIndex == -1) return;

    // Optimistic update
    final post = Map<String, dynamic>.from(posts[postIndex]);
    final wasLiked = post['liked'] as bool? ?? false;
    post['liked'] = !wasLiked;
    post['likesCount'] = (post['likesCount'] as int) + (wasLiked ? -1 : 1);

    final updatedPosts = List<Map<String, dynamic>>.from(posts);
    updatedPosts[postIndex] = post;

    state = FeedState.loaded(
      posts: updatedPosts,
      hasMore: _hasMore(),
    );

    // Make API call
    final result = await _repository.toggleLike(postId, wasLiked);

    if (!result.success) {
      // Revert on error
      final revertedPosts = List<Map<String, dynamic>>.from(posts);
      state = FeedState.loaded(
        posts: revertedPosts,
        hasMore: _hasMore(),
      );
    }
  }

  /// Update post after comment added
  void incrementCommentCount(String postId) {
    final posts = _getPosts();
    final postIndex = posts.indexWhere((p) => p['id'] == postId);
    
    if (postIndex == -1) return;

    final post = Map<String, dynamic>.from(posts[postIndex]);
    post['commentsCount'] = (post['commentsCount'] as int) + 1;

    final updatedPosts = List<Map<String, dynamic>>.from(posts);
    updatedPosts[postIndex] = post;

    state = FeedState.loaded(
      posts: updatedPosts,
      hasMore: _hasMore(),
    );
  }

  /// Update post after tip sent
  void incrementTipCount(String postId, double amount) {
    final posts = _getPosts();
    final postIndex = posts.indexWhere((p) => p['id'] == postId);
    
    if (postIndex == -1) return;

    final post = Map<String, dynamic>.from(posts[postIndex]);
    post['tipsCount'] = (post['tipsCount'] as int) + 1;
    post['tipAmount'] = (post['tipAmount'] as num) + amount;

    final updatedPosts = List<Map<String, dynamic>>.from(posts);
    updatedPosts[postIndex] = post;

    state = FeedState.loaded(
      posts: updatedPosts,
      hasMore: _hasMore(),
    );
  }

  /// Update post after minted
  void markAsMinted(String postId) {
    final posts = _getPosts();
    final postIndex = posts.indexWhere((p) => p['id'] == postId);
    
    if (postIndex == -1) return;

    final post = Map<String, dynamic>.from(posts[postIndex]);
    post['isMinted'] = true;

    final updatedPosts = List<Map<String, dynamic>>.from(posts);
    updatedPosts[postIndex] = post;

    state = FeedState.loaded(
      posts: updatedPosts,
      hasMore: _hasMore(),
    );
  }

  /// Add new post to feed (after creation)
  void addPost(Map<String, dynamic> post) {
    final posts = _getPosts();
    final updatedPosts = [post, ...posts];

    state = FeedState.loaded(
      posts: updatedPosts,
      hasMore: _hasMore(),
    );
  }

  // Helper methods
  List<Map<String, dynamic>> _getPosts() {
    return switch (state) {
      FeedStateLoaded(posts: final p) => p,
      FeedStateLoadingMore(posts: final p) => p,
      _ => [],
    };
  }

  bool _hasMore() {
    return switch (state) {
      FeedStateLoaded(hasMore: final h) => h,
      FeedStateLoadingMore(hasMore: final h) => h,
      _ => false,
    };
  }
}

/// Feed state sealed class
sealed class FeedState {
  const FeedState();

  const factory FeedState.initial() = FeedStateInitial;
  const factory FeedState.loading({bool isRefresh}) = FeedStateLoading;
  const factory FeedState.loaded({
    required List<Map<String, dynamic>> posts,
    bool hasMore,
  }) = FeedStateLoaded;
  const factory FeedState.loadingMore({
    required List<Map<String, dynamic>> posts,
    bool hasMore,
  }) = FeedStateLoadingMore;
  const factory FeedState.error(String message) = FeedStateError;
}

class FeedStateInitial extends FeedState {
  const FeedStateInitial();
}

class FeedStateLoading extends FeedState {
  final bool isRefresh;
  const FeedStateLoading({this.isRefresh = false});
}

class FeedStateLoaded extends FeedState {
  final List<Map<String, dynamic>> posts;
  final bool hasMore;

  const FeedStateLoaded({
    required this.posts,
    this.hasMore = false,
  });
}

class FeedStateLoadingMore extends FeedState {
  final List<Map<String, dynamic>> posts;
  final bool hasMore;

  const FeedStateLoadingMore({
    required this.posts,
    this.hasMore = false,
  });
}

class FeedStateError extends FeedState {
  final String message;
  const FeedStateError(this.message);
}

// ===================== POST ACTIONS =====================

/// Individual post action provider (for like, comment, tip, mint)
final postActionProvider = Provider.family<PostActions, String>((ref, postId) {
  final repository = ref.watch(postRepositoryProvider);
  final feedNotifier = ref.read(feedProvider.notifier);
  return PostActions(
    repository: repository,
    feedNotifier: feedNotifier,
    postId: postId,
  );
});

/// Post actions helper class
class PostActions {
  final PostRepository repository;
  final FeedNotifier feedNotifier;
  final String postId;

  PostActions({
    required this.repository,
    required this.feedNotifier,
    required this.postId,
  });

  /// Toggle like
  Future<bool> toggleLike() async {
    await feedNotifier.toggleLike(postId);
    return true;
  }

  /// Add comment
  Future<bool> addComment(String content) async {
    final result = await repository.addComment(
      postId: postId,
      content: content,
    );

    if (result.success) {
      feedNotifier.incrementCommentCount(postId);
      return true;
    }

    return false;
  }

  /// Send tip
  Future<bool> sendTip(double amount, {String? message}) async {
    final result = await repository.sendTip(
      postId: postId,
      amount: amount,
      message: message,
    );

    if (result.success) {
      feedNotifier.incrementTipCount(postId, amount);
      return true;
    }

    return false;
  }

  /// Mint post as NFT
  Future<bool> mintPost() async {
    final result = await repository.mintPost(postId);

    if (result.success) {
      feedNotifier.markAsMinted(postId);
      return true;
    }

    return false;
  }
}
