# Personal Finance Tracker - Flutter Take-Home Assessment

A Flutter application for managing personal financial transactions with support for expenses and income tracking, built with clean architecture principles.

> **Note**: This project was completed as part of a technical assessment. Estimated completion time: ~4 hours.

### Prerequisites
- Flutter SDK 3.10.4 or higher
- Dart SDK 3.10.4 or higher

## Assessment Requirements Met

### Core Functionality 
- ✅ Add transactions (income/expense) with amount, category, date, and optional notes
- ✅ Display a list of all transactions with real-time updates
- ✅ Show current balance at the top of the screen (calculated dynamically)
- ✅ Filter transactions by type (income/expense/all)
- ✅ Persist data locally using SQLite - survives app restarts

### Bonus Features Implemented
- ✅ Form validation in transaction editor
- ✅ Transaction editing and deletion
- ✅ Unit tests for Bloc logic (partial)

### Technical Requirements 
- ✅ **State Management**: Implemented using `flutter_bloc` (Cubit pattern)
  - `TransactionsCubit`: Manages transaction list, balance calculation, and filters
  - `TransactionEditorCubit`: Handles transaction creation/editing
  - `ThemeBuilderCubit`: Manages theme state
- ✅ **Theming**: Light/dark mode toggle with persisted preference
  - Custom theme system with `ThemeContext` for consistent theming
  - Theme preference stored in `SharedPreferences`
- ✅ **Data Persistence**: 
  - SQLite via `sqflite` package for transaction storage
  - `SharedPreferences` for user preferences (theme)
- ✅ **Best Practices**: Follows Flutter material design guidelines with custom components


## Architecture

This project follows **Clean Architecture** principles with clear separation of concerns across multiple layers:

### Layer Structure

```
lib/
├── core/                  # Core business logic layer
│   ├── models/            # Domain models
│   ├── services/          # Abstract service interfaces
│   └── extensions/        # Dart extension methods
│
├── core_data/             # Data layer implementation
│   ├── database/          # SQLite database implementation
│   └── preferences/       # SharedPreferences implementation
│
├── core_ui/               # UI layer foundation
│   ├── components/        # Reusable UI components
│   ├── theme/             # Theme definitions and colors
│   └── translations.dart  # Localization support
│
├── features/              # Feature modules (presentation layer)
│   ├── transactions/      # Transaction list feature
│   ├── transaction_editor/# Transaction CRUD feature
│   └── theme_builder/     # Theme management feature
│
├── router/                # Navigation layer
│   ├── navigator_service.dart
│   ├── routes.dart
│   └── routes_handler.dart
│
├── locator.dart          # Dependency injection configuration
├── main.dart             # Application entry point
└── app_contracts.dart    # App-level constants
```

### Architecture Layers

#### 1. **Core Layer** (`lib/core/`)
Contains the business logic and domain models that are framework-agnostic:
- **Models**: Domain entities like `TransactionModel`
- **Service Interfaces**: Abstract contracts (e.g., `ITransactionDBService`, `IPreferencesService`)
- **Extensions**: Utility extensions (e.g., `IntExtensions`)

#### 2. **Data Layer** (`lib/core_data/`)
Implements data persistence and storage:
- **Database**: SQLite implementation using `sqflite` package
  - `DBService`: Database initialization and management
  - `TransactionDbService`: Transaction CRUD operations
- **Preferences**: User preferences using `shared_preferences`

#### 3. **Presentation Layer** (`lib/features/`)
Each feature is organized as a self-contained module using **BLoC/Cubit** pattern:
- **State Management**: Uses `flutter_bloc` for reactive state management
- **Feature Structure**:
  ```
  feature_name/
  ├── feature_name.dart          # UI widget
  ├── feature_name_cubit.dart    # Business logic
  └── feature_name_state.dart    # State definitions
  ```

#### 4. **UI Layer** (`lib/core_ui/`)
Shared UI components and theming:
- **Components**: Reusable widgets (`AppButton`, `AppText`, `AppIcon`, etc.)
- **Theme**: Centralized theme management with `ThemeContext`

#### 5. **Router Layer** (`lib/router/`)
Navigation management:
- **NavigatorService**: Global navigation handler
- **Routes**: Route definitions
- **RoutesHandler**: Route generation logic

### Design Patterns

#### Dependency Injection
Uses **GetIt** for service locator pattern:
```dart
// Configured in locator.dart
locator.registerLazySingleton(() => DBService());
locator.registerFactory<ITransactionDBService>(() => TransactionDbService());
```

Benefits:
- Loose coupling between layers
- Easy testing with mock implementations
- Centralized dependency management

#### BLoC/Cubit Pattern
All features use Cubit for state management:
```dart
class TransactionsCubit extends Cubit<TransactionsState> {
  // Business logic separated from UI
}
```

Benefits:
- Clear separation of business logic and presentation
- Reactive UI updates
- Testable business logic

#### Repository Pattern
Data access abstracted through interfaces:
```dart
abstract class ITransactionDBService {
  Future<List<TransactionModel>> getAllTransactions();
  Future<int> insertTransaction(TransactionModel model);
  // ... other methods
}
```

Benefits:
- Easy to swap data sources
- Mockable for testing
- Single responsibility principle

### Data Flow

```
User Interaction
      ↓
  UI Widget
      ↓
    Cubit (State Management)
      ↓
Service Interface (ITransactionDBService)
      ↓
Service Implementation (TransactionDbService)
      ↓
  Database (SQLite)
```

## Tech Stack

### Core Dependencies
- **Flutter SDK**: ^3.10.4
- **flutter_bloc**: ^9.1.1 - State management
- **get_it**: ^9.2.0 - Dependency injection
- **sqflite**: ^2.4.2 - Local database
- **shared_preferences**: ^2.5.4 - Key-value storage
- **equatable**: ^2.0.8 - Value equality

### Dev Dependencies
- **flutter_test**: Testing framework
- **mockito**: ^5.6.3 - Mocking for tests
- **build_runner**: ^2.10.5 - Code generation
- **flutter_lints**: ^6.0.0 - Linting rules


## Testing

The `TransactionsCubit` is fully covered with unit tests, including:

Run tests with:
```bash
flutter test
```


## Architecture Decisions & Trade-offs

### Key Decisions

1. **Clean Architecture with Feature Modules**
   - **Decision**: Organized code into `core`, `core_data`, `core_ui`, and `features` directories
   - **Rationale**: Provides clear separation of concerns and makes the codebase more maintainable and testable
   - **Trade-off**: Slightly more complex folder structure, but significantly improves long-term maintainability

2. **Cubit over Bloc**
   - **Decision**: Used Cubit pattern instead of full Bloc pattern
   - **Rationale**: For this application's complexity, Cubit provides sufficient functionality with less boilerplate
   - **Trade-off**: Less explicit event tracking, but simpler code and faster development

3. **Repository Pattern with Interfaces**
   - **Decision**: Created abstract interfaces (`ITransactionDBService`, `IPreferencesService`)
   - **Rationale**: Enables easy swapping of implementations and simplifies testing with mocks
   - **Trade-off**: Additional abstraction layer, but provides flexibility and testability

4. **GetIt for Dependency Injection**
   - **Decision**: Used GetIt service locator
   - **Rationale**: Simpler setup for this scale, centralized dependency management

5. **Custom Theme System**
   - **Decision**: Built custom `ThemeContext` wrapper
   - **Rationale**: Provides type-safe access to colors and easier theme switching

### Shortcuts Due to Time Constraints

1. **Limited Test Coverage**
   - Currently minimal unit tests

2. **No Safe Dialog on Delete**
   - Transactions can be deleted without confirmation
   - Would add: confirmation dialog before deleting transactions to prevent accidental deletions

3. **No Pagination in Transaction List**
   - Currently loads all transactions at once, which could cause performance issues with large datasets
   - Would add: implement pagination to load transactions in batches (e.g., 50 items per page) using SQL LIMIT/OFFSET queries, add infinite scroll or "Load More" functionality for better performance

4. **Hardcoded Transaction Categories and Currency**
   - Categories are currently defined as hardcoded enums in the code, and currency is fixed to dollars with no currency selection
   - Would add: store categories in the database with their own table, create a category management feature allowing users to add/edit/delete custom categories. Additionally, implement currency selection (USD, EUR, GBP, etc.) with proper formatting and currency symbols, allowing users to choose their preferred currency.

5. **Error Handling**
   - Currently no try-catch blocks around database operations, stream subscriptions, or navigation calls. Database failures, SQLite errors, or unexpected exceptions would crash the app rather than showing user-friendly error messages
   - Would add: wrap all async database operations in try-catch blocks, emit error states in cubits (e.g., `BasicUIState.error`), display user-friendly error messages using snackbars or dialogs.





