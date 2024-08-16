

import 'package:bmi_calculator/constants/colors.dart';
import 'package:bmi_calculator/screens/height_screen.dart';
import 'package:flutter/material.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen>
    with SingleTickerProviderStateMixin {
  String _selectedGender = '';
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  void _onGenderSelected(String gender) {
    setState(() {
      _selectedGender = gender;
    });
    _animationController.forward().then((_) => _animationController.reverse());
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      "Select Gender",
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 50),
                    ScaleTransition(
                      scale: _animation,
                      child: GestureDetector(
                        onTap: () => _onGenderSelected('Male'),
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            color: AppColors.containerColor,
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.male,
                                color: _selectedGender == 'Male'
                                    ? AppColors.secondaryColor
                                    : Colors.grey,
                                size: 25,
                              ),
                             const  SizedBox(height: 5),
                              Text(
                                "Male",
                                style: TextStyle(
                                  color: _selectedGender == 'Male'
                                      ? AppColors.secondaryColor
                                      : Colors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    ScaleTransition(
                      scale: _animation,
                      child: GestureDetector(
                        onTap: () => _onGenderSelected('Female'),
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            color: AppColors.containerColor,
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.female,
                                color: _selectedGender == 'Female'
                                    ? AppColors.secondaryColor
                                    : Colors.grey,
                                size: 25,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Female",
                                style: TextStyle(
                                  color: _selectedGender == 'Female'
                                      ? AppColors.secondaryColor
                                      : Colors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Text(
                      _selectedGender.isEmpty
                          ? "Please select a gender"
                          : "Selected: $_selectedGender",
                      style: TextStyle(
                        color: _selectedGender.isEmpty
                            ? Colors.red
                            : AppColors.secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        if (_selectedGender.isNotEmpty) {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      HeightScreen(gender: _selectedGender),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.easeInOut;
                                var tween = Tween(begin: begin, end: end);
                                var offsetAnimation = animation.drive(
                                    tween.chain(CurveTween(curve: curve)));
                                return SlideTransition(
                                    position: offsetAnimation, child: child);
                              },
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                           const  SnackBar(
                              content: Text(
                                "Please select a gender before proceeding.",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
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
            ),
          ],
        ),
      ),
    );
  }
}
