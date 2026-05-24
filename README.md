# BankingTask

A modern banking transactions application built with SwiftUI as a technical home assignment.

---

# Design Reference

The UI design was inspired by the following Figma community design:

https://www.figma.com/design/4NBXzTGBpXhUctQkheQo1E/Banking-App--Community-?node-id=1-213&t=lpLSLMzy1BepLEkR-0

---

# Features

- Transactions list screen
- Transaction details screen
- Live transaction editing using Binding
- Infinite scrolling / pagination
- Reusable Design System package
- Custom reusable button style
- Shared app state management
- Modern SwiftUI architecture
- Clean and scalable project structure

---

# Architecture

The app was built using a lightweight MVVM-style architecture with a centralized Store pattern.

## Main Layers

### Model

```swift
Transaction
```

Represents the transaction entity displayed across the application.

---

### View

SwiftUI screens:

- `TransactionsListView`
- `TransactionDetailsView`

Responsible only for UI rendering and user interactions.

---

### Store / ViewModel

```swift
TransactionsStore
```

Acts as the observable source of truth for the application.

Responsibilities:
- Holds transactions state
- Handles loading state
- Handles pagination
- Calls the service layer
- Exposes data to the UI

Built using:

```swift
@Observable
```

from Apple’s modern Observation framework.

---

### Service Layer

```swift
TransactionsServiceProtocol
MockTransactionsService
```

Responsible for fetching transactions data.

A mock implementation was used instead of a real backend API in order to focus on:
- architecture
- SwiftUI state management
- pagination logic
- reusable UI patterns

---

# Design System

A dedicated Swift Package named:

```swift
BankingDesignSystem
```

was created in order to centralize reusable UI resources.

## Included

### Colors

```swift
DSColors
```

Centralized color palette for:
- primary colors
- text colors
- income / expense colors
- backgrounds

---

### Typography

```swift
DSTypography
```

Reusable typography definitions.

---

### Icons

```swift
DSIcons
```

Centralized SF Symbols references.

---

### Spacing

```swift
DSSpacing
```

Reusable spacing constants for consistent layout and padding.

---

### Components

```swift
DSPrimaryButtonStyle
```

Reusable button styling across the application.

---

# Technologies

- SwiftUI
- Observation Framework
- Async/Await
- Swift Package Manager
- NavigationStack
- Binding
- Environment

---

# Pagination

Pagination was implemented inside the mock service layer.

The app automatically loads additional transactions when the user scrolls to the bottom of the list.

---

# State Management

The application uses a centralized Store pattern together with:

```swift
@Environment
```

and:

```swift
@Observable
```

to provide reactive UI updates across screens.

---

# Project Structure

```text
App
Models
Views
Stores
Services
```

The Design System is separated into its own Swift Package for scalability and reusability.

---

# AI Usage

AI tools were used for:
- SwiftUI guidance
- architecture discussions
- Observation framework explanations
- Design System structure ideas
- SwiftUI best practices

Claude AI was also used as part of the development and learning process during the implementation of the project.

All code was reviewed, modified, and integrated manually.
---

# Notes

The goal of this project was to demonstrate:
- scalable SwiftUI architecture
- clean code organization
- reusable UI patterns
- modern iOS development practices

The project was built using the latest available Xcode and iOS SDK available on the development machine.

The original assignment mentioned iOS 26.
The project was implemented using the latest iOS SDK version available in the current Xcode environment.
