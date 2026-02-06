# 🧪 MOSANA FLUTTER - TESTING CHECKLIST

**Date**: 2026-02-06  
**Version**: v1.0.0 (Phase 1 Complete)  
**Tester**: Ahmed

---

## 📱 DEVICE TESTING

Test on multiple devices to verify responsiveness:

- [ ] **Desktop Browser** (Chrome/Safari/Firefox)
- [ ] **Mobile Phone** (Open in browser)
- [ ] **Tablet** (If available)
- [ ] **Different screen sizes**

---

## 🎯 SCREEN-BY-SCREEN TESTING

### ✅ **1. SPLASH SCREEN** (3 seconds)
- [ ] Logo appears with fade-in
- [ ] Logo has purple/blue glow effect
- [ ] Three loading dots animate in wave pattern
- [ ] "mosana" text has gradient
- [ ] "Powered by Solana" text visible at bottom
- [ ] Transitions to Onboarding after 3 seconds

**Issues found**: _______________________________

---

### ✅ **2. ONBOARDING SCREEN** (3 slides)

**Slide 1 - Lightning Fast**:
- [ ] Icon visible with glow circle
- [ ] Title: "⚡ Lightning Fast"
- [ ] Subtitle has gradient
- [ ] Description text readable
- [ ] Can swipe to next slide
- [ ] "Skip" button works (jumps to slide 3)
- [ ] "Next" button works (goes to slide 2)

**Slide 2 - Fair & Ethical**:
- [ ] Icon and content visible
- [ ] Title: "🌱 Fair & Ethical"
- [ ] Swipe works
- [ ] "Next" button goes to slide 3

**Slide 3 - Social Impact**:
- [ ] Icon and content visible
- [ ] Title: "❤️ Social Impact"
- [ ] "Get Started" button visible (gradient)
- [ ] Tapping "Get Started" goes to Connect Wallet

**General**:
- [ ] Page indicators (dots) update correctly
- [ ] Active dot has gradient
- [ ] Swipe gestures smooth
- [ ] Background gradient visible

**Issues found**: _______________________________

---

### ✅ **3. CONNECT WALLET SCREEN**

**Phantom Wallet**:
- [ ] Card has highlighted border (purple/blue)
- [ ] "Recommended ✓" badge visible
- [ ] Icon visible
- [ ] Name and description readable
- [ ] Tapping shows loading spinner
- [ ] After 2 seconds, navigates to Home

**Solflare Wallet**:
- [ ] Card has standard border
- [ ] "Popular choice" description
- [ ] Tapping works

**Saga Wallet**:
- [ ] Card has standard border
- [ ] "Mobile optimized" description
- [ ] Tapping works

**General**:
- [ ] Security note visible at bottom
- [ ] Lock icon visible
- [ ] "Don't have a wallet?" link visible
- [ ] Background gradient visible
- [ ] Cards have glass effect

**Issues found**: _______________________________

---

### ✅ **4. HOME FEED SCREEN**

**Header**:
- [ ] Mosana logo visible (32x32)
- [ ] "mosana" text with gradient
- [ ] Notification bell icon visible
- [ ] Red notification badge (dot) visible
- [ ] Profile avatar visible (small, circular)
- [ ] Tapping notification bell → opens Notifications
- [ ] Tapping avatar → opens Profile
- [ ] Header becomes solid on scroll

**Posts (5 total)**:
- [ ] All 5 posts visible in feed
- [ ] Post 1 (Alice - NFT minted) has gold border
- [ ] Post 1 has "🔥 IMMORTAL" badge
- [ ] Post 2 (Bob) displays correctly
- [ ] Images load (or show placeholder)
- [ ] Hashtags visible and colored blue
- [ ] Author avatars visible
- [ ] Verified badges (checkmarks) visible
- [ ] "2 hours ago" timestamps visible

**Post Actions**:
- [ ] Like button visible (heart icon)
- [ ] Comment button visible (chat icon)
- [ ] Tip button visible (wallet icon, gold)
- [ ] Mint button visible (for non-minted posts)
- [ ] Share button visible
- [ ] Tapping buttons shows in console (check browser DevTools)

**Stats**:
- [ ] Like counts visible
- [ ] Comment counts visible
- [ ] Tip counts + amounts visible (e.g., "$25.50")

**Bottom Navigation**:
- [ ] 5 tabs visible: Home, Explore, (space), DAO, Wallet
- [ ] Home tab highlighted (purple)
- [ ] Other tabs gray
- [ ] Tapping tabs changes active state

**Floating Action Button**:
- [ ] FAB visible in center (purple circle with +)
- [ ] Positioned above bottom nav
- [ ] Tapping shows console message

**Pull to Refresh**:
- [ ] Pull down on feed shows refresh indicator
- [ ] Indicator has purple color
- [ ] Releases and animates

**Scrolling**:
- [ ] Smooth scrolling (60 FPS)
- [ ] Header changes on scroll (blur effect)
- [ ] No lag or jank

**Issues found**: _______________________________

---

### ✅ **5. NOTIFICATIONS SCREEN**

**Header**:
- [ ] Back button works (returns to Home)
- [ ] "Notifications" title visible
- [ ] "Mark all read" button visible
- [ ] Settings icon visible

**Notifications (5 total)**:
- [ ] Notification 1 (Tip - high priority) has gold border
- [ ] Shows "💰 Tip Received!"
- [ ] Shows amount "15.5 USDC"
- [ ] Shows time "5 minutes ago"
- [ ] Blue dot visible (unread)

- [ ] Notification 2 (New Follower) displays
- [ ] Shows "@bob started following you"
- [ ] Avatar visible

- [ ] Notification 3 (Like) displays
- [ ] Shows "@charlie liked your post"
- [ ] Marked as read (no blue dot)

- [ ] Notification 4 (Comment) displays
- [ ] Shows comment preview

- [ ] Notification 5 (Milestone) displays
- [ ] Shows trophy icon
- [ ] Shows "You're now Tier 3"

**Interactions**:
- [ ] Tapping notification shows console message
- [ ] "Mark all read" button works
- [ ] Settings button shows console message

**Design**:
- [ ] Glass cards with blur effect
- [ ] Different icon colors (gold, blue, red)
- [ ] Proper spacing between cards
- [ ] Time ago format working

**Issues found**: _______________________________

---

### ✅ **6. PROFILE SCREEN** (Placeholder)

- [ ] Back button works
- [ ] "Profile" title visible
- [ ] Large purple icon visible
- [ ] "Profile Screen" text visible
- [ ] "Coming soon in Phase 2!" text visible

**Issues found**: _______________________________

---

## 🎨 DESIGN & ANIMATIONS

**Colors**:
- [ ] Dark theme (black background)
- [ ] Purple/blue gradients visible
- [ ] Gold accents for tips/NFTs
- [ ] Text readable (white/gray)

**Glassmorphism**:
- [ ] Cards have frosted glass effect
- [ ] Blur effect visible
- [ ] Gradient borders visible
- [ ] Shadows visible

**Animations**:
- [ ] Splash logo glow pulses
- [ ] Loading dots animate
- [ ] Onboarding slides smoothly
- [ ] Buttons scale on tap (1.0 → 0.95 → 1.0)
- [ ] Page transitions smooth
- [ ] No lag or jank

**Typography**:
- [ ] Headers bold and clear
- [ ] Body text readable
- [ ] Proper line spacing
- [ ] No text overflow

**Issues found**: _______________________________

---

## 📊 MOCK DATA

**Posts**:
- [ ] Alice's post (NFT minted)
- [ ] Bob's post (Solana benefits)
- [ ] Charlie's post (GM with tips)
- [ ] Alice's NFT art post
- [ ] Bob's DAO voting post

**Notifications**:
- [ ] Tip from Alice (15.5 USDC)
- [ ] Follow from Bob
- [ ] Like from Charlie
- [ ] Comment from Bob
- [ ] Reputation milestone

**Users**:
- [ ] Alice (verified, NFT artist)
- [ ] Bob (verified, DeFi researcher)
- [ ] Charlie (not verified, trader)

**Issues found**: _______________________________

---

## 🔧 TECHNICAL

**Performance**:
- [ ] First load time < 5 seconds
- [ ] Smooth scrolling (no lag)
- [ ] Images load quickly
- [ ] No memory leaks (long use)

**Browser Compatibility**:
- [ ] Chrome/Edge works
- [ ] Safari works
- [ ] Firefox works
- [ ] Mobile browsers work

**Responsive Design**:
- [ ] Looks good on desktop (>1200px)
- [ ] Looks good on tablet (768-1024px)
- [ ] Looks good on mobile (320-767px)
- [ ] No horizontal scroll
- [ ] Touch targets big enough (44x44)

**Console Errors**:
- [ ] No errors in browser console
- [ ] No warnings (or minor only)
- [ ] Button taps log correctly

**Issues found**: _______________________________

---

## 🐛 BUGS FOUND

List any bugs or issues here:

1. _______________________________________________
2. _______________________________________________
3. _______________________________________________
4. _______________________________________________
5. _______________________________________________

---

## 💡 FEEDBACK & SUGGESTIONS

What do you like?
___________________________________________________
___________________________________________________

What should we change?
___________________________________________________
___________________________________________________

What's missing?
___________________________________________________
___________________________________________________

Overall rating (1-10): ______

---

## ✅ FINAL CHECKLIST

- [ ] All 6 screens tested
- [ ] All features working
- [ ] No critical bugs
- [ ] Design looks great
- [ ] Ready for Phase 2 (API integration)
- [ ] Ready to show to team/investors

---

## 📝 NOTES

Additional comments:
___________________________________________________
___________________________________________________
___________________________________________________

---

**Testing Date**: _______________  
**Time Spent**: _______________  
**Status**: ☐ Approved  ☐ Needs Changes  
**Next Steps**: _______________

