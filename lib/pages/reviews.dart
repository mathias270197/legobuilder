// import 'package:flutter/material.dart';

// class Reviews extends StatelessWidget {
//   const Reviews({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Title in App Bar"),
//       ),
//       body: const Material(
//         color: Colors.deepPurple,
//         child: Center(
//           child: Text(
//             "Hello Flutter!",
//             textDirection: TextDirection.ltr,
//             style: TextStyle(color: Colors.white, fontSize: 36.0),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reviews"),
      ),
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: const Text("Reviewlist"),
      ),
    );
  }
}
