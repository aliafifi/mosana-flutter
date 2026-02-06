# 🎨 MOSANA FLUTTER - COMPLETE UI/UX DESIGN SPEC
**Date**: 2026-02-06  
**Version**: 1.0  
**Status**: Design Phase

---

## 🌟 DESIGN PHILOSOPHY

### Core Principles:
1. **Solana-Native Feel**: Fast, fluid, futuristic (like Phantom wallet)
2. **Dark-First**: Crypto users love dark mode
3. **Glassmorphism**: Modern frosted glass effects
4. **Micro-animations**: Everything feels alive
5. **Gradient Accents**: Purple-to-blue Mosana brand
6. **Bold Typography**: Clear hierarchy, easy scanning
7. **Accessible**: WCAG AA compliant
8. **Performance**: 60 FPS scrolling, instant feedback

### Visual Identity:
- **Primary**: Mosana Purple (#4B2D8F) + Mosana Blue (#4A7FD9)
- **Background**: Deep Purple Black (#0F0F1E), Card Surface (#1A1A2E)
- **Accents**: Gold (#F59E0B) for tips/rewards, Green (#10B981) for success, Red (#EF4444) for errors
- **Typography**: SF Pro (iOS) / Roboto (Android) - System fonts for performance

---

## 📱 COMPLETE SCREEN INVENTORY (17 Screens)

### 🔐 Authentication Flow (3 screens)
1. Splash Screen ✅ (Already exists - enhance it)
2. Onboarding Screen ✅ (Already exists - enhance it)
3. Connect Wallet Screen ⭐ NEW

### 🏠 Main App (4 screens + Bottom Nav)
4. Home Feed Screen ✅ (Already exists - major redesign)
5. Explore Screen ⭐ NEW (Trending, Discovery)
6. DAO Governance Screen ⭐ NEW
7. Wallet Screen ⭐ NEW
8. Profile Screen ⭐ NEW

### 🔔 Notifications (2 screens)
9. Notifications Screen ⭐ NEW (Our current focus!)
10. Notification Settings Screen ⭐ NEW

### 📝 Posts (3 screens)
11. Create Post Screen ⭐ NEW
12. Post Detail Screen ⭐ NEW
13. Post Comments Screen ⭐ NEW

### 👤 User Profile (2 screens)
14. User Profile Screen ⭐ NEW (Public view)
15. Edit Profile Screen ⭐ NEW

### 💰 Tipping & Rewards (2 screens)
16. Send Tip Screen ⭐ NEW (Bottom sheet)
17. Tip History Screen ⭐ NEW

### 🎨 NFT Features (1 screen)
18. Mint Post as NFT Screen ⭐ NEW (Bottom sheet)

---

## 🎨 SCREEN-BY-SCREEN DESIGN SPECS

---

### 1. ✅ SPLASH SCREEN (Enhanced)

**Current State**: Logo + fade animation (2 seconds)

**Enhancements**:
```dart
// Add these improvements:
- Animated gradient background (subtle pulse)
- Logo with glow effect
- Loading dots animation (like Phantom)
- Version number at bottom
- Solana logo badge (small, subtle)
```

**Visual Design**:
```
┌─────────────────────────┐
│                         │
│                         │
│        [Pulsing]        │
│      Gradient BG        │
│                         │
│      [Mosana Logo]      │ <- Glow effect
│         with            │
│      Shimmer Effect     │
│                         │
│      ● ● ●              │ <- Loading dots
│                         │
│                         │
│   v1.0.0 - Powered by   │
│       [Solana]          │ <- Small Solana logo
└─────────────────────────┘
```

**Animations**:
1. Background gradient rotates (slow)
2. Logo fades in with scale (0.8 → 1.0)
3. Logo glows (pulse effect)
4. Loading dots animate (wave pattern)
5. Total duration: 2-3 seconds

---

### 2. ✅ ONBOARDING SCREEN (Enhanced)

**Current State**: Single page with features + Connect Wallet button

**Enhancements**:
```dart
// Transform into modern swipeable carousel:
- 3 slides with swipe gestures
- Page indicators (dots)
- Skip button (top right)
- Animated illustrations (Lottie or Rive)
- Final slide = Connect Wallet CTA
```

**Slide 1: Value Proposition**
```
┌─────────────────────────┐
│  Skip →              [X]│
│                         │
│    [Animated Image]     │ <- Lottie: Solana transaction
│     Solana speed        │
│                         │
│   ⚡ Lightning Fast      │
│                         │
│  Built on Solana, the   │
│  fastest blockchain.    │
│  Instant tips, zero lag │
│                         │
│   ● ○ ○                 │ <- Page indicators
│                         │
│      [Next →]           │
└─────────────────────────┘
```

**Slide 2: Ethical Finance**
```
┌─────────────────────────┐
│  Skip →              [X]│
│                         │
│    [Animated Image]     │ <- Lottie: Rewards growing
│     Ethical rewards     │
│                         │
│   🌱 Fair & Ethical     │
│                         │
│  No bots, no speculation│
│  Real humans, real value│
│  5× rewards for verified│
│                         │
│   ○ ● ○                 │
│                         │
│      [Next →]           │
└─────────────────────────┘
```

**Slide 3: Social Good**
```
┌─────────────────────────┐
│                      [X]│
│                         │
│    [Animated Image]     │ <- Lottie: Charity impact
│     Impact creating     │
│                         │
│   ❤️ Social Impact      │
│                         │
│  Every tip funds real   │
│  social good. Make an   │
│  impact while you earn  │
│                         │
│   ○ ○ ●                 │
│                         │
│  [🔗 Connect Wallet]    │ <- Big gradient button
└─────────────────────────┘
```

**Animations**:
- Each slide has its own Lottie animation
- Smooth swipe transitions
- Page indicators animate on change
- Final CTA button pulses (subtle)

---

### 3. ⭐ CONNECT WALLET SCREEN (NEW - Critical!)

**Purpose**: Let users connect Phantom, Solflare, or Saga wallets

**Design Inspiration**: Phantom's connection flow (best in class)

```
┌─────────────────────────┐
│  ← Back                 │
│                         │
│   [Mosana Logo]         │
│                         │
│  Connect Your Wallet    │
│                         │
│  Choose your preferred  │
│  Solana wallet to get   │
│  started                │
│                         │
│  ┌─────────────────┐    │
│  │ [Phantom Logo]  │    │ <- Card with hover effect
│  │   Phantom       │    │
│  │   Recommended ✓ │    │
│  └─────────────────┘    │
│                         │
│  ┌─────────────────┐    │
│  │ [Solflare Logo] │    │
│  │   Solflare      │    │
│  └─────────────────┘    │
│                         │
│  ┌─────────────────┐    │
│  │ [Saga Logo]     │    │
│  │   Saga          │    │
│  └─────────────────┘    │
│                         │
│  🔒 Secure connection   │
│     via deep linking    │
└─────────────────────────┘
```

**Features**:
- Each wallet card has gradient border on hover
- Tap opens wallet app (deep link)
- If wallet not installed → redirect to store
- Loading state while connecting
- Error handling (wallet declined, timeout)

**Micro-interactions**:
1. Cards scale on tap (1.0 → 0.95 → 1.0)
2. Gradient border animates on hover
3. Success checkmark animation
4. Confetti effect on successful connection 🎉

---

### 4. ✅ HOME FEED SCREEN (Major Redesign!)

**Current State**: Basic list of posts

**New Design**: Instagram/Twitter-inspired, Solana-enhanced

```
┌─────────────────────────┐
│ [Logo] Mosana  [🔔] [👤]│ <- Sticky header
├─────────────────────────┤
│                         │
│ ┌─────────────────────┐ │ <- Story-like circles
│ │ ●  ●  ●  ●  ●  ● → │ │    (Trending topics)
│ └─────────────────────┘ │
│                         │
│ ┌─────────────────────┐ │
│ │ [@alice] verified ✓ │ │ <- Post card
│ │ 2 hours ago         │ │
│ ├─────────────────────┤ │
│ │ Just minted my first│ │
│ │ post as an NFT! 🎉  │ │
│ │                     │ │
│ │ [Image Preview]     │ │
│ │                     │ │
│ ├─────────────────────┤ │
│ │ ❤️ 45  💬 12  💰 5  │ │ <- Action buttons
│ │ 🖼️ Mint  🔗 Share   │ │
│ └─────────────────────┘ │
│                         │
│ ┌─────────────────────┐ │
│ │ [@bob] 🔥 IMMORTAL │ │ <- Minted post
│ │ 5 hours ago         │ │    (gold gradient)
│ ├─────────────────────┤ │
│ │ This post is now an │ │
│ │ NFT on Solana! ✨   │ │
│ │                     │ │
│ │ [Image with badge]  │ │
│ │  🔥 IMMORTAL POST   │ │
│ ├─────────────────────┤ │
│ │ ❤️ 128  💬 34  💰 18│ │
│ │ 🔍 View NFT         │ │
│ └─────────────────────┘ │
│                         │
└─────────────────────────┘
│ [🏠] [🔍] [➕] [⚖️] [👤]│ <- Bottom nav
└─────────────────────────┘
```

**Key Features**:

1. **Sticky Header**:
   - Logo (left)
   - Notification bell with badge (right)
   - Profile avatar (right)
   - Gradient background with blur

2. **Trending Topics Bar** (Story-style horizontal scroll):
   - Circular avatars with trending hashtags
   - Tap to filter feed by topic
   - Example: #Web3, #Solana, #SocialGood

3. **Post Cards** (Two variants):
   - **Regular Post**: White/gray card
   - **Minted NFT Post**: Gold gradient border + badge

4. **Post Card Elements**:
   - Author avatar + username + verified badge
   - Timestamp (relative: "2h ago")
   - Post content (text + optional image/video)
   - Action buttons:
     - ❤️ Like (with count)
     - 💬 Comment (with count)
     - 💰 Tip (with count + total amount)
     - 🖼️ Mint (if not minted)
     - 🔗 Share
     - 🔍 View NFT (if minted)

5. **Minted Post Special Treatment**:
   - Gold gradient border
   - Animated shimmer effect
   - "🔥 IMMORTAL POST" badge
   - Glow effect on scroll

6. **Infinite Scroll**:
   - Pagination with shimmer loading
   - Pull-to-refresh with Mosana logo animation

**Micro-animations**:
- Like button: Heart animation (scale + color)
- Tip button: Coin flip animation
- Mint button: Sparkle effect
- Comment button: Speech bubble bounce
- Share button: Share icon spreads
- Pull-to-refresh: Logo rotates + glows

---

### 5. ⭐ EXPLORE SCREEN (NEW - Discovery!)

**Purpose**: Discover trending content, users, DAOs

```
┌─────────────────────────┐
│  Explore                │
│  [Search bar]       [⚙️]│
├─────────────────────────┤
│                         │
│ 🔥 Trending             │
│ ┌────┐ ┌────┐ ┌────┐   │ <- Horizontal scroll
│ │Post│ │Post│ │Post│   │    (Large cards)
│ │ 1  │ │ 2  │ │ 3  │   │
│ └────┘ └────┘ └────┘   │
│                         │
│ 👥 Top Creators         │
│ ┌─────────────────────┐ │
│ │ [@alice] 💎         │ │
│ │ 12.5K followers     │ │
│ │ [Follow +]          │ │
│ └─────────────────────┘ │
│ ┌─────────────────────┐ │
│ │ [@bob] ✨           │ │
│ │ 8.2K followers      │ │
│ │ [Following ✓]       │ │
│ └─────────────────────┘ │
│                         │
│ ⚖️ Active DAOs          │
│ ┌─────────────────────┐ │
│ │ Climate Action DAO  │ │
│ │ 234 members         │ │
│ │ [Join +]            │ │
│ └─────────────────────┘ │
│                         │
│ 🏷️ Trending Tags       │
│ #Web3  #Solana  #DeFi  │
│ #SocialGood  #NFTs     │
└─────────────────────────┘
```

**Sections**:
1. **Search Bar**: Fuzzy search (users, posts, tags)
2. **Trending Posts**: Horizontal carousel (large cards)
3. **Top Creators**: List with follow buttons
4. **Active DAOs**: List with join buttons
5. **Trending Tags**: Tappable tag clouds

---

### 6. ⭐ DAO GOVERNANCE SCREEN (NEW)

**Purpose**: Participate in DAO proposals & voting

```
┌─────────────────────────┐
│  DAO Governance         │
│  [Create Proposal +]    │
├─────────────────────────┤
│                         │
│ Active Proposals (3)    │
│                         │
│ ┌─────────────────────┐ │
│ │ 🗳️ Proposal #42     │ │
│ │ Increase charity    │ │
│ │ pledge to 5%        │ │
│ ├─────────────────────┤ │
│ │ 🟢 Yes: 67% (234)   │ │
│ │ 🔴 No:  33% (121)   │ │
│ ├─────────────────────┤ │
│ │ ⏱️ Ends in 2 days   │ │
│ │ [Vote Now]          │ │
│ └─────────────────────┘ │
│                         │
│ ┌─────────────────────┐ │
│ │ 🗳️ Proposal #41     │ │
│ │ Add new feature     │ │
│ │ request system      │ │
│ ├─────────────────────┤ │
│ │ 🟢 Yes: 82% (412)   │ │
│ │ 🔴 No:  18% (88)    │ │
│ ├─────────────────────┤ │
│ │ ✅ You voted: Yes   │ │
│ │ ⏱️ Ends in 5 days   │ │
│ └─────────────────────┘ │
│                         │
│ Past Proposals (12)     │
│ [View All →]            │
└─────────────────────────┘
```

**Features**:
- Create proposal button (requires stake)
- Active proposals with live results
- Voting progress bars (animated)
- Your vote indicator
- Countdown timer
- Past proposals archive

---

### 7. ⭐ WALLET SCREEN (NEW - Critical!)

**Purpose**: Manage MOSANA tokens, tips, rewards

```
┌─────────────────────────┐
│  Wallet                 │
│  [Settings ⚙️]          │
├─────────────────────────┤
│                         │
│  Total Balance          │
│  ┌─────────────────────┐│
│  │   12,458.32 MOSANA  ││ <- Big number
│  │   ≈ $2,491.66 USD   ││
│  └─────────────────────┘│
│                         │
│  ┌─────────┐ ┌─────────┐│
│  │  Send   │ │ Receive ││
│  └─────────┘ └─────────┘│
│                         │
│  Recent Activity        │
│  ┌─────────────────────┐│
│  │ ⬇️ Received         ││
│  │ +10.5 MOSANA        ││
│  │ from @alice         ││
│  │ 2 hours ago         ││
│  └─────────────────────┘│
│  ┌─────────────────────┐│
│  │ ⬆️ Sent              ││
│  │ -5.2 MOSANA         ││
│  │ to @bob (tip)       ││
│  │ 5 hours ago         ││
│  └─────────────────────┘│
│  ┌─────────────────────┐│
│  │ 🎁 Reward           ││
│  │ +15.8 MOSANA        ││
│  │ Daily rewards       ││
│  │ 1 day ago           ││
│  └─────────────────────┘│
│                         │
│  [View All History →]   │
└─────────────────────────┘
```

**Features**:
- Balance card with gradient background
- USD equivalent (live price)
- Send/Receive buttons (quick actions)
- Transaction history (paginated)
- Export history button
- Charts (weekly/monthly earnings)

---

### 8. ⭐ PROFILE SCREEN (NEW - Your Profile)

**Purpose**: View your profile, stats, settings

```
┌─────────────────────────┐
│  ← Back     [⚙️ Settings]│
├─────────────────────────┤
│  [Cover Image Gradient] │
│                         │
│     [Profile Pic] ✓     │ <- NFT PFP with badge
│                         │
│      @your_username     │
│      Verified Human     │
│                         │
│   "Your bio here..."    │
│                         │
│  🌐 yourname.sol        │
│  📍 Los Angeles, CA     │
│                         │
│  ┌─────┐ ┌─────┐ ┌─────┐│
│  │ 234 │ │ 567 │ │ 5.2K││
│  │Posts│ │Foll.│ │Foll.││
│  └─────┘ └─────┘ └─────┘│
│                         │
│  ┌────────────────────┐ │
│  │ 🏆 Reputation: 85  │ │
│  │ ████████░░ Tier 3  │ │
│  └────────────────────┘ │
│                         │
│  ┌────────────────────┐ │
│  │ 💰 Total Earned    │ │
│  │ 1,234.56 MOSANA    │ │
│  └────────────────────┘ │
│                         │
│  ┌────────────────────┐ │
│  │ ❤️ Social Good     │ │
│  │ 5% to charity      │ │
│  │ $123.45 donated    │ │
│  └────────────────────┘ │
│                         │
│  [🖼️ Mint Profile NFT] │
│                         │
│  ━━━ Your Posts ━━━    │
│  [Grid of posts]       │
└─────────────────────────┘
```

**Features**:
- Cover image with gradient overlay
- Profile picture (NFT PFP with shimmer)
- Verified badge (Civic Pass)
- .sol domain
- Stats cards (posts, followers, following)
- Reputation bar (animated progress)
- Total earned display
- Social good pledge indicator
- Mint profile NFT button
- Grid of user's posts (Instagram-style)

---

### 9. ⭐ NOTIFICATIONS SCREEN (NEW - Our Focus!)

**Purpose**: View all notifications (likes, comments, tips, follows)

```
┌─────────────────────────┐
│  ← Back    Notifications│
│  [Mark all read] [⚙️]   │
├─────────────────────────┤
│                         │
│  Today                  │
│  ┌─────────────────────┐│
│  │ 💰 HIGH PRIORITY    ││ <- Gold border
│  │ @alice tipped you   ││
│  │ 15.5 USDC! 🎉       ││
│  │ "Great post!"       ││
│  │ 5 minutes ago       ││
│  └─────────────────────┘│
│  ┌─────────────────────┐│
│  │ 👤 @bob followed you││
│  │ 1 hour ago          ││
│  │ [Follow Back]       ││
│  └─────────────────────┘│
│  ┌─────────────────────┐│
│  │ ❤️ @charlie liked   ││
│  │ your post           ││
│  │ "My Solana story"   ││
│  │ 2 hours ago         ││
│  └─────────────────────┘│
│                         │
│  Yesterday              │
│  ┌─────────────────────┐│
│  │ 💬 @david commented ││
│  │ "Amazing insight!"  ││
│  │ on your post        ││
│  │ 1 day ago           ││
│  └─────────────────────┘│
│  ┌─────────────────────┐│
│  │ 🏆 Reputation       ││
│  │ milestone reached!  ││
│  │ You're now Tier 3   ││
│  │ 1 day ago           ││
│  └─────────────────────┘│
│                         │
│  [Load More]            │
└─────────────────────────┘
```

**Features**:

1. **Header**:
   - Back button
   - Mark all read button
   - Settings button (→ Notification Settings)

2. **Notification Types** (with unique styling):
   - **💰 Tip Received**: Gold border, high priority
   - **👤 New Follower**: Blue accent, "Follow Back" button
   - **❤️ Post Liked**: Red heart icon
   - **💬 Comment**: Blue speech bubble
   - **🏆 Reputation Milestone**: Gold trophy
   - **📜 DAO Proposal**: Purple icon
   - **🤝 Venture Invitation**: Green icon

3. **Grouping**:
   - Today, Yesterday, This Week, Earlier
   - Each group has date header

4. **Notification Card**:
   - Icon + emoji (type-specific)
   - Actor name (@username)
   - Action description
   - Optional message/preview
   - Timestamp (relative: "5m ago")
   - Optional CTA button
   - Read/unread indicator (dot)

5. **Interactions**:
   - Tap notification → deep link (post, profile, etc.)
   - Swipe left → Mark as read
   - Long press → Delete
   - Pull to refresh

6. **Empty State**:
   - Illustration: Bell with stars
   - "No notifications yet"
   - "Check back later!"

**Micro-animations**:
- New notification slides in from top
- Unread dot pulses
- High-priority cards glow
- Tap card → scale effect
- Swipe gesture reveals actions

---

### 10. ⭐ NOTIFICATION SETTINGS SCREEN (NEW)

**Purpose**: Configure notification preferences

```
┌─────────────────────────┐
│  ← Back  Settings       │
├─────────────────────────┤
│                         │
│  Notification Types     │
│  ┌─────────────────────┐│
│  │ ❤️ Post Likes     [✓│││ <- Toggle switch
│  └─────────────────────┘│
│  ┌─────────────────────┐│
│  │ 💬 Comments       [✓│││
│  └─────────────────────┘│
│  ┌─────────────────────┐│
│  │ 💰 Tips Received  [✓│││
│  └─────────────────────┘│
│  ┌─────────────────────┐│
│  │ 👤 New Followers  [✓│││
│  └─────────────────────┘│
│  ┌─────────────────────┐│
│  │ @ Mentions        [✓│││
│  └─────────────────────┘│
│  ┌─────────────────────┐│
│  │ 🏆 Milestones     [✓│││
│  └─────────────────────┘│
│  ┌─────────────────────┐│
│  │ 📜 DAO Proposals  [✓│││
│  └─────────────────────┘│
│                         │
│  Push Notifications     │
│  ┌─────────────────────┐│
│  │ Enable Push       [✓│││
│  └─────────────────────┘│
│                         │
│  Quiet Hours            │
│  ┌─────────────────────┐│
│  │ Enable Quiet Hrs  [✓│││
│  │ From: 22:00         ││
│  │ To:   08:00         ││
│  │ Timezone: PST       ││
│  └─────────────────────┘│
│                         │
│  [Save Changes]         │
└─────────────────────────┘
```

**Features**:
- Toggle switches for each notification type
- Push notifications toggle
- Quiet hours configuration
  - Enable/disable toggle
  - Time pickers (from/to)
  - Timezone selector
- Save button (gradient, prominent)
- Changes sync to backend immediately

---

### 11. ⭐ CREATE POST SCREEN (NEW)

**Purpose**: Create a new post (text + optional image)

```
┌─────────────────────────┐
│  ✕ Cancel    Create Post│
│                 [Post →]│
├─────────────────────────┤
│  [@your_username] ✓     │
│                         │
│  ┌─────────────────────┐│
│  │ What's on your mind?││ <- Text input
│  │                     ││    (multiline)
│  │                     ││
│  │                     ││
│  │                     ││
│  └─────────────────────┘│
│                         │
│  [Uploaded Image]       │ <- Image preview
│  [Remove ✕]            │    (if added)
│                         │
│  ┌─────────────────────┐│
│  │ 🖼️ Add Image/Video  ││
│  └─────────────────────┘│
│  ┌─────────────────────┐│
│  │ # Add Tags          ││
│  └─────────────────────┘│
│                         │
│  Options                │
│  ┌─────────────────────┐│
│  │ 🔥 Mint as NFT      ││
│  │ immediately      [✓]││
│  │ Fee: 0.1 SOL        ││
│  └─────────────────────┘│
│                         │
│  Character count: 250/500│
└─────────────────────────┘
```

**Features**:
- Cancel button (top left)
- Post button (top right, gradient)
- Text input (auto-focus, multiline)
- Image/video upload (camera + gallery)
- Image preview with remove button
- Add tags button (opens tag selector)
- Mint as NFT toggle (with fee display)
- Character counter (dynamic)

**Validation**:
- Minimum 10 characters
- Maximum 500 characters
- Optional image (max 10MB)
- Optional tags (max 5)

---

### 12. ⭐ POST DETAIL SCREEN (NEW)

**Purpose**: View a single post with comments

```
┌─────────────────────────┐
│  ← Back                 │
├─────────────────────────┤
│  [@alice] verified ✓    │
│  2 hours ago            │
│                         │
│  This is my post about  │
│  Solana and why it's    │
│  the future of social   │
│  media! 🚀              │
│                         │
│  [Large Image]          │
│                         │
│  #Solana #Web3 #SocialFi│
│                         │
│  ❤️ 45  💬 12  💰 5     │
│  [Like] [Tip] [Share]   │
│                         │
│  ━━━ Comments (12) ━━━  │
│                         │
│  ┌─────────────────────┐│
│  │ [@bob] verified     ││
│  │ Great post! 👏      ││
│  │ 1 hour ago          ││
│  │ ❤️ 5                ││
│  └─────────────────────┘│
│  ┌─────────────────────┐│
│  │ [@charlie]          ││
│  │ I agree! Solana is  ││
│  │ amazing 🔥          ││
│  │ 30 minutes ago      ││
│  │ ❤️ 2                ││
│  └─────────────────────┘│
│                         │
│  [Load More Comments]   │
│                         │
│  ┌─────────────────────┐│
│  │ [Your avatar]       ││
│  │ Add a comment...    ││ <- Comment input
│  │              [Send] ││
│  └─────────────────────┘│
└─────────────────────────┘
```

**Features**:
- Full post content (no truncation)
- Large image display
- Tags (tappable)
- Like/Tip/Share buttons
- Comment count
- Comment list (nested)
- Comment input (sticky at bottom)
- Like comments
- Reply to comments (nested)

---

### 13. ⭐ SEND TIP SCREEN (NEW - Bottom Sheet)

**Purpose**: Send a tip to a post or user

```
┌─────────────────────────┐
│  ━━━━━━━━━━━━━━━━━━━━  │ <- Drag handle
│                         │
│  💰 Send Tip            │
│                         │
│  To: @alice             │
│  [Profile pic] verified │
│                         │
│  Amount                 │
│  ┌─────────────────────┐│
│  │      10.00          ││ <- Big number input
│  │      USDC           ││
│  └─────────────────────┘│
│                         │
│  Quick amounts:         │
│  [$1] [$5] [$10] [$20] │
│                         │
│  Fee Breakdown          │
│  ┌─────────────────────┐│
│  │ Amount:    $10.00   ││
│  │ Fee (10%):  $1.00   ││
│  │ Burned:     $0.50   ││
│  │ Rewards:    $0.50   ││
│  │ ━━━━━━━━━━━━━━━━━━  ││
│  │ Total:     $11.00   ││
│  └─────────────────────┘│
│                         │
│  Message (optional)     │
│  ┌─────────────────────┐│
│  │ Add a message...    ││
│  └─────────────────────┘│
│                         │
│  [Send Tip 🚀]          │ <- Big gradient button
│                         │
│  🔒 Secure via Solana   │
└─────────────────────────┘
```

**Features**:
- Drag handle to dismiss
- Recipient avatar + username
- Amount input (big, prominent)
- Quick amount buttons ($1, $5, $10, $20)
- Fee breakdown (transparent)
- Optional message
- Send button (gradient, prominent)
- Loading state during transaction
- Success animation (confetti + checkmark)

---

### 14. ⭐ USER PROFILE SCREEN (NEW - Public View)

**Purpose**: View another user's profile

```
┌─────────────────────────┐
│  ← Back    [•••] More   │
├─────────────────────────┤
│  [Cover Image Gradient] │
│                         │
│     [Profile Pic] ✓     │
│                         │
│      @alice             │
│      Verified Human     │
│                         │
│   "Solana enthusiast    │
│    & NFT artist 🎨"     │
│                         │
│  🌐 alice.sol           │
│  📍 San Francisco, CA   │
│                         │
│  ┌─────┐ ┌─────┐ ┌─────┐│
│  │ 567 │ │1.2K │ │ 890 ││
│  │Posts│ │Foll.│ │Foll.││
│  └─────┘ └─────┘ └─────┘│
│                         │
│  [🔔 Follow]   [💰 Tip] │ <- Action buttons
│                         │
│  ┌────────────────────┐ │
│  │ 🏆 Reputation: 92  │ │
│  │ ██████████ Tier 4  │ │
│  └────────────────────┘ │
│                         │
│  ━━━ Posts ━━━         │
│  [Grid of user's posts]│
└─────────────────────────┘
```

**Features**:
- Back button + More menu (report, block, share)
- Cover image
- Profile picture (NFT PFP)
- Verified badge
- Bio
- .sol domain
- Stats (posts, followers, following)
- Follow button (primary action)
- Tip button (secondary action)
- Reputation display
- Grid of user's posts

**More Menu**:
- Share Profile
- Copy Wallet Address
- Report User
- Block User

---

### 15. ⭐ EDIT PROFILE SCREEN (NEW)

**Purpose**: Edit your profile information

```
┌─────────────────────────┐
│  ✕ Cancel   Edit Profile│
│                  [Save] │
├─────────────────────────┤
│                         │
│  [Tap to change cover]  │
│  [Cover Image Preview]  │
│                         │
│  [Tap to change photo]  │
│  [Profile Pic Preview]  │
│                         │
│  Username               │
│  ┌─────────────────────┐│
│  │ alice               ││
│  └─────────────────────┘│
│                         │
│  Bio                    │
│  ┌─────────────────────┐│
│  │ Solana enthusiast   ││
│  │ & NFT artist 🎨     ││
│  │                     ││
│  │ 120/200             ││
│  └─────────────────────┘│
│                         │
│  Location               │
│  ┌─────────────────────┐│
│  │ San Francisco, CA   ││
│  └─────────────────────┘│
│                         │
│  ┌─────────────────────┐│
│  │ 🖼️ Set NFT as PFP   ││
│  └─────────────────────┘│
│                         │
│  Social Good Pledge     │
│  ┌─────────────────────┐│
│  │ Donate: 5%          ││ <- Slider
│  │ ░░░░█░░░░░ (0-10%)  ││
│  └─────────────────────┘│
│                         │
│  [Save Changes]         │
└─────────────────────────┘
```

**Features**:
- Cancel/Save buttons (header)
- Cover image selector (tap to change)
- Profile picture selector
- Username input (validated)
- Bio input (multiline, 200 chars max)
- Location input
- Set NFT as PFP button
- Social good pledge slider (0-10%)
- Save button (gradient)

**Validation**:
- Username: 3-20 chars, alphanumeric + underscore
- Bio: Max 200 chars
- Location: Optional

---

## 🎨 DESIGN SYSTEM COMPONENTS

### Reusable Widgets:

1. **GradientButton**:
   ```dart
   - Primary: Purple-to-blue gradient
   - Secondary: Gray gradient
   - Destructive: Red gradient
   - Disabled: Gray (50% opacity)
   - States: Normal, Pressed, Disabled
   - Animations: Scale on tap (1.0 → 0.95 → 1.0)
   ```

2. **GlassCard**:
   ```dart
   - Background: Semi-transparent white/black
   - Blur: 10px backdrop filter
   - Border: 1px gradient (subtle)
   - Shadow: Soft glow
   - Variants: Default, Highlighted, Minted (gold)
   ```

3. **UserAvatar**:
   ```dart
   - Sizes: XS (24), S (32), M (48), L (64), XL (96)
   - Border: Gradient (if NFT PFP)
   - Badge: Verified checkmark (overlay)
   - Placeholder: Gradient with initials
   ```

4. **NotificationBadge**:
   ```dart
   - Position: Top-right of icon
   - Count: Number (1-9, 9+)
   - Color: Red (#EF4444)
   - Animation: Pulse + scale
   ```

5. **ShimmerLoader**:
   ```dart
   - For loading states
   - Gradient: Light gray shimmer
   - Shapes: Rectangle, Circle, Text
   ```

6. **EmptyState**:
   ```dart
   - Illustration (Lottie)
   - Title
   - Subtitle
   - Optional CTA button
   ```

---

## 🎭 ANIMATIONS & MICRO-INTERACTIONS

### Core Animations:

1. **Page Transitions**:
   - Slide from right (forward navigation)
   - Slide to right (back navigation)
   - Fade in/out (modals)
   - Scale from center (bottom sheets)

2. **List Animations**:
   - Staggered fade-in (new items)
   - Slide in from bottom (refresh)
   - Slide out left/right (swipe actions)

3. **Button Animations**:
   - Scale: 1.0 → 0.95 → 1.0 (tap)
   - Ripple effect (material)
   - Gradient animation (loading)

4. **Like Animation**:
   - Heart scale: 1.0 → 1.5 → 1.2 (bounce)
   - Color: Gray → Red
   - Particles: Small hearts burst out

5. **Tip Animation**:
   - Coin flip: 3D rotation
   - Trail: Golden particles
   - Success: Confetti burst

6. **Loading States**:
   - Shimmer: Gray gradient sweep
   - Spinner: Gradient circle rotate
   - Skeleton: Pulsing rectangles

---

## 🎨 SOLANA-SPECIFIC DESIGN ELEMENTS

### 1. **Speed Indicators**:
- Show "⚡ Instant" badge on tip confirmations
- Transaction time: "Confirmed in 0.4s"
- Real-time updates (WebSocket)

### 2. **NFT Badges**:
- "🔥 IMMORTAL POST" for minted posts
- Shimmer effect on NFT profile pictures
- Gold gradient borders

### 3. **Wallet Integration**:
- Phantom/Solflare branding
- Deep link buttons
- Transaction history

### 4. **Token Display**:
- MOSANA token icon (custom)
- USD equivalent (live)
- Rewards visualization

---

## 📱 RESPONSIVE DESIGN

### Breakpoints:
- **Mobile**: < 600px (default)
- **Tablet**: 600-900px (larger cards, 2-column)
- **Desktop**: > 900px (web view, 3-column)

### Adaptive Layouts:
- Home Feed: 1 column (mobile), 2 columns (tablet), 3 columns (desktop)
- Modals: Full screen (mobile), centered (tablet/desktop)
- Bottom Nav: Visible (mobile), Side nav (tablet/desktop)

---

## ♿ ACCESSIBILITY

### Features:
1. **Screen Reader Support**: Semantic labels for all interactive elements
2. **Contrast**: WCAG AA compliant (4.5:1 minimum)
3. **Font Sizes**: Scalable (respects system settings)
4. **Touch Targets**: Minimum 44x44 points
5. **Focus Indicators**: Visible focus rings
6. **Keyboard Navigation**: Full keyboard support (web)
7. **Reduced Motion**: Respect prefers-reduced-motion

---

## 🚀 PERFORMANCE TARGETS

### Metrics:
- **Time to Interactive**: < 2 seconds
- **Frame Rate**: 60 FPS (smooth scrolling)
- **Image Loading**: Progressive (blur-up)
- **Bundle Size**: < 50MB (APK)
- **Memory Usage**: < 200MB (typical)

---

## 📝 NEXT STEPS

1. ✅ Review this design spec with Ahmed
2. ⏳ Approve design direction
3. ⏳ Start implementing Phase 2 (Backend Integration)
4. ⏳ Build UI components library
5. ⏳ Implement screens one by one
6. ⏳ Add animations & micro-interactions
7. ⏳ Test on real devices
8. ⏳ Build APK for Ahmed to test

---

**Total Screens**: 18 screens
**Estimated Time**: 2-3 weeks for full implementation
**Current Status**: Design phase complete, awaiting approval ✅

