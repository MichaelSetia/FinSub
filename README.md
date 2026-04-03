<div align="center">

<img src="https://img.shields.io/badge/Platform-iOS%2017%2B-black?style=for-the-badge&logo=apple&logoColor=white" />
<img src="https://img.shields.io/badge/Swift-5.9-FA7343?style=for-the-badge&logo=swift&logoColor=white" />
<img src="https://img.shields.io/badge/SwiftUI-Framework-007AFF?style=for-the-badge&logo=swift&logoColor=white" />
<img src="https://img.shields.io/badge/SwiftData-Persistence-34C759?style=for-the-badge" />
<img src="https://img.shields.io/badge/Architecture-MVVM-FF6B35?style=for-the-badge" />

<br />
<br />

# 💳 FinSub

### Subscription Manager for iOS

**Track every subscription. Never miss a renewal. Stay in control of your spending.**

[Features](#-features) · [Tech Stack](#-tech-stack) · [Project Structure](#-project-structure) · [Setup](#-setup) · [Roadmap](#-roadmap)

</div>

---

## 📸 Screenshots

> _Coming soon — UI screenshots will be added after first build._

---

## ✨ Features

### 📊 Dashboard
Get a bird's-eye view of your financial subscriptions at a glance:
- **Total monthly spending** — see exactly how much you're spending each month
- **Active subscription count** — know how many services you're subscribed to
- **Nearest renewal** — always be aware of what's billing next

### 📋 Subscription Management
Full CRUD control over all your subscriptions:
- ➕ **Add** new subscriptions with full details
- ✏️ **Edit** existing entries anytime
- ❌ **Delete** subscriptions you've cancelled
- 🏷️ **Categorize** by type — Entertainment, Music, Productivity, and more
- 🎨 **Custom categories** — create your own categories as needed

### 🔁 Billing Cycle Support
- Monthly billing
- Yearly billing
- _(Extendable: weekly, quarterly, free trial, etc.)_

### 🔔 Smart Notifications
- Renewal reminder **1 day before** billing date (H-1)
- Supports **recurring notifications** for both monthly and yearly cycles

### 🗓️ Calendar View
- Visual calendar showing all upcoming payment dates
- Highlights billing dates so you never miss a charge

### 🖼️ Auto Brand Logo Detection
- Automatically fetches the logo for known subscription services based on name input

---

## 🛠 Tech Stack

| Layer | Technology |
|---|---|
| **UI Framework** | SwiftUI |
| **Local Database** | SwiftData |
| **Architecture** | MVVM |
| **Notifications** | UserNotifications |
| **Async Handling** | Async/Await (modern Swift concurrency) |

---

## 📂 Project Structure

```
FinSub/
│
├── Models/
│   └── SubscriptionModel.swift          # Core data model
│
├── ViewModels/
│   └── SubscriptionViewModel.swift      # Business logic & state management
│
├── Views/
│   ├── HomeView.swift                   # Dashboard screen
│   ├── AddSubscriptionView.swift        # Add/Edit subscription form
│   ├── ListSubscriptionView.swift       # Subscription list screen
│   └── CardSubscriptionRow.swift        # Reusable subscription card component
│
├── Services/
│   └── NotificationService.swift        # Renewal reminder scheduling
│
├── Repository/
│   └── SwiftDataSubscriptionRepository.swift  # SwiftData persistence layer
│
└── Utils/
    └── BrandDetector.swift              # Auto logo fetching utility
```

---

## 🔄 App Flow

```
Open App
   │
   ▼
HomeView (Dashboard)
   │── Total monthly cost
   │── Active subscriptions list
   │
   ├── Tap ➕ ──────────────────────────────────────────────┐
   │                                                         ▼
   │                                             AddSubscriptionView
   │                                                │ Name
   │                                                │ Price
   │                                                │ Billing date
   │                                                │ Billing cycle
   │                                                │ Category
   │                                                │
   │                                                └── Save
   │                                                        │
   │◄───────────────────────────────────────────────────────┘
   │           Data saved + Notification scheduled
   │
   ├── Subscription appears in List View
   ├── Subscription appears in Calendar View
   │
   └── Per subscription:
          ├── ✏️ Edit
          ├── ❌ Delete
          └── 🔍 Track renewal
```

---

## ⚙️ Setup

### Requirements
- Xcode 15+
- iOS 17+ Simulator or physical device
- macOS Sonoma or later (recommended)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/FinSub.git
   cd FinSub
   ```

2. **Open in Xcode**
   ```bash
   open FinSub.xcodeproj
   ```

3. **Run the app**
   - Select a simulator or your connected device
   - Press `Cmd + R` to build and run

### 🔐 Required Permissions

| Permission | Purpose |
|---|---|
| **Notifications** | Sending renewal reminders before billing date |

> The app will prompt the user to allow notifications on first launch.

---

## 🚀 Roadmap

| Feature | Status |
|---|---|
| Dashboard with monthly summary | ✅ Done |
| Add / Edit / Delete subscriptions | ✅ Done |
| Billing cycle support | ✅ Done |
| H-1 renewal notification | ✅ Done |
| Calendar view | ✅ Done |
| Brand logo auto-detection | ✅ Done |
| 📈 Analytics (spending graph) | 🔜 Planned |
| 🔍 Search & filter | 🔜 Planned |
| ☁️ Cloud sync (iCloud / Firebase) | 🔜 Planned |
| 🤖 AI subscription detection from email | 💡 Idea |
| 💳 Payment tracking (paid/unpaid) | 🔜 Planned |
| 🎯 Free trial reminder | 🔜 Planned |
| 📊 Category spending breakdown | 🔜 Planned |

---

## 💡 About This Project

**FinSub** was built to solve a real, everyday problem — subscription creep. It's easy to forget which services you're paying for and how much they cost collectively.

This project also serves as a portfolio piece demonstrating:
- ✅ **SwiftUI** — declarative, modern UI
- ✅ **MVVM Architecture** — clean separation of concerns
- ✅ **SwiftData** — local persistence with Swift-native APIs
- ✅ **Notification System** — scheduling and managing recurring local notifications

---

## 👨‍💻 Author

**Michael Setiawan**  
Business Information Systems Student  
iOS & Frontend Enthusiast 🚀

[![GitHub](https://img.shields.io/badge/GitHub-@yourusername-181717?style=flat&logo=github)](https://github.com/yourusername)

---

<div align="center">

Made with ❤️ and Swift

</div>
