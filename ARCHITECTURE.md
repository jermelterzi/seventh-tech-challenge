# Architecture Documentation

This project is a mono repository using Clean Architecture with multiple features.

## Objective

The main objective of this document's to guide the software development of this application.

## Architectures rules

Before implement new features, some points have to be validated:

- The project must have a minimal test cover of 70%

- Global layers must be at "core" folder

- Each feature must have your particular folder with all the layers necessary

- All the Design Patterns used at the project must be listed at "Design Patterns" section of this document

- It's not allowed concrete classes dependency for a layer

- Packages should be validated before to include to project

- Each layer must have one responsibility

## Design Patterns

- Dependency Injection

- Repository Pattern

- BLoC

- Mock

- Adapter

## Entities

- User

  User entity is used to login in app.

  Attributes:

  id: String
  email: String
  password: String

- Video

  Video entity represents the video what gonna be played by the application.
  
  Attributes:

  id: String
  url: String

## Use cases

- Authentication

  - Login

    This use case is called when the user wants to login and return a Unit when everything works and a Failure when something don't work in the process.

- Video

  - Get video

    This use case is called when the user completes the login and have a multiple when everything works returns a String, which represents the url of the video what gonna be played, and when something don't work in the process returns a Failure class.

## Packages

The packages of this project and for what it using them:

- get_it

  Dependency injection.

- http
  
  HTTP Client.

- either_dart

  Multiple returns.

- mocktail
  
  Create fake classes to unit tests.

- shared_preferences

 Save locally the user's token.

- video_player
  
  Video player.

- flutter_bloc
  
  State management.

- bloc_test

  Bloc tests.

- flutterando_analysis

  Linter.
