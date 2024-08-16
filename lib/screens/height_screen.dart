import 'package:bmi_calculator/constants/colors.dart';
import 'package:bmi_calculator/screens/weight_screen.dart';
import 'package:flutter/material.dart';

class HeightScreen extends StatefulWidget {
  final String gender;

  const HeightScreen({super.key, required this.gender});

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen>
    with SingleTickerProviderStateMixin {
  double _selectedHeight = 170.0; 
  late AnimationController _controller;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _heightAnimation =
        Tween<double>(begin: _selectedHeight, end: _selectedHeight).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void _updateHeight(double value) {
    setState(() {
      _selectedHeight = value;
      _heightAnimation =
          Tween<double>(begin: _selectedHeight, end: _selectedHeight).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      );
      _controller.forward().then((_) => _controller.reverse());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu, color: AppColors.secondaryColor, size: 25),
                  Icon(Icons.recommend,
                      color: AppColors.secondaryColor, size: 25),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Select Height",
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _heightAnimation,
              builder: (context, child) {
                return Text(
                  "${_heightAnimation.value.toStringAsFixed(1)} cm",
                  style: const TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            Expanded(
              child: Center(
                child: Slider(
                  activeColor: AppColors.containerColor,
                  value: _selectedHeight,
                  min: 50.0,
                  max: 250.0,
                  divisions: 200,
                  onChanged: (value) {
                    _updateHeight(value);
                  },
                ),
              ),
            ),
           const  SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 85,
                      width: 140,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const Center(
                        child: Text(
                          "Back",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blackTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  WeightScreen(
                            gender: widget.gender,
                            height: _selectedHeight,
                          ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.easeInOut;
                            var tween = Tween(begin: begin, end: end);
                            var offsetAnimation = animation
                                .drive(tween.chain(CurveTween(curve: curve)));
                            return SlideTransition(
                                position: offsetAnimation, child: child);
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 85,
                      width: 140,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const Center(
                        child: Text(
                          "Next",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blackTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const  Spacer()
          ],
        ),
      ),
    );
  }
}
