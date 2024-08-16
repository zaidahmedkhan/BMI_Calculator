import 'package:bmi_calculator/constants/colors.dart';
import 'package:bmi_calculator/screens/gender_screen.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final String gender;
  final double height;
  final double weight;

  const ResultScreen({
    super.key,
    required this.gender,
    required this.height,
    required this.weight,
  });

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double bmi =
        widget.weight / ((widget.height / 100) * (widget.height / 100));
    String resultText = bmi < 18.5
        ? "Underweight"
        : bmi < 24.9
            ? "Normal weight"
            : "Overweight";

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            Expanded(
              child: Center(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Your BMI Result",
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "${bmi.toStringAsFixed(1)}",
                        style: const TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        resultText,
                        style: const TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GenderScreen()));
                },
                child: Container(
                  height: 85,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Center(
                    child: Text(
                      "Back to Home",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackTextColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
