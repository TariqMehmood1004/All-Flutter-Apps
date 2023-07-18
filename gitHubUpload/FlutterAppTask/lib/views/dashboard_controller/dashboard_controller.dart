import 'package:flutter/material.dart';
import 'package:list_view_project/views/colors/colors_controller.dart';
import 'package:list_view_project/widgets/counter_controller.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.title});

  final String title;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int increment = 0;
  int increment2 = 0;
  int decrement = 0;
  int temp = 0;
  int resetTemp = 0;
  int saves = 0;

  int addNumber = 0;
  bool isAddPress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 20,
        elevation: 0,
        backgroundColor: AppColors.amberorange,
        title: SizedBox(
          child: TextButton(
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: AppColors.transparent,
                barrierColor: AppColors.transparent,
                context: context,
                builder: (context) => const Image(
                  // height: 200,
                  image: AssetImage('images/task.png'),
                ),
              );
            },
            child: Text(
              'Documentation?',
              style: TextStyle(color: AppColors.darkopacity, fontSize: 8),
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
            margin: const EdgeInsets.only(top: 0),
            // color: Colors.amber,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  //incremetation container
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CounterWidgetController(
                      number: temp,
                      textColor: AppColors.amberorange,
                      fontSize: 38,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  //2nd container | decrementation
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CounterWidgetController(
                        number: decrement,
                        textColor: AppColors.amberorange,
                        fontSize: 38,
                        fontWeight: FontWeight.w500),
                  ),
                  //3rd container
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CounterWidgetController(
                        number: resetTemp,
                        textColor: AppColors.amberorange,
                        fontSize: 38,
                        fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CounterWidgetController(
                        number: increment2,
                        textColor: AppColors.amberorange,
                        fontSize: 38,
                        fontWeight: FontWeight.w500),
                  ),
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
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    saves--;
                    decrement = saves--;
                    decrement--;
                    if (decrement < 0 && saves < 0) {
                      decrement = 0;
                      saves = 0;

                      //snackbar for less than zero error
                      final snackBar = SnackBar(
                        content: const Text(
                            'Sorry! You can\'t decrement less than zero.'),
                        action: SnackBarAction(
                          label: 'Ok',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      final snackBar = SnackBar(
                        content: const Text('Yay! Decrementation'),
                        action: SnackBarAction(
                          label: 'Ok',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  });
                },
                heroTag: "minus",
                backgroundColor: AppColors.white,
                splashColor: AppColors.vivacious,
                foregroundColor: Colors.black,
                child: const Text(
                  "-",
                  style: TextStyle(fontSize: 35),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: FloatingActionButton(
                heroTag: "add",
                onPressed: () {
                  setState(() {
                    // n++;
                    temp = increment++;
                    saves = temp;
                    saves++;

                    final snackBar = SnackBar(
                      content: const Text('Yay! Incrementation'),
                      action: SnackBarAction(
                        label: 'Ok',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                },
                backgroundColor: AppColors.white,
                splashColor: AppColors.vivacious,
                foregroundColor: Colors.black,
                child: const Icon(Icons.add),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: FloatingActionButton(
                onPressed: () {
                  // temp = 0;
                  resetTemp = temp;
                  setState(() {
                    temp = 0;
                    decrement = 0;
                    increment = 0;
                    increment2 = 0;
                    final snackBar = SnackBar(
                      content: const Text('Yay! Reset'),
                      action: SnackBarAction(
                        label: 'Ok',
                        onPressed: () {
                          // Some code to undo the change.
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                },
                heroTag: "Reset",
                backgroundColor: AppColors.blackBackColor,
                splashColor: AppColors.blackopacity,
                foregroundColor: Colors.white,
                child: const Icon(Icons.refresh),
              ),
            ),

            //add multiple counters
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: FloatingActionButton(
                onPressed: () {
                  //code body
                  setState(() {
                    increment2++;
                  });
                },
                heroTag: "addMoreCounter",
                backgroundColor: AppColors.blackBackColor,
                splashColor: AppColors.blackopacity,
                foregroundColor: Colors.white,
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
