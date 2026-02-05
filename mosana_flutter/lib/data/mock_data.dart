/// Mock data for Mosana app - Posts, trending topics, rewards
class MockData {
  // Trending topics from your HTML
  static final List<Map<String, String>> trendingTopics = [
    {'tag': '#SocialGood', 'count': '1.2K'},
    {'tag': '#Web3', 'count': '856'},
    {'tag': '#ImmortalPosts', 'count': '642'},
    {'tag': '#DAO', 'count': '521'},
  ];

  // Daily rewards amount
  static final Map<String, dynamic> dailyRewards = {
    'amount': 2450,
    'currency': 'MOSANA',
    'multiplier': 5.0,
    'canClaim': true,
  };

  // Sample posts from your HTML prototype
  static final List<Map<String, dynamic>> posts = [
    {
      'id': '1',
      'author': 'Aya Kimura',
      'initials': 'AK',
      'badge': 'Elite',
      'verified': true,
      'time': '2h',
      'content': 'Just donated 50% of my weekly tips to clean water projects in Kenya. Mosana makes giving back so easy 💙',
      'hasImage': true,
      'likes': 342,
      'comments': 24,
      'tips': 12.5,
      'shares': 8,
      'isLiked': false,
      'isMinted': false,
    },
    {
      'id': '2',
      'author': 'Sofia Fernandez',
      'initials': 'SF',
      'badge': 'Legend',
      'verified': true,
      'time': '5h',
      'content': 'The 5× multiplier is insane. Earned more this week than the entire month on traditional platforms 🚀',
      'hasImage': false,
      'likes': 198,
      'comments': 15,
      'tips': 8.2,
      'shares': 5,
      'isLiked': false,
      'isMinted': false,
    },
    {
      'id': '3',
      'author': 'Omar Bakari',
      'initials': 'OB',
      'badge': 'Champion',
      'verified': true,
      'time': '1d',
      'content': 'First time using token-gated DAOs. The governance features here are light-years ahead of Web2 ✨',
      'hasImage': true,
      'likes': 276,
      'comments': 31,
      'tips': 15.3,
      'shares': 12,
      'isLiked': false,
      'isMinted': false,
    },
    {
      'id': '4',
      'author': 'Li Ming',
      'initials': 'LM',
      'badge': 'Legend',
      'verified': true,
      'time': '2d',
      'content': 'Minted my first Immortal Post as an NFT. Now I\'ll earn royalties every time it\'s shared. This is the future 🔥',
      'hasImage': false,
      'likes': 412,
      'comments': 48,
      'tips': 22.1,
      'shares': 19,
      'isLiked': false,
      'isMinted': false,
    },
  ];
}
