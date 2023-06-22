import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';
import '../provider.dart';

class Display extends StatefulWidget {
  const Display({super.key});

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  @override
  Widget build(BuildContext context) {
    Dataflow flow = context.watch<Dataflow>();

    return Scaffold(
      appBar: AppBar(
        title: Text(flow.data[flow.view].name),
      ),
    );
  }
}

// class Display extends StatelessWidget{
//   const Display({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Dataflow flow = context.watch<Dataflow>();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(flow.data[flow.view].name),
//       ),

//       body: Padding(
//         padding: const EdgeInsets.all(28.0),
//         child: Column(
//           children: [
//             Image(
//               image: NetworkImage(flow.data[flow.view].image),
//               height: 300,
//               width: 300,
//             ),
            
//             const SizedBox(
//               height: 50,
//             ),
            
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Text(flow.data[flow.view].instructions,
//                   style: const TextStyle(
//                     fontSize: 18
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

// } 