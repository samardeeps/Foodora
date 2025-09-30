// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lottie/lottie.dart';
// import '../blocs/splash/splash_bloc.dart';
// import '../blocs/splash/splash_state.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _scaleController;
//   late AnimationController _fadeController;
//   late AnimationController _slideController;

//   late Animation<double> _scaleAnimation;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;

//   @override
//   void initState() {
//     super.initState();

//     // Scale animation for logo
//     _scaleController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );

//     _scaleAnimation = CurvedAnimation(
//       parent: _scaleController,
//       curve: Curves.elasticOut,
//     );

//     // Fade animation for background
//     _fadeController = AnimationController(
//       duration: const Duration(milliseconds: 600),
//       vsync: this,
//     );

//     _fadeAnimation = CurvedAnimation(
//       parent: _fadeController,
//       curve: Curves.easeIn,
//     );

//     // Slide animation for tagline or additional elements
//     _slideController = AnimationController(
//       duration: const Duration(milliseconds: 600),
//       vsync: this,
//     );

//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.5),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

//     // Start animations
//     _fadeController.forward();
//     Future.delayed(const Duration(milliseconds: 200), () {
//       _scaleController.forward();
//     });
//     Future.delayed(const Duration(milliseconds: 600), () {
//       _slideController.forward();
//     });
//   }

//   @override
//   void dispose() {
//     _scaleController.dispose();
//     _fadeController.dispose();
//     _slideController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<SplashBloc, SplashState>(
//       listener: (context, state) {
//         if (state is SplashCompleted) {
//           Navigator.of(context).pushReplacementNamed('/home');
//         }
//       },
//       child: Scaffold(
//         body: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Color(0xFF2C5F6F),
//                 Color(0xFF1A3D47),
//               ],
//             ),
//           ),
//           child: FadeTransition(
//             opacity: _fadeAnimation,
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ScaleTransition(
//                     scale: _scaleAnimation,
//                     child: Center(
//                       child: ClipRRect(
//                         child: Image.asset(
//                           'assets/images/logo.png',
//                           width: 250,
//                           height: 160,
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SlideTransition(
//                     position: _slideAnimation,
//                     child: FadeTransition(
//                       opacity: _fadeAnimation,
//                       child: Column(
//                         children: [
//                           // Lottie.asset(
//                           //   'assets/animations/loading.json',
//                           //   width: 350,
//                           //   height: 300,
//                           //   fit: BoxFit.contain,
//                           // ),
//                           // const SizedBox(height: 240),
//                           Text(
//                             'Your Food, Delivered',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w300,
//                               color: Colors.white.withOpacity(0.9),
//                               letterSpacing: 1.2,
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../blocs/splash/splash_bloc.dart';
import '../blocs/splash/splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late AnimationController _slideController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Scale animation for logo
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );

    // Fade animation for background
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    // Slide animation for tagline or additional elements
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    // Start animations
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _scaleController.forward();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashCompleted) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF2C5F6F), Color(0xFF1A3D47)],
            ),
          ),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Stack(
              children: [
                // Centered Logo
                Center(
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: ClipRRect(
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 250,
                        height: 160,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                // Bottom Text
                Positioned(
                  bottom: 60,
                  left: 0,
                  right: 0,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Text(
                        'Your Food, Delivered',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: const Color.fromARGB(
                            255,
                            255,
                            251,
                            226,
                          ).withOpacity(0.9),
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
