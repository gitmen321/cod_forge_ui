# 🛒 CodForge UI – Category Screen Demo (Flutter + Riverpod)

This project is a **Category Screen** implementation using **Flutter** and **Riverpod (v2.6.1)** for state management. It showcases pagination, UI states (loading, error, no data), and reusable components in a well-structured and scalable architecture.

## ✨ Features

- ✅ Clean project structure for better scalability and maintenance
- ✅ Riverpod for robust and reactive state management
- ✅ Dummy API simulation with pagination support
- ✅ Responsive grid layout using `SliverGrid`
- ✅ UI states: loading spinner, error with retry, and no data message
- ✅ Custom category tile with network image and label

---

## 📁 Project Structure

lib/ ├── main.dart # Entry point ├── core/ │ └── widgets/ # Common reusable widgets (e.g., error, loading, tile) ├── models/ │ └── category.dart # Immutable Category model with fromMap, toMap, copyWith ├── screens/ │ ├── home/ │ │ └── home_screen.dart # BottomNavigationBar + Tab navigation │ ├── category/ │ │ ├── category_screen.dart # Main Category UI with grid view + scroll listener │ │ └── widgets/ │ │ └── category_tile.dart# Category card UI ├── services/ │ └── category_service.dart # Simulated backend with dummy data & pagination ├── providers/ │ └── category_provider.dart # Riverpod StateNotifier for category state


---

## 🧱 Model Class – `CategoryModel`

The `CategoryModel` class is:
- Immutable (`const` constructor)
- Contains:
  - `fromMap` factory constructor
  - `toMap` method
  - `copyWith` method

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/gitmen321/cod_forge_ui.git
cd cod_forge_ui


2. Install Dependencies

flutter pub get

3. Run the App

flutter run


####

🧪 Testable UI States
You can simulate different scenarios by editing the _loadInitial() method in category_provider.dart:

dart
Copy
Edit
// For Error UI:
state = AsyncValue.error("Something went wrong", StackTrace.current);

// For Empty Data UI:
state = AsyncValue.data(CategoryState(categories: []));

 Dependencies
flutter_riverpod ^2.6.1 – For state management

📸 UI Preview

🟢 Normal State	           ❌ Error State	                    📭 Empty State
Grid of categories	        Retry button with error	           No categories message

👨‍💻 Developed By
Raaz – Flutter Developer

🔗 LinkedIn   : https://www.linkedin.com/in/raaz-ch-a77535277/
 💻 GitHub    : https://github.com/gitmen321 
 ✉️ Email     : raazraz621@gmail.com

 📄 License
 
    This project is for educational/demo purposes only.