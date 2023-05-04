# TABLE GENERATOR APP IN FLUTTER


https://user-images.githubusercontent.com/116074810/234759845-ac6070df-6bd7-4ff7-ab91-4dae4ea98b50.mp4


A new Flutter project.

## Getting Started


### Main Function
<pre>
  import 'package:flutter/material.dart';

import 'Areas/Views/views.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyViewsRoutes.splashScreenController,
    );
  }
}

</pre>

<span>
  This is a Dart code written using the Flutter framework. It includes importing libraries, defining a main function and a StatelessWidget class called MyApp.

The import statement is used to bring in libraries and modules from other files. In this case, it's importing flutter/material.dart and a custom file Areas/Views/views.dart.

The void main() function is the entry point of the Dart program, which is where the execution of the app begins. In this code, it calls the runApp() function, passing an instance of MyApp().

The MyApp class is a StatelessWidget, which means it won't change during the lifetime of the app. It has a single build method that returns a MaterialApp widget, which is the root widget of a Flutter app. The MaterialApp widget sets up a default Material Design theme and passes debugShowCheckedModeBanner and primarySwatch parameters to customize the app's theme. The home parameter is set to MyViewsRoutes.splashScreenController, which is an instance of a custom widget class defined in the imported Areas/Views/views.dart file.
</span>


## Utilities
### 1. Methods
#### 1. System Chrome Taskbar Color
<pre>
  import 'package:flutter/services.dart';

// ignore: avoid_types_as_parameter_names
systemChromeStatusBarColor(Color color) => SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: color,
      ),
    );
</pre>

<span>
  This is a Dart function that sets the color of the system status bar in a Flutter app. It imports the flutter/services.dart library, which provides access to the device's native platform services.

The function is named systemChromeStatusBarColor and takes a single parameter of type Color. It uses the SystemChrome class to set the system UI overlay style to customize the appearance of the status bar.

Inside the function, it creates a new instance of SystemUiOverlayStyle and passes a statusBarColor parameter that's set to the passed-in color value. This sets the background color of the status bar to the specified color.

The ignore: avoid_types_as_parameter_names comment is a lint rule that's ignored in this code. This rule suggests using camel case naming convention for function parameters. However, the function parameter name is written in Pascal case (Color), which is not recommended in Dart.
</span>  



#### 2. Timer Navigation
<pre>
import 'dart:async';
import 'package:flutter/material.dart';
import '../../Areas/Views/views.dart';

timerForNavigation(BuildContext context, {int seconds = 0}) => Timer(
      Duration(seconds: seconds),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyViewsRoutes.dashboardController,
          ),
        );
      },
    );


timerForGenerateTableControllerNavigation(BuildContext context, {int seconds = 0}) => Timer(
      Duration(seconds: seconds),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyViewsRoutes.dashboardController,
          ),
        );
      },
    );
</pre>

<span>
  These are two Dart functions that use the `dart:async` library to create timers that trigger navigation to different screens in a Flutter app. They also import a custom file `../../Areas/Views/views.dart`.

The first function is named `timerForNavigation` and takes two parameters: `context` of type `BuildContext` and an optional named parameter `seconds` of type `int` with a default value of `0`. It creates a timer that waits for the specified number of seconds and then navigates to the dashboard screen. 

Inside the function, it calls the `Timer` constructor with a `Duration` object that's set to the specified number of seconds. The timer then triggers the callback function that navigates to the dashboard screen using the `Navigator.pushReplacement` method, which replaces the current screen with the dashboard screen. It also uses `MaterialPageRoute` to specify the builder function that returns an instance of `MyViewsRoutes.dashboardController` from the imported file.

The second function is named `timerForGenerateTableControllerNavigation` and has the same functionality as the first function, except it navigates to a different screen (`MyViewsRoutes.generateTableController`) instead of the dashboard screen. 

Overall, these functions provide a simple way to delay screen navigation and replace the current screen with a new one after a specified amount of time.
</span>


### 2. Utilis
#### Colors class
<pre>
import 'package:flutter/material.dart';

class AppColors {
  static Color white = const Color(0xffFFFFFF);

  static Color transparent = const Color.fromARGB(0, 255, 255, 255);
  static Color backgroundLight = const Color(0xffffffff);

  static Color blueLight = const Color(0xff733aef);

  static Color chocolateColor = const Color(0xff1c0613);

  static Color highChocolateColor = const Color(0xff0a0c0b);
  static Color greenColor = const Color(0xff3c495a);
  static Color greyColor = const Color(0xff261725);

  static Color reddish = const Color(0xff140309);
  static Color yellowOff = const Color(0xffe89457);
  static Color offWhite = const Color(0xffa8acab);

  static Color goldGrain = const Color(0xffb97e43);
  static Color orange = const Color(0xffefb13e);
  static Color darkBlue = const Color(0xff0ebcee);

  static Color prettyBlue = const Color(0xff002c53);
  static Color prettyOrange = const Color(0xffa9671f);

  static Color backgroundLightGrey = const Color(0xfff2f3f4);
  static Color black = const Color(0xff070508);

  static Color backgroundDark = const Color(0xFF000000);
  static Color backgroundDarkTransparented = const Color(0xB8000000);
  static Color iconTint = const Color(0xff888787);

  static Color navigationSelectionColor = const Color(0xffffc107);
  static Color cardBGColor = const Color(0xfffbfbfb);

  static Color blueBlack = const Color(0xFF060D1D);
  static Color blueBlackOff = const Color(0xDF09142D);

  static Color blackTransparent = const Color.fromARGB(206, 0, 0, 0);
  static Color pink = const Color(0xFFDBD4FA);

  static Color colorBox1 = const Color(0xFF2A2738);

  static Color palleteColor = const Color(0xFF4a021a);
  static Color palleteColor1 = const Color(0xFF260615);

  static Color colorBox2 = const Color(0xFFf3f4f9);
}

</pre>

<span>
  This is a Dart class named `AppColors` that defines a set of static color constants that can be used throughout a Flutter app. 

Each color is defined as a static field of the class with a descriptive name and a value specified using the `Color` class. Some colors are defined using the `const Color` constructor, which creates a compile-time constant, while others use the `Color` constructor, which creates a non-constant color object. 

The class includes a variety of colors such as white, black, blue, green, orange, yellow, grey, and transparent colors. There are also some colors with specific names such as `backgroundLight`, `backgroundDark`, `navigationSelectionColor`, `cardBGColor`, and `palleteColor`.

These colors can be used to style various UI elements in the app, such as text, backgrounds, borders, icons, and buttons. By defining these colors in a central location, it makes it easier to maintain a consistent visual design throughout the app.
</span>


### set the timer for dashboard in constant dart file
<pre>
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:table_generator_app/Areas/Views/views.dart';

setTimer({int seconds = 0}) => Timer(
      Duration(seconds: seconds),
      () {
        MaterialPageRoute(
          builder: (_) => MyViewsRoutes.dashboardController,
        );
      },
    );
</pre>


## Controllers
### 1. Dashboard Controller
The code seems to be a Flutter app that generates tables. The `DashboardController` is a `StatefulWidget` with a `_DashboardControllerState` state class that builds the UI. 

The UI has three slider widgets, the first one is for selecting the table number, the second one is for selecting the starting table, and the third one is for selecting the ending table. When the "Generate Table" button is tapped, a table generation page is shown. 

The `AudioCache` class is used to play an audio file of a musical note when the button is tapped, and the `Timer` class is used to add a delay of 250 milliseconds before navigating to the table generation page. 

The code uses the `audioplayers` package to play the audio file, and the `MaterialApp`, `Scaffold`, `SafeArea`, `Column`, `InkWell`, and `Container` widgets to build the UI. The UI also uses a custom `mySliderWidget` and `mySliderWidgetForStartingTable` widget to build the slider widgets.


### 2. Generate the table controller
This is a Flutter StatefulWidget that displays a multiplication table based on the given parameters (tableNumber, startingNumber, and endingNumber). The multiplication table is displayed as a list of rows, where each row contains a multiplication equation (i.e., tableNumber * i = result).

The widget also includes a floating action button that allows the user to navigate to a quiz screen, where they can test their knowledge of the multiplication table.

The widget imports several libraries, including dart:async, dart:math, and the audioplayers package. It also imports two custom classes: Controllers.dart and colors.dart.

The widget renders a Scaffold that contains a SafeArea with a SingleChildScrollView that allows the user to scroll the multiplication table if it overflows the screen. The multiplication table is displayed as a Column that contains a header row (displaying the tableNumber), followed by a list of rows (each displaying a multiplication equation).

The floating action button is displayed at the bottom of the screen and contains two buttons: one that navigates back to the previous screen (using Navigator.of(context).pop()) and another that navigates to the quiz screen (using Navigator.push()). The buttons also play a sound effect when tapped (using the AudioCache class from the audioplayers package).

Overall, this widget is a simple but useful tool for teaching and practicing multiplication tables, and the inclusion of the quiz feature adds an interactive and engaging element to the learning experience.


### 3. Random table questions controller
This is a Flutter code that generates random multiplication questions based on the `tableNumber`, `startingNumber`, and `endingNumber` provided. The user is given 3 answer options, and they have to select the correct one.

Here is a brief overview of the classes and methods used in this code:

- `RandomQuestionsGenerator`: This is a stateful widget that takes in three required parameters (`tableNumber`, `startingNumber`, and `endingNumber`) and generates a random multiplication question based on these parameters. It also contains the state that manages the correctness of the user's selected answer.

- `_RandomQuestionsGeneratorState`: This is the state class for `RandomQuestionsGenerator` that manages the state of the widget.

- `initState()`: This is a method that gets called once when the widget is first created. In this code, it sets the `tableN` to the value of `widget.tableNumber`, sets the `maxValue` to the value of `widget.endingNumber`, and sets the `randomValues` to a random value between 1 and `maxValue`.

- `build()`: This method returns the UI for the widget. It contains a `Column` that displays the generated question and the answer options.

- `onTap`: This is a callback method that gets called when the user taps on one of the answer options. It checks whether the selected answer is correct or not and displays a message accordingly.

- `ShowDialogBox`: This is a custom method that displays a dialog box with a message. It takes in three parameters (`context`, `title`, and `message`) and displays them in the dialog box. It uses the `showDialog()` method provided by Flutter to display the dialog box.

Overall, this code is a simple implementation of a random multiplication question generator in Flutter. It demonstrates the use of stateful widgets and basic UI design principles in Flutter.

This appears to be a Flutter code snippet for a floating action button with two buttons that navigate to different screens when pressed. The first button navigates back to the dashboard and the second button generates a random question for a quiz.

The floatingActionButton widget is used to create the button, and it is wrapped in a Column widget with a single child, which is a Container widget that contains the two buttons. The first button is wrapped in an InkWell widget, which provides a visual feedback when the button is pressed, and the second button is wrapped in another InkWell widget.

When the first button is pressed, a debug message is printed to the console, a random note is played using the AudioCache plugin, and a Timer is started to navigate to the dashboard screen after a delay of 250 milliseconds. When the second button is pressed, a similar set of actions occur, except that the user is navigated to a screen that generates a random question for a quiz.

The ShowDialogBox function is defined but not used in this code snippet. It appears to create a custom dialog box with a title and description. The function takes two arguments, the context in which the dialog box is displayed and the title and description strings to be displayed in the dialog box.


### index.dart file for exporting the controllers
<pre>
library dashboard_controller;

export '../Controllers/dashboard_controller/dashboard.dart';
export '../Controllers/generate_table/generate_table.dart';
export '../Controllers/random_question/random_question.dart';
</pre>
This code seems to be exporting three files from the "dashboard_controller" library: "dashboard.dart", "generate_table.dart", and "random_question.dart". 

By using the "export" keyword, these files can be used by other files that import this library. When another file imports this library, it will be able to access the public components of the exported files, including classes, functions, and variables.

