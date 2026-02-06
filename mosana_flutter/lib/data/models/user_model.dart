import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: '_id')
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
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

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
    );
  }
}
