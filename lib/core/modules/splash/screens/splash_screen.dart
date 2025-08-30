import 'package:flutter/material.dart';
import 'dart:async';
import '../../../theme/app_theme.dart';
import '../../home/screens/home_screen.dart';
import '../widgets/paw_prints_painter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _pawsController;
  late AnimationController _logoController;
  
  late Animation<double> _pawsAnimation;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _logoScaleAnimation;

  bool _canSkip = false;
  bool _isSkipped = false;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startAnimationSequence();
  }

  void _initAnimations() {
    // Paw prints animation controller
    _pawsController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Logo appearance controller
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Paw prints drawing animation
    _pawsAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _pawsController,
      curve: Curves.easeInOut,
    ));

    // Logo fade in
    _logoFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOut,
    ));

    // Logo scale in
    _logoScaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));
  }

  Future<void> _startAnimationSequence() async {
    // Allow skipping after 500ms
    Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() => _canSkip = true);
      }
    });

    try {
      // Phase 1: Draw paw prints
      await _pawsController.forward();
      
      if (_isSkipped) return;
      await Future.delayed(const Duration(milliseconds: 400));

      // Phase 2: Logo appears
      if (!_isSkipped) {
        await _logoController.forward();
      }

      if (_isSkipped) return;
      await Future.delayed(const Duration(milliseconds: 1000));

      // Navigate to home
      if (!_isSkipped && mounted) {
        _navigateToHome();
      }
    } catch (e) {
      // Handle any animation errors gracefully
      if (mounted && !_isSkipped) {
        _navigateToHome();
      }
    }
  }

  void _skipAnimation() {
    if (!_canSkip || _isSkipped) return;
    
    setState(() => _isSkipped = true);
    _navigateToHome();
  }

  void _navigateToHome() {
    if (!mounted) return;
    
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const ShibaNoteHomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  void dispose() {
    _pawsController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6F4E37), // Coffee brown
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF8B4513), // Saddle brown
              Color(0xFF6F4E37), // Coffee brown
              Color(0xFF5D4037), // Darker coffee brown
            ],
          ),
        ),
        child: Stack(
          children: [
            // Animated paw prints
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _pawsAnimation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: PawPrintsPainter(_pawsAnimation.value),
                  );
                },
              ),
            ),

            // Logo and text
            Center(
              child: AnimatedBuilder(
                animation: _logoController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _logoFadeAnimation.value,
                    child: Transform.scale(
                      scale: _logoScaleAnimation.value,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Simple paw icon
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5E6D3).withOpacity(0.9), // Cream
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.pets,
                              size: 60,
                              color: Color(0xFF6F4E37), // Coffee brown
                            ),
                          ),

                          const SizedBox(height: 24),

                          // App name
                          Text(
                            'ShibaNote',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFF5E6D3), // Cream
                                  letterSpacing: -1,
                                ),
                          ),

                          const SizedBox(height: 8),

                          // Tagline
                          Text(
                            'Your loyal note companion',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: const Color(0xFFF5E6D3).withOpacity(0.8), // Cream with opacity
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Skip button
            if (_canSkip && !_isSkipped)
              Positioned(
                bottom: 60,
                left: 0,
                right: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: _skipAnimation,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5E6D3).withOpacity(0.2), // Translucent cream
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFF5E6D3).withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Tap to continue',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: const Color(0xFFF5E6D3), // Cream
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.pets,
                            size: 16,
                            color: Color(0xFFF5E6D3), // Cream
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
