/// Simple PostModel for mock data
/// This is a placeholder until we integrate with the real backend
class PostModel {
  final String id;
  final String content;
  final String authorId;
  final String authorName;
  final String? authorAvatar;
  final bool authorIsVerified;
  final String? imageUrl;
  final DateTime createdAt;
  final int likesCount;
  final int commentsCount;
  final int tipsCount;
  final bool isLiked;
  final bool isMinted;

  PostModel({
    required this.id,
    required this.content,
    required this.authorId,
    this.authorName = 'User',
    this.authorAvatar,
    this.authorIsVerified = false,
    this.imageUrl,
    required this.createdAt,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.tipsCount = 0,
    this.isLiked = false,
    this.isMinted = false,
  });

  // From Map (for mock data)
  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] ?? '',
      content: map['content'] ?? '',
      authorId: map['authorId'] ?? '',
      authorName: map['authorName'] ?? map['author']?['username'] ?? 'User',
      authorAvatar: map['authorAvatar'] ?? map['author']?['avatar'],
      authorIsVerified: map['authorIsVerified'] ?? map['author']?['verified'] ?? false,
      imageUrl: map['image'],
      createdAt: DateTime.now(),
      likesCount: map['likes'] ?? 0,
      commentsCount: map['comments'] ?? 0,
      tipsCount: map['tips'] ?? 0,
      isLiked: map['isLiked'] ?? false,
      isMinted: map['isMinted'] ?? false,
    );
  }

  // To Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'authorId': authorId,
      'authorName': authorName,
      'authorAvatar': authorAvatar,
      'authorIsVerified': authorIsVerified,
      'image': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'likes': likesCount,
      'comments': commentsCount,
      'tips': tipsCount,
      'isLiked': isLiked,
      'isMinted': isMinted,
    };
  }
}
