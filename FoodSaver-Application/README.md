# FoodSaver Project

Core project that helps you code faster with clean architecture and other configurations.

## **Build command & config**

### **For Android**

_(will update later)_

### **For iOS**

_(will update later)_

# Architecture Overview

## State Management

The project's state management will be using the lighter version [Bloc](https://bloclibrary.dev/#) called Cubit. Combined with [Clean Achitecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html), this pattern promotes a clear separation of concerns (UI, business logic, data) by making each layer cohesive with one another.

#### The Layers of the Cake

```
                           Data flows in
---------------------------------------------------------------------->
[Data Layer]   <----->   [Business/Domain Layer]   <----->   [UI Layer]

- Data Source            - Use Cases                        - Views
- Repositories           - Repositories                     - Cubits
- Models                 - Entities                         - Models
<----------------------------------------------------------------------
                           Data flows out
```

-   **Data** - Access the information to be used in the app. Sources include local data (databases, caches) or through web services (APIs).
-   **Domain** - Collection of entity objects and related business logic. This layer acts as the glue between where the data is retrieved, and how the data will be presented.
-   **UI** - Concerns how the data will be presented to the user.

# Code Generation

Since Flutter [does not allow the use of reflection](https://github.com/flutter/flutter/issues/1150), we'll use [`build_runner`](https://pub.dev/packages/build_runner) to generate the code for:

-   Dependency injection using [`injectable`](https://pub.dev/packages/injectable)
-   JSON serialization/deserialization using [`json_serializable`](https://pub.dev/packages/json_serializable)

Other uses of `build_runner` are:

-   Asset files using [`flutter_gen`](https://pub.dev/packages/flutter_gen)
-   Localization files using [`intl_utils`](https://pub.dev/packages/intl_utils)

Run the command in the project directory to run the generator once:

```sh
dart run build_runner build
```

or run the generator when necessary every time a file is edited:

```sh
dart run build_runner build watch
```

If there are errors, run this command:

```sh
dart run build_runner build --delete-conflicting-outputs
```

Run this command for generating localization files:

```sh
# Do this once to install intl_utils
flutter pub global activate intl_utils

# Generate files
flutter pub global run intl_utils:generate
```

A sample of a class using [`json_serializable`](https://pub.dev/packages/json_serializable):

```dart
// number_trivia_entity.dart
class NumberTriviaEntity {
  const NumberTriviaEntity({
    required this.text,
    required this.number,
  });
  final String text;
  final int number;
}
```

```dart
// number_trivia_model.dart
import 'package:json_annotation/json_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/features/number_trivia/domain/entities/number_trivia_entity.dart';

part 'number_trivia_model.g.dart';

@JsonSerializable()
class NumberTriviaModel extends NumberTriviaEntity {
  const NumberTriviaModel({required super.text, required super.number});

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) => _$NumberTriviaModelFromJson(json);

  Map<String, dynamic> toJson() => _$NumberTriviaModelToJson(this);
}
```

```dart
// number_trivia_model.dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'number_trivia_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NumberTriviaModel _$NumberTriviaModelFromJson(Map<String, dynamic> json) =>
    NumberTriviaModel(
      text: json['text'] as String,
      number: json['number'] as int,
    );

Map<String, dynamic> _$NumberTriviaModelToJson(NumberTriviaModel instance) =>
    <String, dynamic>{
      'text': instance.text,
      'number': instance.number,
    };

```

## Code Analysis

We use a custom `analysis_options.yaml`. Combined with [flutter_lints](https://pub.dev/packages/flutter_lints) and additional rules, it enforces a strict and type-safe development.

## Code Style

The default line length of the project is `120`, versus Dart's recommended `80`.

### Member ordering

The project uses a customized member ordering, enforced using [Dart Code Metrics](https://dartcodemetrics.dev).

The following order must be observed:

```yaml
- member-ordering-extended:
      alphabetize: false
      order:
          - public-const-fields
          - public-static-final-fields
          - public-static-fields
          - private-static-const-fields
          - private-static-final-fields
          - constructors
          - factory-constructors
          - private-constructors
          - private-final-fields
          - private-late-final-fields
          - private-fields
          - public-final-fields
          - public-late-final-fields
          - public-getters
          - public-getters-setters
          - public-fields
          - protected-public-final-fields
          - protected-public-late-final-fields
          - public-static-methods
          - overridden-public-methods
          - public-methods
          - overridden-protected-methods
          - protected-methods
          - private-methods
          - private-static-methods
```

### Explicit type for public members

Explicitly define the type of public members.

**Don't**

```dart
class MyClass {
  final name = "John Doe";
}
```

**Do**

```dart
class MyClass {
  final String name = "John Doe";
}
```

### Always return `Iterable<T>` rather than `List<T>` if possible

Prefer returning `Iterable<T>` over `List<T>` for immutability of collections. This is also preferred if the returned collection is a constant.

```dart
Iterable<String> foucsAreas() => const ["Angkas 2.0", "Azkalz", "Business POCs"];
```

### Use abstract classes with static-only members

A class with static-only members can be made abstract since it will not be instantiated.

```dart
abstract class MyConstants {
  static final String constant = "constant value";

  static void foo() => print('bar');
}
```

## Code Metrics

As an additional plugin to Dart's analyzer, [Dart Code Metrics](https://dartcodemetrics.dev) improves code quality by checking such as:

-   Anti-patterns
-   Complexity
-   Maintainability
-   Code style
-   Unused code/files

The complete configuration is as follows:

```yml
metrics:
cyclomatic-complexity: 20
maintainability-index: 50
maximum-nesting: 5
number-of-parameters: 5
source-lines-of-code: 50
technical-debt:
    threshold: 1
    todo-cost: 4
    ignore-cost: 8
    ignore-for-file-cost: 16
    as-dynamic-cost: 16
    deprecated-annotations-cost: 2
    file-nullsafety-migration-cost: 2
    unit-type: "hours"
```

Checking is part of the project's CI workflow. The build will fail if Dart's analyzer raises some issues.

[Dart Code Metrics](https://dartcodemetrics.dev)' analysis can be run locally using the following commands:

```sh
flutter pub run dart_code_metrics:metrics analyze lib --fatal-style --fatal-warnings --fatal-performance
flutter pub run dart_code_metrics:metrics check-unused-files lib --fatal-unused
flutter pub run dart_code_metrics:metrics check-unused-code lib --fatal-unused
```

## Dependency Injection

Since Flutter does not support reflection (`dart:mirrors`), the project uses [`injectable`](https://pub.dev/packages/injectable) as our dependency injection and service locator.

### Injectable/GetIt

[get_it](https://pub.dev/packages/get_it) is used as the [IoC](https://stackoverflow.com/questions/3058/what-is-inversion-of-control) container of the project.

[injectable](https://pub.dev/packages/injectable) is used with get_it to generate code for your dependency registrations.

### Registration

Registration is called before running the application, as show here in the main function.

```dart
import 'package:flutter_angkas/dependency_injection.dart';

Future<void> main() async {
  ...
  DependencyInjection.registerDependecies();
  ...
}
```

The class `MyServiceImpl` is annotated with `@LazySingleton`, meaning this class will only be initialized (once and only when needed) when resolving `MyService`.

```dart
import 'package:injectable/injectable.dart';

abstract class MyService{}

@LazySingleton(as: MyService)
class MyServiceImpl implements MyService {}
```
