// // ignore_for_file: library_private_types_in_public_api, prefer_const_constructors
//
// import 'package:flutter/material.dart';
// import 'package:weigh_estimation_app/colors/colors.dart';
// import 'package:weigh_estimation_app/widgets/my_textfields.dart';
//
// class MeasurementConverter extends StatefulWidget {
//   const MeasurementConverter({Key? key}) : super(key: key);
//
//   @override
//   _MeasurementConverterState createState() => _MeasurementConverterState();
// }
//
// class _MeasurementConverterState extends State<MeasurementConverter> {
//   String selectedOption = 'cm';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           if (selectedOption == 'cm') ...[
//             MyTextFields1(cmController: null,),
//           ] else ...[
//             MyTextFields2(),
//           ],
//
//           Container(
//             width: MediaQuery.of(context).size.width * 0.36,
//             decoration: BoxDecoration(
//               color: Colors.grey.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//
//                 buildOption('cm'),
//                 buildOption('ft & in'),
//               ],
//             ),
//           ),
//
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
//
//
//   Widget buildOption(String option) {
//     final bool isSelected = selectedOption == option;
//
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedOption = option;
//         });
//       },
//       child: Container(
//         margin: const EdgeInsets.all(4),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         decoration: BoxDecoration(
//           color: isSelected ? AppColors.light : Colors.transparent,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Text(
//           option,
//           style: TextStyle(
//             color: isSelected ? AppColors.black : AppColors.primary,
//             fontSize: 12,
//             fontWeight: FontWeight.bold,
//             fontFamily: "Roboto",
//           ),
//         ),
//       ),
//     );
//   }
// }
