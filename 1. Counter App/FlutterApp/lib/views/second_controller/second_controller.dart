import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:list_view_project/views/colors/colors_controller.dart';

/*
  # CounterAppManager() widget
  # this widget controlls following method/ widgets
  -> imported Libraries:  
     => 'package:flutter/services.dart'; 
          [used for status bar background color or transparent]
     => 'package:list_view_project/views/colors/colors_controller.dart';
          [this a user defined class for controlling the mechanism of app colors]
*/
class CounterAppManager extends StatelessWidget {
  const CounterAppManager({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner:
          false, // use for hiding the debug banner in the app.
      home: CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  /*
    # initState() method - used for transparent the status bar in the app.
    # SystemChrome class provides the concept of status bar background settings [coloring]
  */
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
  }

  /*
    # int type list - used for adding the counters widgets by using the clicking events
  */
  final List<int> _counters = [0];

  /*
    # user-defined string type method; showSnackBar();
    # get the inputs from the user as a string;
      that input will put the message as a form of snackbar poppup.
  */
  void showSnackBar(String msg) {
    final snackBar = SnackBar(
      backgroundColor: AppColors.vivacious,
      content: Text('Yay! ${msg.toString()}'),
      action: SnackBarAction(
        label: 'Ok',
        textColor: AppColors.white,
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /*
    # int return type _incrementCounter() method;
      get the index from the user and added that index into the list,
      then calling showSnackbar() method to show the incrementation.
      => if condition controlls the counter list with index representing greater than 0;
      => if the index of a counter list is greater than 0;
        then incremented the values.
  */
  void _incrementCounter(int index) {
    setState(() {
      if (_counters[index] > 0) {
        _counters[index]++;
      }
      _counters[index]++;
      showSnackBar("Incrementations");
    });
  }

  /*
    # int return type _decrementCounter() method;
      get the index from the user and removed that index from the list,
      then calling showSnackbar() method to show the decrementation.
      => if condition controlls the counter list with index representing less than 0;
      => if the index of a counter list is less than 0;
        then decremented the values.
  */

  void _decrementCounter(int index) {
    setState(() {
      _counters[index]--;
      if (_counters[index] < 0) {
        _counters[index] = 0;
      }
      showSnackBar("Decrementations");
    });
  }

/*
    # _addCounter() method;
      => this method will provide or adding
        the widgets of counter by presing click event.
  */
  void _addCounter() {
    setState(() {
      _counters.add(0);
      showSnackBar("Added one more counter widget.");
    });
  }

  /*
    # _removeCounter() method;
      => if the counter widget is added into the app,
      this method will work properly to remove that widgets.
  */
  void _removeCounter() {
    setState(() {
      if (_counters.remove(0)) {
        showSnackBar("Deleted counter widget.");
      } else {
        showSnackBar("There is no any other counter to delete that.");
      }
    });
  }

  /*
    # _resetCounter() method;
    => this method provide us the functionality of reseting (set to zero) 
        all the counter widgets by one click of event.
    => when all the widgets has been reseted, then snakbar show the poppup of reseted widgets.
  */
  void _resetCounter() {
    setState(() {
      for (var i = 0; i < _counters.length; i++) {
        _counters[i] = 0;
      }
      showSnackBar("You have reseted all the counters.");
    });
  }

  /*
    # _singleWidgetResetCounter() method;
    as we estimating the name;
    it will reset the single counter widget. 
  */
  void _singleWidgetResetCounter(int index) {
    setState(() {
      _counters[index] = 0;
      showSnackBar("You reseted the counter.");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.amberorange,
      /*
        # ListView.builder() widget; used for listed all the counters in a manner of list.
        # it return two properties/values: 
          1.  itemCount: give the total length of list
          2.  itemBuilder() returns Container (returns listTile) widgets. 
              and also get two params [context and index]
        # 
      */
      body: ListView.builder(
        itemCount: _counters.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 0),
            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.transamberorange,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 0.5,
                  color: AppColors.vivacious,
                ),
              ],
            ),
            child: ListTile(
              subtitle: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 45,
                  height: 45,
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.vivacious2,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    // passing the index if list in the text widget.
                    '${_counters[index]}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackBackColor),
                  ),
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /*
                    # InkWell() widget is providing us the features of ontap/press event
                    # ontap returns _incrementCounter() method with index from the 
                      itemBuilder parameter
                    # this widget has been used for incrementation of counters with indexes
                  */
                  InkWell(
                    onTap: () {
                      _incrementCounter(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.circularBtnBackColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.add,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),

                  /*
                    # InkWell() widget is providing us the features of ontap/press event
                    # ontap returns _decrementCounter() method with index from the 
                      itemBuilder parameter
                    # this widget has been used for decrementation of counters with indexes
                  */
                  InkWell(
                    onTap: () {
                      _decrementCounter(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.circularBtnBackColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.remove,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),

                  /*
                    # InkWell() widget is providing us the features of ontap/press event
                    # ontap returns _singleWidgetResetCounter() method with index wise reseting the values
                    # this widget has been used for singleton reseting counters with indexes
                  */
                  InkWell(
                    onTap: () {
                      _singleWidgetResetCounter(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.circularBtnBackColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.restore,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      /*
        # floatingActionButton() constructor is a circular button that triggers the 
          primary action in your app's UI
        # Using the row widget for buttons to aligned in the same row for all buttons.
      */
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        // margin: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              /*
                # FloatingActionButton() reurns onPressed feature to reset the all counters
                  by one clicking
              */
              child: FloatingActionButton(
                backgroundColor: AppColors.transamberorange,
                splashColor: AppColors.vivacious,
                foregroundColor: Colors.white,
                onPressed: _resetCounter,
                child: const Icon(
                  Icons.refresh,
                  size: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              /*
                # FloatingActionButton() reurns onPressed feature to remove all counters
                  by one by one clicking of events
              */
              child: FloatingActionButton(
                backgroundColor: AppColors.transamberorange,
                splashColor: AppColors.vivacious,
                foregroundColor: Colors.white,
                onPressed: _removeCounter,
                child: const Icon(
                  Icons.delete,
                  size: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              /*
                # FloatingActionButton() reurns onPressed feature to adding all the counters
                  by one by one clicking
              */
              child: FloatingActionButton(
                backgroundColor: AppColors.vivacious,
                splashColor: AppColors.vivacious,
                foregroundColor: Colors.white,
                onPressed: _addCounter,
                child: const Icon(Icons.add_circle_outline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
