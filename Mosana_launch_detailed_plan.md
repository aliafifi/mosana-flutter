# 🚀 MOSANA LAUNCH - DETAILED MASTER PLAN

**Created:** 2026-02-07  
**Developer:** Senior Full-Stack Engineer (Backend + Frontend)  
**Timeline:** 6-8 Weeks to Production Launch  
**Status:** Deep Analysis Complete ✅

---

## 📊 EXECUTIVE SUMMARY

### Current State Analysis:

#### **Backend Status: 95% Production-Ready** ✅
- **Technology:** NestJS + TypeScript + MongoDB + Redis + WebSocket
- **Features:** 13/13 modules complete (77 API endpoints)
- **Authentication:** JWT-based wallet authentication ✅
- **Blockchain:** Solana integration (Metaplex, Arweave) ✅
- **Real-time:** WebSocket gateway for notifications ✅
- **Quality:** Professional architecture, typed, tested

#### **Frontend Status: 40% Complete** ⚠️
- **Technology:** Flutter (Dart) + Riverpod + Dio
- **Screens:** 18 screens built (UI only)
- **API Integration:** 30% connected (Auth + Posts + Feed)
- **State Management:** Riverpod providers partially implemented
- **Issues:** Mock data removed, several screens need API connection

### Critical Gap Analysis:

| Component | Backend | Frontend | Gap |
|-----------|---------|----------|-----|
| Authentication | ✅ 100% | ✅ 90% | Demo mode only, need real wallets |
| Posts & Feed | ✅ 100% | ✅ 80% | Working, needs image upload |
| Comments | ✅ 100% | ❌ 0% | No UI implementation |
| Likes | ✅ 100% | ✅ 80% | Optimistic updates working |
| Tipping | ✅ 100% | ❌ 0% | UI exists, no API connection |
| NFT Minting | ✅ 100% | ❌ 0% | UI exists, no API connection |
| Notifications | ✅ 100% | ❌ 0% | Empty state only |
| Search | ✅ 100% | ❌ 0% | Returns empty lists |
| Profile | ✅ 100% | ❌ 20% | UI only, no data |
| Wallet | ✅ 100% | ❌ 30% | UI only, mock data |
| DAO | ✅ 100% | ❌ 0% | Placeholder only |
| Rewards | ✅ 100% | ❌ 0% | Not implemented |
| Analytics | ✅ 100% | ❌ 0% | UI only, no data |

**Overall Integration: 30%**

---

## 🎯 STRATEGIC OBJECTIVES

### Primary Goals:
1. **Launch MVP in 6 weeks** - Core features working end-to-end
2. **100% Backend Integration** - All 77 endpoints connected
3. **Production Quality** - No mock data, proper error handling
4. **App Store Ready** - iOS + Android submission ready
5. **Beta Testing** - 50-100 real users testing

### Success Metrics:
- ✅ Users can create accounts (wallet-based)
- ✅ Users can create posts with images
- ✅ Users can interact (like, comment, tip)
- ✅ Real-time notifications working
- ✅ NFT minting functional
- ✅ DAO governance working
- ✅ Smooth UX (< 300ms response time)
- ✅ Zero crashes (99.9% uptime)

---

## 📅 6-WEEK LAUNCH ROADMAP

### **WEEK 1: FOUNDATION & CRITICAL FIXES** (Days 1-7)

#### **Phase 1A: Critical UI Bug Fixes** (Days 1-2)
**Priority:** 🔴 CRITICAL

**Tasks:**
1. **Fix Bottom Navigation Bar** (4 hours)
   - Issue: Nav bar not showing in current build
   - Root cause: SafeArea/Scaffold hierarchy issue
   - Solution: Adjust MainNavigationScreen layout
   - Test: Verify nav visible on all tabs

2. **Fix Text Underlines** (2 hours)
   - Issue: Text showing underlines in production
   - Root cause: Material theme default decoration
   - Solution: Override all TextStyle decorations
   - Test: Check all text elements (posts, usernames, hashtags)

3. **Fix Header Transparency** (2 hours)
   - Issue: Header blend with content
   - Solution: Add proper elevation and shadow
   - Test: Scroll feed, verify header separates

4. **Polish Loading States** (3 hours)
   - Add shimmer loading for feed
   - Add skeleton screens for profiles
   - Add progress indicators for posts
   - Test: Verify smooth loading experience

**Deliverable:** Clean, professional UI with no visual bugs
**Commit:** `🎨 FIX: Critical UI bugs - Nav bar, underlines, loading states`

---

#### **Phase 1B: Complete Authentication Flow** (Days 2-3)
**Priority:** 🔴 CRITICAL

**Current State:**
- ✅ Demo mode working (mock wallet)
- ❌ Real Solana wallet integration missing
- ❌ Token refresh not implemented
- ❌ Logout flow incomplete

**Tasks:**
1. **Integrate Solana Wallet Adapter** (6 hours)
   ```dart
   // Add dependencies:
   // - solana: ^0.30.0
   // - bip39: ^1.0.6 (for wallet creation)
   // - ed25519_hd_key: ^2.2.0
   ```
   - Research Flutter Solana packages
   - Implement Phantom deep linking (mobile)
   - Implement Solflare deep linking
   - Handle wallet connection response
   - Sign authentication message
   - Send to backend `/api/auth/login`

2. **Token Management** (4 hours)
   - Implement JWT refresh logic
   - Auto-refresh before expiration (7 days)
   - Handle 401 errors globally
   - Clear tokens on logout
   - Test: Token persists across app restarts

3. **Onboarding Polish** (3 hours)
   - Update wallet selection UI
   - Add "What is a wallet?" explainer
   - Add wallet installation links
   - Test: New user can connect in < 2 minutes

4. **Session Management** (2 hours)
   - Check auth on app start
   - Auto-login if token valid
   - Route to ConnectWallet if not authenticated
   - Test: Session persists correctly

**Deliverable:** Real wallet authentication working end-to-end
**Commit:** `🔐 COMPLETE: Real Solana wallet authentication`

**Files to Create/Update:**
```
lib/core/services/wallet_service.dart (NEW)
lib/presentation/screens/auth/connect_wallet_screen.dart (UPDATE)
lib/core/services/auth_service.dart (UPDATE)
pubspec.yaml (ADD solana package)
```

---

#### **Phase 1C: Image Upload Infrastructure** (Days 3-4)
**Priority:** 🔴 CRITICAL

**Current State:**
- ❌ Posts created without images
- ❌ No image upload service
- ❌ No cloud storage integration

**Decision Point: Choose Storage Provider**

**Option A: Cloudinary** (Recommended)
- ✅ Free tier: 25GB storage, 25GB bandwidth
- ✅ Automatic image optimization
- ✅ CDN delivery worldwide
- ✅ Flutter package available
- ✅ Easy to integrate (REST API)
- ❌ Cost scales with usage

**Option B: AWS S3**
- ✅ Most scalable
- ✅ Very cheap ($0.023/GB)
- ✅ Reliable
- ❌ More complex setup
- ❌ Need additional CloudFront for CDN

**Option C: Firebase Storage**
- ✅ Easy integration
- ✅ Free tier: 5GB storage
- ❌ Expensive beyond free tier
- ❌ Slower than CDN

**RECOMMENDATION: Cloudinary** (for MVP, switch to S3 later if needed)

**Tasks:**
1. **Set Up Cloudinary Account** (1 hour)
   - Create account at cloudinary.com
   - Get API credentials (cloud_name, api_key, api_secret)
   - Configure upload preset

2. **Create Image Upload Service** (4 hours)
   ```dart
   // lib/core/services/image_upload_service.dart
   class ImageUploadService {
     Future<String> uploadImage(File image) async {
       // 1. Compress image (max 1MB)
       // 2. Upload to Cloudinary
       // 3. Return public URL
     }
   }
   ```

3. **Integrate into CreatePostScreen** (3 hours)
   - Upload images before creating post
   - Show upload progress (0-100%)
   - Handle upload errors
   - Pass image URLs to API

4. **Update Backend Post Model** (2 hours)
   - Verify `media: string[]` field exists
   - Update post creation to accept multiple images
   - Test: Create post with 1-4 images

5. **Add Image Display in Feed** (2 hours)
   - Update PostCard to show images
   - Add image carousel for multiple images
   - Add image tap to fullscreen view
   - Cache images with CachedNetworkImage

**Deliverable:** Users can post with images, images load in feed
**Commit:** `📸 ADD: Image upload with Cloudinary + display in feed`

**Files to Create/Update:**
```
lib/core/services/image_upload_service.dart (NEW)
lib/presentation/screens/post/create_post_screen.dart (UPDATE)
lib/presentation/widgets/post/post_card.dart (UPDATE)
lib/core/config/app_config.dart (ADD Cloudinary config)
.env (ADD CLOUDINARY_CLOUD_NAME, etc.)
```

---

#### **Phase 1D: Complete Posts Integration** (Days 4-5)
**Priority:** 🔴 CRITICAL

**Tasks:**
1. **Fix Post Model** (2 hours)
   - Ensure PostModel matches backend response
   - Handle all fields (author, media, tags, etc.)
   - Add JSON serialization
   - Test: Posts deserialize correctly

2. **Comments UI + API** (5 hours)
   - Create CommentsScreen
   - Show comments list (GET /api/posts/:id/comments)
   - Add comment form (POST /api/posts/:id/comments)
   - GIF support for comments
   - Like comments
   - Test: Full comment thread works

3. **Share Functionality** (2 hours)
   - Add share button handler
   - Use Flutter share package
   - Share post link
   - Track shares in analytics
   - Test: Share to WhatsApp, Twitter

4. **Delete Post** (2 hours)
   - Add delete option (post owner only)
   - Confirm dialog
   - DELETE /api/posts/:id
   - Remove from feed optimistically
   - Test: Delete own post, feed updates

**Deliverable:** Full CRUD for posts + comments working
**Commit:** `✅ COMPLETE: Posts CRUD + Comments + Share + Delete`

**Files to Create/Update:**
```
lib/presentation/screens/post/comments_screen.dart (NEW)
lib/presentation/screens/post/post_detail_screen.dart (NEW)
lib/data/repositories/post_repository.dart (UPDATE)
lib/presentation/providers/comments_provider.dart (NEW)
```

---

#### **Phase 1E: Testing & Deployment** (Days 6-7)
**Priority:** 🟡 HIGH

**Tasks:**
1. **End-to-End Testing** (4 hours)
   - Test login flow
   - Test create post with images
   - Test feed refresh
   - Test like/comment
   - Document any bugs

2. **Backend Health Check** (2 hours)
   - Verify backend is running
   - Check MongoDB connection
   - Check Redis connection
   - Verify WebSocket gateway
   - Test all endpoints with Postman

3. **Performance Optimization** (3 hours)
   - Implement feed caching
   - Lazy load images
   - Optimize API calls (debounce)
   - Test: App feels fast (< 300ms interactions)

4. **Error Handling** (3 hours)
   - Global error handler
   - Network error UI
   - Retry logic
   - User-friendly error messages
   - Test: App doesn't crash on errors

5. **Week 1 Demo** (2 hours)
   - Record demo video
   - Create test account
   - Post 5 sample posts
   - Test all features
   - Document progress

**Deliverable:** Stable MVP with core features working
**Commit:** `🎉 WEEK 1 COMPLETE: MVP Core Features Working`

---

### **WEEK 2: USER PROFILES & SOCIAL FEATURES** (Days 8-14)

#### **Phase 2A: User Profiles** (Days 8-9)
**Priority:** 🔴 CRITICAL

**Current State:**
- ✅ Backend: Full user CRUD (GET /api/users/*)
- ❌ Frontend: UI only, no data loading

**Tasks:**
1. **Profile Screen API Integration** (4 hours)
   - Load user profile (GET /api/users/:walletAddress)
   - Show user stats (posts, followers, etc.)
   - Show user's posts (GET /api/posts/user/:wallet)
   - Tab navigation (Posts / NFTs / Stats)
   - Test: Profile loads correctly

2. **Edit Profile** (4 hours)
   - Edit bio, username
   - Upload profile picture
   - Upload NFT profile picture
   - Set .sol domain
   - PUT /api/users/profile
   - Test: Profile updates save

3. **Follow System** (3 hours)
   - Follow button (POST /api/users/follow/:wallet)
   - Unfollow button (DELETE /api/users/follow/:wallet)
   - Followers list screen
   - Following list screen
   - Update follower counts
   - Test: Follow/unfollow works

4. **User Avatar Component** (2 hours)
   - Show profile picture or NFT PFP
   - Verification badge (blue checkmark)
   - Tap to view profile
   - Test: Avatars load everywhere

**Deliverable:** Full user profile system working
**Commit:** `👤 COMPLETE: User profiles + Edit + Follow system`

**Files to Create/Update:**
```
lib/presentation/screens/profile/profile_screen.dart (UPDATE)
lib/presentation/screens/profile/edit_profile_screen.dart (NEW)
lib/presentation/screens/profile/followers_screen.dart (NEW)
lib/presentation/screens/profile/following_screen.dart (NEW)
lib/data/repositories/user_repository.dart (UPDATE)
lib/presentation/providers/profile_provider.dart (NEW)
```

---

#### **Phase 2B: Search & Discovery** (Days 10-11)
**Priority:** 🟡 HIGH

**Current State:**
- ✅ Backend: Search endpoints ready
- ❌ Frontend: Returns empty lists

**Tasks:**
1. **User Search** (3 hours)
   - Implement search bar
   - Debounced search (500ms delay)
   - GET /api/users/search?q=query
   - Show user results
   - Tap to view profile
   - Test: Search finds users

2. **Post Search** (3 hours)
   - Search posts by content/hashtags
   - GET /api/posts/search?q=query
   - Show post results
   - Filter by date/popularity
   - Test: Search finds posts

3. **Trending Topics** (3 hours)
   - GET /api/posts/trending
   - Show trending hashtags
   - Tap hashtag to filter feed
   - Show top posts for topic
   - Test: Trending updates daily

4. **Top Creators Leaderboard** (3 hours)
   - GET /api/reputation/leaderboard/top
   - Show top 100 users by reputation
   - Rank, avatar, username, score
   - Pagination
   - Test: Leaderboard loads

**Deliverable:** Full search and discovery working
**Commit:** `🔍 COMPLETE: Search users/posts + Trending + Leaderboard`

**Files to Create/Update:**
```
lib/presentation/screens/explore/search_explore_screen.dart (UPDATE)
lib/presentation/screens/explore/trending_screen.dart (NEW)
lib/presentation/screens/explore/leaderboard_screen.dart (NEW)
lib/data/repositories/search_repository.dart (NEW)
```

---

#### **Phase 2C: Notifications System** (Days 12-14)
**Priority:** 🔴 CRITICAL

**Current State:**
- ✅ Backend: Full notification system + WebSocket
- ❌ Frontend: Empty state only

**Tasks:**
1. **Firebase Setup** (3 hours)
   - Create Firebase project
   - Download google-services.json (Android)
   - Download GoogleService-Info.plist (iOS)
   - Configure Firebase in app
   - Test: Firebase initializes

2. **Push Notifications** (4 hours)
   - Register FCM token (POST /api/users/fcm-token)
   - Handle foreground notifications
   - Handle background notifications
   - Handle notification tap (deep linking)
   - Test: Receive push notification

3. **Notifications Screen** (4 hours)
   - Load notifications (GET /api/notifications)
   - Pagination
   - Mark as read (PUT /api/notifications/:id/read)
   - Mark all read (PUT /api/notifications/read-all)
   - Delete notification
   - Test: Notifications load and mark read

4. **WebSocket Real-Time** (4 hours)
   - Connect to ws://api.mosana.xyz/notifications
   - Listen for events
   - Update UI in real-time
   - Show in-app notification banner
   - Test: Real-time notification appears

5. **Notification Badge** (2 hours)
   - Unread count (GET /api/notifications/unread)
   - Red badge on bell icon
   - Update on new notification
   - Clear on mark all read
   - Test: Badge shows correct count

**Deliverable:** Full notification system working
**Commit:** `🔔 COMPLETE: Push notifications + WebSocket real-time`

**Files to Create/Update:**
```
lib/core/services/notification_service.dart (UPDATE)
lib/core/services/websocket_service.dart (UPDATE)
lib/presentation/screens/notifications/notifications_screen.dart (UPDATE)
lib/data/repositories/notification_repository.dart (UPDATE)
lib/presentation/providers/notification_provider.dart (NEW)
android/app/google-services.json (NEW)
ios/Runner/GoogleService-Info.plist (NEW)
```

---

### **WEEK 3: WEB3 FEATURES** (Days 15-21)

#### **Phase 3A: Tipping System** (Days 15-16)
**Priority:** 🔴 CRITICAL (Core monetization)

**Current State:**
- ✅ Backend: Full tipping with fees (POST /api/tipping)
- ❌ Frontend: UI exists, no API connection

**Tasks:**
1. **Tip Preview** (3 hours)
   - GET /api/tipping/preview/:amount
   - Show amount, fee, recipient gets
   - Fee tiers (1%, 0.75%, 0.5%, 0.25%)
   - Show 50% burned, 50% to rewards
   - Test: Preview calculates correctly

2. **Send Tip Flow** (5 hours)
   - Open SendTipScreen
   - Enter amount (SOL or USDC)
   - Add optional message
   - Confirm transaction
   - POST /api/tipping
   - Show success animation
   - Update balances
   - Test: Tip sent successfully

3. **Tip History** (3 hours)
   - Sent tips (GET /api/tipping/sent)
   - Received tips (GET /api/tipping/received)
   - Show transaction hash
   - Link to Solana Explorer
   - Test: History shows all tips

4. **Tip Button in Posts** (2 hours)
   - Tip button in PostCard
   - Quick amounts (1, 5, 10 SOL)
   - Custom amount input
   - Show tip count on post
   - Test: Tip from feed works

**Deliverable:** Full tipping system working
**Commit:** `💰 COMPLETE: Tipping system with Solana integration`

**Files to Create/Update:**
```
lib/presentation/screens/wallet/send_tip_screen.dart (UPDATE)
lib/data/repositories/tip_repository.dart (NEW)
lib/presentation/providers/wallet_provider.dart (NEW)
lib/core/services/solana_service.dart (NEW)
```

---

#### **Phase 3B: NFT Minting** (Days 17-18)
**Priority:** 🟡 HIGH (Unique feature)

**Current State:**
- ✅ Backend: Full NFT minting (POST /api/nft/mint/:postId)
- ❌ Frontend: UI exists, no API connection

**Tasks:**
1. **Check Mint Status** (2 hours)
   - GET /api/nft/check/:postId
   - Show if post is already minted
   - Show "Immortal" badge if minted
   - Disable delete for minted posts
   - Test: Status shows correctly

2. **Mint Post Flow** (5 hours)
   - Open MintNFTScreen from post
   - Show post preview
   - Set NFT title, description
   - Set royalty percentage (0-50%)
   - POST /api/nft/mint/:postId
   - Show minting progress
   - Show success with NFT link
   - Test: NFT minted on Solana

3. **View NFT** (3 hours)
   - GET /api/nft/:mintAddress
   - Show NFT metadata
   - Show Arweave storage link
   - Show Solana Explorer link
   - Show owner
   - Test: NFT details display

4. **User's NFT Gallery** (3 hours)
   - GET /api/nft/user/:walletAddress
   - Grid view of user's NFTs
   - Tap to view details
   - Show mint date, royalties
   - Test: Gallery shows all NFTs

**Deliverable:** Full NFT minting working on Solana
**Commit:** `🎨 COMPLETE: NFT minting + Arweave storage + Gallery`

**Files to Create/Update:**
```
lib/presentation/screens/wallet/mint_nft_screen.dart (UPDATE)
lib/presentation/screens/nft/nft_detail_screen.dart (NEW)
lib/presentation/screens/nft/nft_gallery_screen.dart (NEW)
lib/data/repositories/nft_repository.dart (NEW)
```

---

#### **Phase 3C: Wallet Integration** (Days 19-21)
**Priority:** 🔴 CRITICAL

**Tasks:**
1. **Wallet Balance** (3 hours)
   - Show SOL balance from blockchain
   - Show USDC balance
   - Show MOSANA token balance
   - Auto-refresh every 30 seconds
   - Test: Balance updates correctly

2. **Transaction History** (4 hours)
   - GET /api/tipping/stats
   - Show all transactions
   - Tips sent/received
   - NFT mints
   - Filter by type
   - Test: History complete

3. **Wallet Settings** (3 hours)
   - Network selection (Devnet/Mainnet)
   - Export private key (with warnings)
   - Disconnect wallet
   - Clear cache
   - Test: Settings work

4. **Rewards Overview** (4 hours)
   - GET /api/rewards/today
   - Show daily engagement
   - Show estimated rewards
   - Reputation multiplier
   - GET /api/rewards/history
   - Test: Rewards display correctly

**Deliverable:** Full wallet features working
**Commit:** `💼 COMPLETE: Wallet balance + History + Rewards`

**Files to Create/Update:**
```
lib/presentation/screens/wallet/wallet_main_screen.dart (UPDATE)
lib/presentation/screens/wallet/transaction_history_screen.dart (UPDATE)
lib/presentation/screens/wallet/wallet_settings_screen.dart (UPDATE)
lib/presentation/screens/rewards/rewards_screen.dart (NEW)
```

---

### **WEEK 4: ADVANCED FEATURES** (Days 22-28)

#### **Phase 4A: DAO Governance** (Days 22-24)
**Priority:** 🟡 HIGH (Unique feature)

**Current State:**
- ✅ Backend: Full DAO system (13 endpoints)
- ❌ Frontend: "Coming Soon" placeholder

**Tasks:**
1. **DAO List** (3 hours)
   - GET /api/dao
   - Show all DAOs
   - Token requirement
   - Member count
   - Active proposals
   - Test: DAOs load

2. **Create DAO** (4 hours)
   - POST /api/dao
   - Set name, description
   - Set token requirement
   - Set voting rules
   - Set permissions
   - Test: DAO created

3. **Join/Leave DAO** (2 hours)
   - POST /api/dao/:id/join
   - Check token balance
   - POST /api/dao/:id/leave
   - Update member count
   - Test: Join/leave works

4. **Proposals** (5 hours)
   - List proposals (GET /api/dao/:id/proposals)
   - Create proposal (POST /api/dao/:id/proposals)
   - Vote on proposal (POST /api/dao/:id/proposals/:proposalId/vote)
   - Show vote results
   - Auto-finalize on deadline
   - Test: Full proposal lifecycle

5. **DAO Dashboard** (4 hours)
   - Member list
   - Proposal history
   - Voting stats
   - Treasury (future)
   - Test: Dashboard shows all data

**Deliverable:** Full DAO governance working
**Commit:** `🏛️ COMPLETE: DAO governance + Proposals + Voting`

**Files to Create/Update:**
```
lib/presentation/screens/dao/dao_list_screen.dart (NEW)
lib/presentation/screens/dao/dao_detail_screen.dart (NEW)
lib/presentation/screens/dao/create_dao_screen.dart (NEW)
lib/presentation/screens/dao/create_proposal_screen.dart (NEW)
lib/presentation/screens/dao/proposal_detail_screen.dart (NEW)
lib/data/repositories/dao_repository.dart (NEW)
```

---

#### **Phase 4B: Social Good (Charity)** (Days 24-25)
**Priority:** 🟡 HIGH (Differentiator)

**Tasks:**
1. **Charity List** (2 hours)
   - GET /api/social-good/causes
   - Show verified charities
   - Show total donations
   - Test: Charities load

2. **Donate to Charity** (4 hours)
   - POST /api/social-good/donate
   - Select charity
   - Enter amount
   - Confirm transaction
   - Show receipt
   - Test: Donation processed

3. **Charity on Posts** (3 hours)
   - Link post to charity
   - Auto-split tips with charity
   - Show charity badge on post
   - Track total donated per post
   - Test: Charity split works

4. **Donation History** (2 hours)
   - GET /api/social-good/donations/my-donations
   - Show all donations
   - Total donated
   - Impact stats
   - Test: History shows correctly

**Deliverable:** Charity donation system working
**Commit:** `❤️ COMPLETE: Charity donations + Post linking`

**Files to Create/Update:**
```
lib/presentation/screens/charity/charity_list_screen.dart (NEW)
lib/presentation/screens/charity/donate_screen.dart (NEW)
lib/presentation/screens/charity/donation_history_screen.dart (NEW)
lib/data/repositories/charity_repository.dart (NEW)
```

---

#### **Phase 4C: Analytics Dashboard** (Days 26-28)
**Priority:** 🟢 MEDIUM

**Tasks:**
1. **User Analytics** (4 hours)
   - GET /api/reputation/my/score
   - Show reputation breakdown
   - Activity chart (7 days)
   - Engagement metrics
   - Growth trends
   - Test: Analytics display

2. **Platform Stats** (3 hours)
   - GET /api/reputation/stats/platform
   - Total users
   - Total posts
   - Total tips
   - Total NFTs minted
   - Test: Stats accurate

3. **Personal Dashboard** (4 hours)
   - Posts performance
   - Top posts by likes/tips
   - Earnings summary
   - Follower growth
   - Test: Dashboard complete

**Deliverable:** Analytics dashboard working
**Commit:** `📊 COMPLETE: Analytics dashboard + Stats`

**Files to Create/Update:**
```
lib/presentation/screens/analytics/analytics_dashboard_screen.dart (UPDATE)
lib/data/repositories/analytics_repository.dart (NEW)
```

---

### **WEEK 5: POLISH & OPTIMIZATION** (Days 29-35)

#### **Phase 5A: Performance Optimization** (Days 29-30)

**Tasks:**
1. **API Response Caching** (4 hours)
   - Cache feed data (5 min TTL)
   - Cache user profiles (10 min TTL)
   - Cache search results (2 min TTL)
   - Invalidate on mutations
   - Test: App feels instant

2. **Image Optimization** (3 hours)
   - Lazy load images
   - Progressive loading
   - Thumbnail generation
   - WebP format
   - Test: Images load fast

3. **Code Splitting** (2 hours)
   - Lazy load screens
   - Reduce initial bundle size
   - Test: App starts faster

4. **Database Optimization** (3 hours)
   - Add indexes to MongoDB
   - Optimize queries
   - Add pagination everywhere
   - Test: API responds < 200ms

**Deliverable:** App feels fast and responsive
**Commit:** `⚡ OPTIMIZE: Performance improvements`

---

#### **Phase 5B: Error Handling & Edge Cases** (Days 31-32)

**Tasks:**
1. **Network Error Handling** (3 hours)
   - Offline mode detection
   - Retry with exponential backoff
   - Queue mutations offline
   - Sync when online
   - Test: Works offline

2. **Edge Case Testing** (4 hours)
   - Empty states everywhere
   - Loading states everywhere
   - Error states everywhere
   - No data scenarios
   - Test: No crashes

3. **Form Validation** (3 hours)
   - Validate all inputs
   - Show error messages
   - Prevent invalid submissions
   - Test: Forms validate correctly

4. **Security Hardening** (3 hours)
   - Store JWT securely (FlutterSecureStorage)
   - Validate all API responses
   - Sanitize user input
   - Test: No security vulnerabilities

**Deliverable:** Robust error handling
**Commit:** `🛡️ HARDEN: Security + Error handling`

---

#### **Phase 5C: UI/UX Polish** (Days 33-35)

**Tasks:**
1. **Animations** (4 hours)
   - Smooth page transitions
   - Like button animation
   - Loading animations
   - Success/error animations
   - Test: Smooth 60fps

2. **Haptic Feedback** (2 hours)
   - Vibrate on like
   - Vibrate on button press
   - Vibrate on error
   - Test: Feels responsive

3. **Dark Mode Refinement** (3 hours)
   - Fix any contrast issues
   - Ensure readability
   - Polish gradients
   - Test: Looks professional

4. **Accessibility** (3 hours)
   - Add semantic labels
   - Support screen readers
   - Keyboard navigation
   - Test: Accessible

5. **Empty States** (2 hours)
   - Beautiful empty state designs
   - Call-to-action buttons
   - Helpful messages
   - Test: Empty states guide users

**Deliverable:** Professional, polished UI
**Commit:** `✨ POLISH: Animations + Haptics + Accessibility`

---

### **WEEK 6: TESTING & LAUNCH PREP** (Days 36-42)

#### **Phase 6A: Comprehensive Testing** (Days 36-37)

**Testing Checklist:**

**Authentication:**
- [ ] Connect Phantom wallet
- [ ] Connect Solflare wallet  
- [ ] Login with existing wallet
- [ ] Logout
- [ ] Session persists
- [ ] Token refresh works
- [ ] Handle expired token

**Posts:**
- [ ] Create text post
- [ ] Create post with 1 image
- [ ] Create post with 4 images
- [ ] View feed
- [ ] Pull to refresh
- [ ] Load more (pagination)
- [ ] Like post
- [ ] Unlike post
- [ ] Comment on post
- [ ] Delete comment
- [ ] Share post
- [ ] Delete own post
- [ ] View post detail

**Profile:**
- [ ] View own profile
- [ ] View other user profile
- [ ] Edit profile (bio, username)
- [ ] Upload profile picture
- [ ] Follow user
- [ ] Unfollow user
- [ ] View followers
- [ ] View following

**Search:**
- [ ] Search users
- [ ] Search posts
- [ ] View trending topics
- [ ] View leaderboard

**Notifications:**
- [ ] Receive push notification
- [ ] Tap notification opens app
- [ ] Real-time WebSocket notification
- [ ] View notification list
- [ ] Mark as read
- [ ] Mark all read
- [ ] Delete notification

**Tipping:**
- [ ] View tip preview
- [ ] Send tip
- [ ] Receive tip
- [ ] View tip history

**NFT:**
- [ ] Check mint status
- [ ] Mint post as NFT
- [ ] View NFT details
- [ ] View NFT gallery

**DAO:**
- [ ] View DAO list
- [ ] Join DAO
- [ ] Create proposal
- [ ] Vote on proposal
- [ ] Leave DAO

**Charity:**
- [ ] View charities
- [ ] Donate to charity
- [ ] Link post to charity
- [ ] View donation history

**Wallet:**
- [ ] View SOL balance
- [ ] View transaction history
- [ ] View rewards
- [ ] Network settings
- [ ] Disconnect wallet

**General:**
- [ ] App doesn't crash
- [ ] No UI bugs
- [ ] Fast (< 300ms)
- [ ] Works offline (limited)
- [ ] Handles errors gracefully

---

#### **Phase 6B: Beta Testing** (Days 38-40)

**Beta Tester Recruitment:**
1. **Recruit 20-50 beta testers**
   - Friends & family
   - Crypto community (Twitter)
   - Discord community
   - Solana developers

2. **Onboard Beta Testers**
   - Send TestFlight link (iOS)
   - Send APK or Google Play Beta (Android)
   - Provide testing guide
   - Create feedback form

3. **Collect Feedback**
   - Bug reports
   - Feature requests
   - UX issues
   - Performance issues

4. **Fix Critical Bugs**
   - Prioritize crashes
   - Fix major UX issues
   - Address security concerns

**Deliverable:** Beta tested with 20+ users
**Commit:** `🧪 BETA: Testing complete, bugs fixed`

---

#### **Phase 6C: App Store Preparation** (Days 41-42)

**iOS App Store:**
1. **App Store Connect Setup** (2 hours)
   - Create app listing
   - Set bundle ID
   - Set version (1.0.0)
   - Add app icon
   - Add description

2. **Screenshots** (3 hours)
   - Take 6.5" iPhone screenshots
   - Take 5.5" iPhone screenshots
   - Add text overlays
   - Showcase key features

3. **App Preview Video** (2 hours)
   - Record 30-second demo
   - Show key features
   - Add music
   - Add captions

4. **App Store Metadata** (2 hours)
   - Title: "Mosana - Ethical SocialFi"
   - Subtitle: "Earn SOL for Quality Content"
   - Keywords: solana, web3, social, nft, tips, dao, charity
   - Description: (see template below)
   - Privacy policy URL
   - Support URL

5. **Submit for Review** (1 hour)
   - Upload build
   - Fill compliance form
   - Submit for review
   - Wait 1-3 days

**Android Play Store:**
1. **Google Play Console Setup** (2 hours)
   - Create app listing
   - Set package name
   - Set version (1.0.0)
   - Add app icon
   - Add description

2. **Screenshots** (2 hours)
   - Phone screenshots
   - Tablet screenshots (optional)
   - Feature graphic

3. **Submit for Review** (1 hour)
   - Upload APK/AAB
   - Fill content rating
   - Submit for review
   - Wait 1-7 days

**Deliverable:** Apps submitted to stores
**Commit:** `🚀 LAUNCH: Submitted to App Store & Play Store`

---

## 📝 APP STORE DESCRIPTION TEMPLATE

### App Title:
**Mosana - Ethical SocialFi**

### Subtitle:
**Earn SOL for Quality Content**

### Description:
```
🌟 MOSANA - The Future of Social Media on Solana

Mosana is the ethical SocialFi platform where your content matters. Create posts, earn $SOL for engagement, mint your best posts as NFTs, and support verified charities—all powered by Solana blockchain.

✨ KEY FEATURES:

💰 EARN REAL REWARDS
• Get paid in SOL for quality content
• Daily token distribution based on engagement
• Reputation-based reward multipliers
• Fair, transparent earnings

🎨 OWN YOUR CONTENT
• Mint posts as NFTs on Solana
• Permanent storage on Arweave
• Creator-controlled royalties
• True ownership forever

💸 TIP CREATORS
• Instant SOL/USDC tips
• Ultra-low fees (1% → 0.25%)
• 50% of fees burned (deflationary)
• 50% goes back to reward pool

❤️ SUPPORT GOOD CAUSES
• Link posts to verified charities
• Auto-split tips with charities
• Track your social impact
• On-chain transparency

🏛️ DAO GOVERNANCE
• Create token-gated communities
• Democratic proposal voting
• Community-owned platform
• Fair, transparent governance

🔐 WEB3 NATIVE
• Wallet-based authentication (no passwords!)
• No ads, no data selling
• You control your data
• Built on Solana (fast & cheap)

🌈 ETHICAL BY DESIGN
• No speculation or interest
• Islamic finance aligned
• Positive-sum economy
• Fair value exchange

📊 YOUR STATS MATTER
• Reputation scoring system
• Proof-of-Humanity verification
• Leaderboards & achievements
• Grow your influence

Join the ethical social revolution. Download Mosana today!

🔗 CONNECT:
• Website: mosana.xyz
• Twitter: @MosanaOfficial
• Discord: discord.gg/mosana

---

Privacy Policy: mosana.xyz/privacy
Terms of Service: mosana.xyz/terms
Support: support@mosana.xyz
```

### Keywords:
```
solana, web3, social media, nft, crypto, tips, dao, charity, blockchain, socialfi, ethereum, bitcoin, rewards, tokens, earn money, content creator, decentralized, community, governance, voting
```

### Category:
- Primary: Social Networking
- Secondary: Finance

### Age Rating:
- 17+ (user-generated content, cryptocurrency)

### Support URL:
- https://mosana.xyz/support

### Privacy Policy URL:
- https://mosana.xyz/privacy

---

## 🚨 CRITICAL ISSUES TO ADDRESS

### **Backend Issues:**

1. **Authentication Endpoint** ⚠️
   - Current: `/api/auth/connect`
   - Backend has: `/api/auth/login`
   - **Action:** Check backend and align frontend

2. **Image Upload** 🔴
   - Backend doesn't have image upload endpoint
   - **Options:**
     - Add `/api/upload/image` endpoint
     - OR: Use Cloudinary directly from frontend
   - **Recommendation:** Cloudinary from frontend (simpler)

3. **WebSocket Authentication** ⚠️
   - Need to verify WebSocket auth flow
   - Test connection with real JWT

4. **Rate Limiting** ⚠️
   - Backend has rate limiting (100 req/min)
   - Frontend should handle 429 errors
   - **Action:** Add rate limit error handling

### **Frontend Issues:**

1. **Bottom Navigation Not Showing** 🔴
   - Critical UI bug affecting usability
   - **Priority:** Fix Day 1

2. **Text Underlines Still Visible** 🔴
   - Makes app look unprofessional
   - **Priority:** Fix Day 1

3. **Missing Solana Package** 🔴
   - Can't connect real wallets
   - **Action:** Add `solana` package

4. **No Image Upload Service** 🔴
   - Posts without images are boring
   - **Priority:** Add Week 1

5. **Riverpod Not Fully Implemented** ⚠️
   - Only FeedProvider and AuthProvider exist
   - Need providers for all features
   - **Action:** Create providers throughout weeks 2-4

### **Infrastructure Issues:**

1. **No Cloud Storage** 🔴
   - Nowhere to upload images
   - **Action:** Set up Cloudinary account

2. **No Firebase Setup** 🔴
   - Can't send push notifications
   - **Action:** Create Firebase project

3. **No Error Tracking** ⚠️
   - Can't track crashes in production
   - **Recommendation:** Add Sentry or Firebase Crashlytics

4. **No Analytics** ⚠️
   - Can't track user behavior
   - **Recommendation:** Add Firebase Analytics or Mixpanel

---

## 🛠️ TECHNOLOGY STACK SUMMARY

### **Backend:**
- **Framework:** NestJS (Node.js + TypeScript)
- **Database:** MongoDB (Mongoose ODM)
- **Cache:** Redis
- **Real-time:** Socket.IO (WebSocket)
- **Authentication:** JWT (Passport)
- **Blockchain:** Solana Web3.js, Metaplex
- **Storage:** Arweave (NFTs)
- **Push:** Firebase Admin SDK
- **Validation:** class-validator
- **API:** RESTful + WebSocket

### **Frontend:**
- **Framework:** Flutter (Dart)
- **State:** Riverpod
- **HTTP:** Dio
- **WebSocket:** socket_io_client
- **Storage:** flutter_secure_storage
- **Cache:** shared_preferences
- **Images:** cached_network_image
- **Push:** firebase_messaging
- **Routing:** go_router (not used yet)
- **Blockchain:** solana (need to add)

### **Infrastructure:**
- **Hosting:** VPS (185.234.69.241)
- **Domain:** api.mosana.xyz
- **SSL:** Configured ✅
- **Process Manager:** PM2
- **Image Storage:** Cloudinary (to add)
- **Push Notifications:** Firebase Cloud Messaging

---

## 📊 FEATURE MATRIX

| Feature | Backend | Frontend | Integration | Priority |
|---------|---------|----------|-------------|----------|
| **Authentication** | ✅ 100% | ⚠️ 70% | ⚠️ 70% | 🔴 CRITICAL |
| **Posts CRUD** | ✅ 100% | ✅ 80% | ✅ 80% | 🔴 CRITICAL |
| **Feed** | ✅ 100% | ✅ 80% | ✅ 80% | 🔴 CRITICAL |
| **Likes** | ✅ 100% | ✅ 80% | ✅ 80% | 🔴 CRITICAL |
| **Comments** | ✅ 100% | ❌ 0% | ❌ 0% | 🔴 CRITICAL |
| **Image Upload** | ❌ 0% | ❌ 0% | ❌ 0% | 🔴 CRITICAL |
| **User Profiles** | ✅ 100% | ⚠️ 20% | ⚠️ 20% | 🔴 CRITICAL |
| **Follow System** | ✅ 100% | ❌ 0% | ❌ 0% | 🔴 CRITICAL |
| **Search** | ✅ 100% | ❌ 0% | ❌ 0% | 🟡 HIGH |
| **Notifications** | ✅ 100% | ❌ 0% | ❌ 0% | 🔴 CRITICAL |
| **Push Notifications** | ✅ 100% | ❌ 0% | ❌ 0% | 🔴 CRITICAL |
| **WebSocket Real-time** | ✅ 100% | ❌ 0% | ❌ 0% | 🟡 HIGH |
| **Tipping** | ✅ 100% | ⚠️ 30% | ❌ 0% | 🔴 CRITICAL |
| **NFT Minting** | ✅ 100% | ⚠️ 30% | ❌ 0% | 🟡 HIGH |
| **NFT Gallery** | ✅ 100% | ❌ 0% | ❌ 0% | 🟡 HIGH |
| **Wallet Balance** | ✅ 100% | ❌ 0% | ❌ 0% | 🔴 CRITICAL |
| **Transaction History** | ✅ 100% | ⚠️ 30% | ❌ 0% | 🟡 HIGH |
| **Rewards** | ✅ 100% | ❌ 0% | ❌ 0% | 🟡 HIGH |
| **Reputation** | ✅ 100% | ❌ 0% | ❌ 0% | 🟡 HIGH |
| **DAO** | ✅ 100% | ❌ 0% | ❌ 0% | 🟡 HIGH |
| **Proposals** | ✅ 100% | ❌ 0% | ❌ 0% | 🟡 HIGH |
| **Voting** | ✅ 100% | ❌ 0% | ❌ 0% | 🟡 HIGH |
| **Charity Donations** | ✅ 100% | ❌ 0% | ❌ 0% | 🟡 HIGH |
| **Analytics** | ✅ 100% | ⚠️ 20% | ❌ 0% | 🟢 MEDIUM |
| **Verification (PoH)** | ✅ 100% | ❌ 0% | ❌ 0% | 🟢 MEDIUM |
| **Ventures** | ✅ 100% | ❌ 0% | ❌ 0% | 🟢 LOW |
| **Data Export** | ✅ 100% | ❌ 0% | ❌ 0% | 🟢 LOW |

**Overall Integration: 28%**

---

## 💰 ESTIMATED COSTS (Monthly)

### **Development Phase (Weeks 1-6):**
- **Backend Hosting:** $0 (existing VPS)
- **MongoDB:** $0 (self-hosted)
- **Redis:** $0 (self-hosted)
- **Cloudinary:** $0 (free tier: 25GB)
- **Firebase:** $0 (free tier)
- **Domain:** $0 (already owned)
- **SSL:** $0 (Let's Encrypt)
- **Total:** $0/month

### **Production (Month 1-3, < 1000 users):**
- **Backend Hosting:** $20-50 (VPS upgrade)
- **MongoDB Atlas:** $0-9 (shared tier)
- **Redis Cloud:** $0 (free tier)
- **Cloudinary:** $0-49 (free → basic)
- **Firebase:** $0-25 (free → pay as go)
- **Solana RPC:** $0 (public RPC)
- **Total:** $20-133/month

### **Production (Month 4-6, 1K-10K users):**
- **Backend Hosting:** $50-200 (dedicated server)
- **MongoDB Atlas:** $57 (M10 shared)
- **Redis Cloud:** $0-10 (30MB tier)
- **Cloudinary:** $89 (advanced plan)
- **Firebase:** $25-100 (usage-based)
- **Solana RPC:** $0-49 (QuickNode starter)
- **Sentry:** $0-26 (error tracking)
- **Total:** $221-532/month

### **Production (Month 7-12, 10K-100K users):**
- **Backend Hosting:** $200-500 (load balancer + servers)
- **MongoDB Atlas:** $180 (M30 dedicated)
- **Redis Cloud:** $12-45 (1GB tier)
- **Cloudinary:** $249 (advanced plus)
- **Firebase:** $100-500 (heavy usage)
- **Solana RPC:** $49-299 (QuickNode pro)
- **Sentry:** $26-80 (team plan)
- **CDN:** $0-50 (Cloudflare)
- **Total:** $816-1,903/month

---

## 🎯 SUCCESS MILESTONES

### **Week 1 Milestone:**
- ✅ UI bugs fixed
- ✅ Real wallet auth working
- ✅ Image upload working
- ✅ Posts with images in feed
- ✅ Comments working
- **Metric:** Can create a post end-to-end

### **Week 2 Milestone:**
- ✅ User profiles working
- ✅ Follow system working
- ✅ Search working
- ✅ Notifications working
- **Metric:** Can interact with other users

### **Week 3 Milestone:**
- ✅ Tipping working
- ✅ NFT minting working
- ✅ Wallet features complete
- **Metric:** Can send/receive SOL tips

### **Week 4 Milestone:**
- ✅ DAO working
- ✅ Charity donations working
- ✅ Analytics working
- **Metric:** All major features functional

### **Week 5 Milestone:**
- ✅ Performance optimized
- ✅ Error handling complete
- ✅ UI polished
- **Metric:** App feels professional

### **Week 6 Milestone:**
- ✅ Beta tested
- ✅ Critical bugs fixed
- ✅ Submitted to stores
- **Metric:** Apps in review!

---

## 🚦 RISK ASSESSMENT

### **HIGH RISK:**

1. **Solana Wallet Integration Complexity** 🔴
   - Risk: Deep linking may not work on all devices
   - Mitigation: Test on multiple devices, provide fallbacks
   - Backup: Start with demo mode, add real wallets later

2. **Image Upload Performance** 🔴
   - Risk: Large images may timeout
   - Mitigation: Compress before upload, show progress
   - Backup: Limit image size to 5MB

3. **Push Notifications Reliability** 🔴
   - Risk: May not work on all devices/OS versions
   - Mitigation: Test thoroughly, add in-app notifications
   - Backup: WebSocket for real-time, email fallback

4. **App Store Rejection** 🔴
   - Risk: Crypto apps sometimes rejected
   - Mitigation: Follow guidelines exactly, clear documentation
   - Backup: Publish as beta, appeal if rejected

### **MEDIUM RISK:**

1. **Backend Performance Under Load** 🟡
   - Risk: May slow down with many users
   - Mitigation: Load testing, caching, pagination
   - Backup: Horizontal scaling with PM2 cluster

2. **WebSocket Connection Issues** 🟡
   - Risk: May disconnect on bad network
   - Mitigation: Auto-reconnect, offline queue
   - Backup: Fallback to polling

3. **NFT Minting Costs** 🟡
   - Risk: Gas fees may be too high
   - Mitigation: Batch minting, sponsor fees
   - Backup: Show cost preview, let user decide

### **LOW RISK:**

1. **Feature Creep** 🟢
   - Risk: Adding too many features delays launch
   - Mitigation: Stick to roadmap, track scope
   - Backup: MVP first, features later

2. **Time Estimation** 🟢
   - Risk: May take longer than 6 weeks
   - Mitigation: Daily progress tracking
   - Backup: Extend timeline if needed

---

## 📞 SUPPORT & ESCALATION

### **Development Questions:**
1. **Backend Issues:**
   - Check PROJECT_MEMORY.md
   - Review endpoint documentation
   - Test with Postman
   - Ask: "Is backend endpoint working?"

2. **Frontend Issues:**
   - Check Flutter documentation
   - Review Riverpod examples
   - Test on real device
   - Ask: "Is API response correct?"

3. **Integration Issues:**
   - Verify request/response format
   - Check authentication token
   - Review error logs
   - Ask: "What does API return?"

### **Blockers:**
If stuck > 2 hours on one issue:
1. Document the problem
2. Try alternative approaches
3. Move to next task
4. Come back with fresh perspective

---

## 📚 APPENDIX

### **A. API Endpoints Quick Reference**

**Authentication:**
- POST `/api/auth/login` - Wallet-based login

**Posts:**
- GET `/api/posts/feed` - Get feed
- POST `/api/posts` - Create post
- GET `/api/posts/:id` - Get post
- POST `/api/posts/:id/like` - Like post
- DELETE `/api/posts/:id/like` - Unlike post
- POST `/api/posts/:id/comments` - Add comment
- DELETE `/api/posts/:id` - Delete post
- GET `/api/posts/trending` - Trending posts
- GET `/api/posts/user/:wallet` - User's posts

**Users:**
- GET `/api/users/me` - Current user
- GET `/api/users/:wallet` - Get user
- PUT `/api/users/profile` - Update profile
- POST `/api/users/nft-pfp` - Set NFT PFP
- POST `/api/users/follow/:wallet` - Follow
- DELETE `/api/users/follow/:wallet` - Unfollow
- POST `/api/users/fcm-token` - Register FCM
- DELETE `/api/users/fcm-token` - Unregister FCM

**Notifications:**
- GET `/api/notifications` - List notifications
- GET `/api/notifications/unread` - Unread count
- PUT `/api/notifications/:id/read` - Mark read
- PUT `/api/notifications/read-all` - Mark all read
- DELETE `/api/notifications/:id` - Delete
- GET `/api/notifications/preferences` - Get prefs
- PUT `/api/notifications/preferences` - Update prefs
- WebSocket: `ws://api.mosana.xyz/notifications`

**Tipping:**
- POST `/api/tipping` - Send tip
- GET `/api/tipping/sent` - Sent tips
- GET `/api/tipping/received` - Received tips
- GET `/api/tipping/stats` - Stats
- GET `/api/tipping/preview/:amount` - Preview

**NFT:**
- POST `/api/nft/mint/:postId` - Mint NFT
- GET `/api/nft/:mintAddress` - Get NFT
- GET `/api/nft/user/:wallet` - User's NFTs
- GET `/api/nft/check/:postId` - Check mint status

**DAO:**
- POST `/api/dao` - Create DAO
- GET `/api/dao` - List DAOs
- POST `/api/dao/:id/join` - Join DAO
- POST `/api/dao/:id/proposals` - Create proposal
- POST `/api/dao/:id/proposals/:proposalId/vote` - Vote

**Charity:**
- GET `/api/social-good/causes` - List charities
- POST `/api/social-good/donate` - Donate

**Rewards:**
- GET `/api/rewards/today` - Today's rewards
- GET `/api/rewards/history` - Reward history

**Reputation:**
- GET `/api/reputation/:wallet` - Get reputation
- GET `/api/reputation/leaderboard/top` - Leaderboard

### **B. Flutter Packages to Add**

```yaml
dependencies:
  # Solana
  solana: ^0.30.0
  bip39: ^1.0.6
  ed25519_hd_key: ^2.2.0
  
  # Image
  image: ^4.0.17
  flutter_image_compress: ^2.1.0
  
  # Share
  share_plus: ^7.2.1
  
  # URL Launcher
  url_launcher: ^6.2.4
  
  # Clipboard
  flutter_clipboard: ^1.0.0
  
  # Shimmer
  shimmer: ^3.0.0
  
  # Charts (for analytics)
  fl_chart: ^0.66.0
  
  # QR Code
  qr_flutter: ^4.1.0
  mobile_scanner: ^3.5.5
```

### **C. Environment Variables**

**Backend (.env):**
```env
NODE_ENV=production
PORT=4000
MONGODB_URI=mongodb://mosanaAdmin:password@localhost:27017/mosana
JWT_SECRET=your_secret_key
SOLANA_RPC_URL=https://api.mainnet-beta.solana.com
API_URL=https://api.mosana.xyz
FRONTEND_URL=https://mosana.xyz
```

**Frontend (.env):**
```env
API_BASE_URL=https://api.mosana.xyz
WS_URL=wss://api.mosana.xyz/notifications
CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_UPLOAD_PRESET=your_preset
ENVIRONMENT=production
```

---

## ✅ FINAL CHECKLIST (Before Launch)

### **Week 1:**
- [ ] Bottom nav visible
- [ ] Text underlines removed
- [ ] Real wallet auth working
- [ ] Image upload working
- [ ] Posts with images working
- [ ] Comments working

### **Week 2:**
- [ ] User profiles loading
- [ ] Follow/unfollow working
- [ ] Search working
- [ ] Notifications working
- [ ] Push notifications working

### **Week 3:**
- [ ] Tipping working
- [ ] NFT minting working
- [ ] Wallet balance showing
- [ ] Transaction history working
- [ ] Rewards displaying

### **Week 4:**
- [ ] DAO list working
- [ ] Create DAO working
- [ ] Proposals working
- [ ] Voting working
- [ ] Charity donations working

### **Week 5:**
- [ ] App feels fast (< 300ms)
- [ ] No crashes
- [ ] Error handling everywhere
- [ ] UI polished
- [ ] Animations smooth

### **Week 6:**
- [ ] Beta tested with 20+ users
- [ ] Critical bugs fixed
- [ ] Screenshots taken
- [ ] App Store metadata written
- [ ] Apps submitted

---

## 🎉 CONCLUSION

This is your **comprehensive, production-ready roadmap** to launch Mosana in 6 weeks.

**Key Takeaways:**
1. **Backend is 95% ready** - Just need to connect it
2. **Frontend needs 70% work** - But architecture is solid
3. **Week 1 is critical** - Fix bugs, add auth, add images
4. **Weeks 2-4 are features** - Connect all backend endpoints
5. **Week 5 is polish** - Make it professional
6. **Week 6 is launch** - Test and submit

**You CAN do this!** 💪

Stay focused, follow the plan, and you'll have a production-ready app in 6 weeks.

**Let's build something amazing!** 🚀

---

**Next Step:** Start Week 1, Phase 1A - Fix critical UI bugs!

**Questions?** Review this plan, identify blockers, and let's tackle them together.

**Your professional development partner,**  
**Senior Full-Stack Engineer** 👨‍💻
