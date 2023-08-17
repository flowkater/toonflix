import 'package:flutter/material.dart';
import 'package:toonflix/app.dart';

void main() {
  runApp(const App());
}

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Scaffold(
//         backgroundColor: Color(0xFF181818),
//         body: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: 20,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 80,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         'Hey, Selena',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 28,
//                           fontWeight: FontWeight.w800,
//                         ),
//                       ),
//                       Text(
//                         'Welcome back',
//                         style: TextStyle(
//                           color: Color.fromRGBO(255, 255, 255, 0.8),
//                           fontSize: 18,
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//               Text(
//                 'Total Balance',
//                 style: TextStyle(
//                   fontSize: 22,
//                   color: Color.fromRGBO(255, 255, 255, 0.8),
//                 ),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               Text(
//                 '\$5 194 482',
//                 style: TextStyle(
//                   fontSize: 48,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Button(
//                     text: 'Transfer',
//                     bgColor: Colors.amber,
//                     textColor: Colors.black,
//                   ),
//                   Button(
//                     text: 'Request',
//                     bgColor: Colors.grey,
//                     textColor: Colors.white,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
