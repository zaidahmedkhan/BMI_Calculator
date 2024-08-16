import 'package:bmi_calculator/constants/colors.dart';
import 'package:bmi_calculator/screens/result_screen.dart';
import 'package:flutter/material.dart';

class WeightScreen extends StatefulWidget {
  final String gender;
  final double height;

  const WeightScreen({super.key, required this.gender, required this.height});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen>
    with SingleTickerProviderStateMixin {
  double _selectedWeight = 70.0; // Default weight
  late AnimationController _controller;
  late Animation<double> _weightAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _weightAnimation =
        Tween<double>(begin: _selectedWeight, end: _selectedWeight).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void _updateWeight(double value) {
    setState(() {
      _selectedWeight = value;
      _weightAnimation =
          Tween<double>(begin: _selectedWeight, end: _selectedWeight).animate(
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
                "Select Weight",
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _weightAnimation,
              builder: (context, child) {
                return Text(
                  "${_weightAnimation.value.toStringAsFixed(1)} kg",
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
                  value: _selectedWeight,
                  min: 30.0,
                  max: 200.0,
                  divisions: 170,
                  onChanged: (value) {
                    _updateWeight(value);
                  },
                ),
              ),
            ),
            const SizedBox(height: 55),
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
                                  ResultScreen(
                            gender: widget.gender,
                            height: widget.height,
                            weight: _selectedWeight,
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
                          "Calculate",
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
            const Spacer()
          ],
        ),
      ),
    );
  }
}
