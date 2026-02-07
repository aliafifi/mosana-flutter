/// UserModel - Simplified version without json_serializable
/// For mock data and basic functionality
class UserModel {
  final String? id;
  final String walletAddress;
  final String? username;
  final String? bio;
  final String? profileImage;
  final String? nftProfilePicture;
  final String? solDomain;
  final double totalEarned;
  final int followersCount;
  final int followingCount;
  final List<String> following;
  final double? charityPledgePercentage;
  final String? selectedCause;
  final bool isActive;
  final DateTime? lastLogin;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  
  // Additional fields for UI
  final bool isVerified;
  final int postsCount;

  UserModel({
    this.id,
    required this.walletAddress,
    this.username,
    this.bio,
    this.profileImage,
    this.nftProfilePicture,
    this.solDomain,
    this.totalEarned = 0,
    this.followersCount = 0,
    this.followingCount = 0,
    this.following = const [],
    this.charityPledgePercentage,
    this.selectedCause,
    this.isActive = true,
    this.lastLogin,
    this.createdAt,
    this.updatedAt,
    this.isVerified = false,
    this.postsCount = 0,
  });

  /// From JSON (manual parsing)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? json['id'],
      walletAddress: json['walletAddress'] ?? '',
      username: json['username'],
      bio: json['bio'],
      profileImage: json['profileImage'],
      nftProfilePicture: json['nftProfilePicture'],
      solDomain: json['solDomain'],
      totalEarned: (json['totalEarned'] ?? 0).toDouble(),
      followersCount: json['followersCount'] ?? 0,
      followingCount: json['followingCount'] ?? 0,
      following: (json['following'] as List<dynamic>?)?.cast<String>() ?? [],
      charityPledgePercentage: json['charityPledgePercentage']?.toDouble(),
      selectedCause: json['selectedCause'],
      isActive: json['isActive'] ?? true,
      lastLogin: json['lastLogin'] != null ? DateTime.parse(json['lastLogin']) : null,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      isVerified: json['isVerified'] ?? false,
      postsCount: json['postsCount'] ?? 0,
    );
  }

  /// From Map (for mock data compatibility)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      walletAddress: map['wallet'] ?? map['walletAddress'] ?? '',
      username: map['username'],
      bio: map['bio'],
      profileImage: map['avatar'] ?? map['profileImage'],
      isVerified: map['verified'] ?? map['isVerified'] ?? false,
      postsCount: map['posts'] ?? map['postsCount'] ?? 0,
      followersCount: map['followersCount'] ?? 0,
      followingCount: map['followingCount'] ?? 0,
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'walletAddress': walletAddress,
      'username': username,
      'bio': bio,
      'profileImage': profileImage,
      'nftProfilePicture': nftProfilePicture,
      'solDomain': solDomain,
      'totalEarned': totalEarned,
      'followersCount': followersCount,
      'followingCount': followingCount,
      'following': following,
      'charityPledgePercentage': charityPledgePercentage,
      'selectedCause': selectedCause,
      'isActive': isActive,
      'lastLogin': lastLogin?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'isVerified': isVerified,
      'postsCount': postsCount,
    };
  }

  /// Get display name (username or shortened wallet address)
  String get displayName {
    if (username != null && username!.isNotEmpty) {
      return username!;
    }
    return '${walletAddress.substring(0, 4)}...${walletAddress.substring(walletAddress.length - 4)}';
  }

  /// Get profile picture URL (NFT PFP or regular profile image)
  String? get profilePictureUrl {
    return nftProfilePicture ?? profileImage;
  }

  /// Check if user has verified NFT profile picture
  bool get hasNftPfp => nftProfilePicture != null && nftProfilePicture!.isNotEmpty;

  /// Copy with method for state updates
  UserModel copyWith({
    String? id,
    String? walletAddress,
    String? username,
    String? bio,
    String? profileImage,
    String? nftProfilePicture,
    String? solDomain,
    double? totalEarned,
    int? followersCount,
    int? followingCount,
    List<String>? following,
    double? charityPledgePercentage,
    String? selectedCause,
    bool? isActive,
    DateTime? lastLogin,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isVerified,
    int? postsCount,
  }) {
    return UserModel(
      id: id ?? this.id,
      walletAddress: walletAddress ?? this.walletAddress,
      username: username ?? this.username,
      bio: bio ?? this.bio,
      profileImage: profileImage ?? this.profileImage,
      nftProfilePicture: nftProfilePicture ?? this.nftProfilePicture,
      solDomain: solDomain ?? this.solDomain,
      totalEarned: totalEarned ?? this.totalEarned,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      following: following ?? this.following,
      charityPledgePercentage: charityPledgePercentage ?? this.charityPledgePercentage,
      selectedCause: selectedCause ?? this.selectedCause,
      isActive: isActive ?? this.isActive,
      lastLogin: lastLogin ?? this.lastLogin,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isVerified: isVerified ?? this.isVerified,
      postsCount: postsCount ?? this.postsCount,
    );
  }
}
