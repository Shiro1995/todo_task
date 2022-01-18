# Todo task App

This is a simple repository, that helps create to-do tasks. Using MultiBlocProvider to manage state and equatable package to simplify coding style. Save data locally by SQFLite.


## How To Use?

After cloning the project, get all package flutter by running the command above at terminal:
```
  flutter pub get
```
Then run the program with your simulator or real device. Noticed that all your version of the package need to be the same with **dependencies** below


## Testing
My testing in this project is not functioning as expected because since Dart release the new version. There are many issues with testing, especially with bloc test, you can follow these links:

https://stackoverflow.com/questions/67371802/dart-type-null-is-not-a-subtype-of-type-futurestring-in-mockito

https://github.com/dart-lang/mockito/issues

I will update next time if there is some solution for this.

**Run tests using VSCode**

The Flutter plugins for VSCode support running tests. This is often the best option while writing tests because it provides the fastest feedback loop as well as the ability to set breakpoints
```
    Open the counter_test.dart file
    Select the Run menu
    Click the Start Debugging option
    Alternatively, use the appropriate keyboard shortcut for your platform.
```

## What's in this app.

- [x] List of completed, uncompleted tasks.
- [x] Create new task, and delete all tasks.
- [x] Save todo tasks into local storage.

## ScreenShot
![alt](https://i.imgur.com/b2o355w.png)
![alt](https://i.imgur.com/epdX2nD.png)
![alt](https://i.imgur.com/lDZZUET.png)

## Current dependencies added at *pubspec.yaml*:

```
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  flutter_bloc: ^8.0.1
  equatable: ^2.0.3
  sqflite: ^2.0.2
  get_it: ^7.2.0
  bloc_test: ^9.0.2
  mockito: ^5.0.17
  test: ^1.17.12

```
## Thank you
