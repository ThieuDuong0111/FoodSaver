// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
// import 'package:funix_thieudvfx_foodsaver/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
// import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

// class NumberTriviaPage extends StatelessWidget {
//   const NumberTriviaPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<NumberTriviaBloc>(
//       create: (context) => DependencyInjection.instance(),
//       child: const NumberTriviaWrapper(),
//     );
//   }
// }

// class NumberTriviaWrapper extends StatefulWidget {
//   const NumberTriviaWrapper({super.key});

//   @override
//   State<NumberTriviaWrapper> createState() => _NumberTriviaWrapperState();
// }

// class _NumberTriviaWrapperState extends State<NumberTriviaWrapper> {
//   late final TextEditingController controller;
//   @override
//   void initState() {
//     controller = TextEditingController();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.primaryBrand,
//         title: const Text('Mio Number Trivia'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(10.w),
//         child: Column(
//           children: <Widget>[
//             SizedBox(height: 50.h),
//             Container(
//               height: 200.h,
//               padding: EdgeInsets.symmetric(horizontal: 20.w),
//               child: Center(
//                 child: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
//                   builder: (context, state) {
//                     if (state is NumberTriviaLoadingState) {
//                       return const Text(
//                         'Loading...',
//                         style: TextStyle(fontSize: 20),
//                         textAlign: TextAlign.center,
//                       );
//                     } else if (state is NumberTriviaErrorState) {
//                       return Text(
//                         state.error.toString(),
//                         style: const TextStyle(fontSize: 20),
//                       );
//                     } else if (state is NumberTriviaFinishedState) {
//                       return SingleChildScrollView(
//                         child: Column(
//                           children: [
//                             Text(
//                               state.numberTriviaEntity.number.toString(),
//                               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                               textAlign: TextAlign.center,
//                             ),
//                             SizedBox(height: 10.h),
//                             Text(
//                               state.numberTriviaEntity.text,
//                               style: const TextStyle(fontSize: 20),
//                               textAlign: TextAlign.center,
//                             ),
//                           ],
//                         ),
//                       );
//                     } else {
//                       return const SizedBox();
//                     }
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(height: 10.h),
//             Column(
//               children: <Widget>[
//                 TextField(
//                   controller: controller,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     fillColor: Colors.white,
//                     border: const OutlineInputBorder(),
//                     hintText: 'Input a number',
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(16.r),
//                       borderSide: BorderSide(
//                         color: AppColors.primaryBrand.withOpacity(0.3),
//                         width: 2.w,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(16.r),
//                       borderSide: BorderSide(
//                         color: AppColors.primaryBrand,
//                         width: 2.w,
//                       ),
//                     ),
//                   ),
//                   onSubmitted: (_) => dispatchConcrete(),
//                 ),
//                 const SizedBox(height: 10),
//                 Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           fixedSize: Size(double.infinity, 35.h),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16.r),
//                           ),
//                           backgroundColor: AppColors.primaryBrand,
//                         ),
//                         onPressed: dispatchConcrete,
//                         child: const Text('Search'),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           fixedSize: Size(double.infinity, 35.h),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16.r),
//                           ),
//                           backgroundColor: AppColors.primaryBrand,
//                         ),
//                         onPressed: dispatchRandom,
//                         child: const Text('Get random trivia'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   void dispatchConcrete() {
//     BlocProvider.of<NumberTriviaBloc>(context).add(
//       NumberTriviaConcreteEvent(
//         number: controller.text,
//       ),
//     );
//   }

//   void dispatchRandom() {
//     controller.clear();
//     BlocProvider.of<NumberTriviaBloc>(context).add(
//       NumberTriviaRandomEvent(),
//     );
//   }
// }
