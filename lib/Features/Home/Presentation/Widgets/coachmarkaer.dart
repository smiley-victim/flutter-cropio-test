// import 'package:flutter/material.dart';
// import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

// class Coachmarkaer {
//   late TutorialCoachMark tutorialCoachMark;
//   void start( List<GlobalKey<State<StatefulWidget>>>? targets,BuildContext ctx) {
//     tutorialCoachMark = TutorialCoachMark(
//       targets: _createTargets(targets),
//       colorShadow: const Color.fromARGB(255, 14, 122, 28),
//       textSkip: "SKIP",
//       paddingFocus: 10,
//       opacityShadow: 0.5,
//       onFinish: () {
//         /// these are for the debugging purpose
//         debugPrint("finish");
//       },
//       onClickTarget: (target) {
//         debugPrint('onClickTarget: $target');
//       },
//       onClickTargetWithTapPosition: (target, tapDetails) {
//         debugPrint("target: $target");
//         debugPrint(
//             "clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
//       },
//       onClickOverlay: (target) {
//         debugPrint('onClickOverlay: $target');
//       },
//       onSkip: () {
//         debugPrint("skip");
//         return true;
//       },
//     );

//     tutorialCoachMark.show(context: ctx);
//   }

//   List<TargetFocus> _createTargets(
//       List<GlobalKey<State<StatefulWidget>>>? focus) {
//     List<TargetFocus> targets = [];
//     targets.add(
//       TargetFocus(
//         identify: "keyBottomNavigation1",
//         keyTarget: focus?[0],
//         alignSkip: Alignment.topRight,
//         enableOverlayTab: true,
//         contents: [
//           TargetContent(
//             align: ContentAlign.top,
//             builder: (context, controller) {
//               return Container(
//                 child: const Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       "Titulo lorem ipsum",
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//     return targets;
//   }



// }
