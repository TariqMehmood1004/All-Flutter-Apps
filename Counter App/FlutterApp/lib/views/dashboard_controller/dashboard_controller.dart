import 'dart:async';
import 'package:flutter/material.dart';
import 'package:list_view_project/views/colors/colors_controller.dart';
import 'package:list_view_project/views/second_controller/second_controller.dart';
import 'package:list_view_project/widgets/counter_controller.dart';

/*
  DASHBOARD Widget
  # it's constructor required the title of dashboard as a parameter.
*/

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.title});

  final String title;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  /*
    LOCAL VARIABLES
      # maintain the whole functioanlies of incrementation, decrementation as well.
  */
  int increment = 0;
  int increment2 = 0;
  int decrement = 0;
  int temp = 0;
  int resetTemp = 0;
  int saves = 0;
  int addNumber = 0;
  bool isAddPress = false;

  /*
    # user-defined string type method; showSnackBar();
    # get the inputs from the user as a string;
      that input will put the message as a form of snackbar poppup.
  */
  void showSnackBar({String msg = "message"}) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 20,
        elevation: 0, // used for transparent/ remove bottom shadow.
        backgroundColor: AppColors.amberorange,
        // backgroundColor: AppColors.blackBackColor,
        title: SizedBox(
          child: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    /*
                      showModalBottomSheet() widget for clicking of doc icon/img
                      to show the image of documentation
                      # get two properties:
                        1.  context: from parent
                        2.  builder: returns the image of documentation
                    */
                    showModalBottomSheet(
                      backgroundColor: AppColors.transparent,
                      barrierColor: AppColors.transamberorange,
                      context: context,
                      builder: (context) => const Image(
                        // showing the documentation of class task.
                        image: AssetImage('images/task.png'),
                      ),
                    );
                  },
                  child: const Image(
                    width: 20,
                    height: 20,
                    // color: AppColors.transparent,
                    image: AssetImage('images/docs2.png'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: AppColors.amberorange,
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 0),
            // color: Colors.amber,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  //incremetation container
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    /*
                      CounterWidgetController() user-defined widget 
                      => get number, textColor, fontSize, and fontWeight as a parameters
                    */
                    child: CounterWidgetController(
                      number: temp,
                      textColor: AppColors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  //2nd container | decrementation
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CounterWidgetController(
                        number: decrement,
                        textColor: AppColors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.w500),
                  ),
                  //3rd container
                ],
              ),
            ),
          ),
        ),
      ),
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
                # FloatingActionButton() reurns onPressed feature to decrementing the counter
                  by one clicking
              */
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    saves--;
                    decrement = saves--;
                    decrement--;
                    if (decrement < 0 && saves < 0) {
                      decrement = 0;
                      saves = 0;

                      showSnackBar(msg: "You cannot decrement less than zero.");
                    } else {
                      showSnackBar(msg: "Decrementation");
                    }
                  });
                },
                heroTag: "minus",
                backgroundColor: AppColors.transamberorange,
                foregroundColor: AppColors.white,
                child: const Text(
                  "-",
                  style: TextStyle(fontSize: 35),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              /*
                # FloatingActionButton() reurns onPressed feature to incrementing the counter
                  by one clicking
              */
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    // n++;
                    temp = increment++;
                    saves = temp;
                    saves++;

                    showSnackBar(msg: "Incrementation");
                  });
                },
                heroTag: "add",
                backgroundColor: AppColors.transamberorange,
                foregroundColor: AppColors.white,
                child: const Icon(Icons.add),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              /*
                # FloatingActionButton() reurns onPressed feature to reset the counter
                  by one clicking
              */
              child: FloatingActionButton(
                onPressed: () {
                  // temp = 0;
                  resetTemp = temp;
                  setState(() {
                    temp = 0;
                    decrement = 0;
                    increment = 0;
                    increment2 = 0;
                    showSnackBar(msg: "Reseted counters.");
                  });
                },
                heroTag: "Reset",
                backgroundColor: AppColors.transamberorange,
                foregroundColor: AppColors.white,
                child: const Icon(Icons.refresh),
              ),
            ),
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: AppColors.blackBackColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: TextButton(
                /*
                # TextButton() reurns onPressed feature to poppup the showModalBottomSheet for counters
                  by one clicking
              */
                onPressed: () {
                  Future.delayed(const Duration(milliseconds: 15), () {
                    showModalBottomSheet(
                      backgroundColor: AppColors.transparent,
                      barrierColor: AppColors.amberorange,
                      context: context,
                      builder: (context) => Container(
                        width: MediaQuery.of(context).size.width,
                        height: 900,
                        color: AppColors.transparent,
                        child: const CounterAppManager(),
                      ),
                    );
                  });
                },
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
