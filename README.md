<div align="center">

<img width="38" height="100" alt="Masareef Logo" src="https://github.com/user-attachments/assets/82914032-1d4b-4018-900e-f49b6771b281" />

# مصاريف — Masareef

**A clean, minimal expense tracker built with Flutter**

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=flat&logo=dart)
![Platform](https://img.shields.io/badge/Platform-Android-3DDC84?style=flat&logo=android)
![License](https://img.shields.io/badge/License-MIT-blue?style=flat)
![Open Source](https://img.shields.io/badge/Open%20Source-❤️-red?style=flat)

</div>

---

## 📖 About

**Masareef (مصاريف)** is a personal expense tracking app designed with simplicity and clarity in mind. Whether you want to log your daily spending or get a high-level view of where your money goes, Masareef keeps it straightforward — no accounts, no cloud, no clutter.

---

## ✨ Features

### 💸 Expense Management
- Add expenses with title, amount, category, and date
- View full expense history with filtering options
- Delete individual entries or clear all data

### 📊 Analytics
- Visual **distribution chart** showing spending by category
- **Category ranking** to see where you spend the most
- **Daily trend chart** to track spending over time

### 🗂️ Categories
- Predefined categories covering all common spending areas (food, transport, health, entertainment, and more)
- Custom categories coming in a future update

### 🌍 Localization
- Full **Arabic** and **English** support
- Seamless in-app language switching

### 🎨 Theming
- **Light** and **Dark** mode
- Smooth animated theme transitions

### 🔔 Daily Reminder
- Optional daily notification to remind you to log your expenses
- Scheduled at a fixed time every day
- Can be enabled/disabled from settings

### 📤 Export (Coming Soon)
- Export your expense data as a **CSV file**

---

## 🏗️ Architecture

Masareef follows a **feature-first clean architecture** with BLoC/Cubit for state management.

```
lib/
├── core/
│   ├── constant/        # Colors, images
│   ├── localization/    # AR/EN translations
│   ├── theme/           # App theme + controller
│   ├── utils/           # Notification service, spacing
│   └── widgets/         # Shared UI components
│
└── features/
    ├── splash/          # Animated splash screen
    ├── onboarding/      # First-launch onboarding
    ├── home/            # Dashboard, summary, recent expenses
    ├── adding/          # Add new transaction screen
    ├── expenses/        # Data, domain, cubit, history screen
    ├── analytics/       # Charts and distribution
    └── settings/        # Theme, language, notifications, data
```

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter |
| State Management | flutter_bloc / Cubit |
| Local Storage | shared_preferences |
| Notifications | flutter_local_notifications |
| Timezone | timezone |
| Responsive UI | flutter_screenutil |

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `>=3.0.0`
- Android SDK with a physical device or emulator (API 21+)

### Installation

```bash
# Clone the repository
git clone https://github.com/your-username/masareef.git

# Navigate to the project
cd masareef

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---

## 🗺️ Comming Features

- [x] Add & track expenses
- [x] Analytics with charts
- [x] Arabic / English localization
- [x] Dark / Light theme
- [x] Daily reminder notification
- [ ] Export to CSV
- [ ] Custom categories
- [ ] Monthly budget limits
- [ ] Widget support

---

## 🤝 Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

<div align="center">
  Made with ❤️ by <a href="https://github.com/3sem3bdallah">Asem</a>
</div>
