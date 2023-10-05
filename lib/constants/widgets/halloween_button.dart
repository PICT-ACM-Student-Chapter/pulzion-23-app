import 'package:flutter/material.dart';
import 'package:pulzion23/constants/styles.dart';

class HalloweenButton extends StatelessWidget {
  final String buttonText;
  final IconData icon;
  final VoidCallback onPressed;
  final double fontsize;
  final Color color;

  const HalloweenButton({
    super.key,
    this.color = Colors.deepPurple,
    this.fontsize = 15,
    required this.icon,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 25,
          top: 0,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                fit: BoxFit.fill,
                invertColors: true,
                scale: 0.1,
                image: AssetImage('assets/images/border.png'),
              ),
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange[600]!.withOpacity(0.3),
                    Colors.orange[700]!.withOpacity(0.6),
                    Colors.orange[800]!.withOpacity(0.7),
                    Colors.orange[900]!.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 25.0),
                  child: Text(
                    buttonText,
                    style: AppStyles.NormalText().copyWith(
                      color: Colors.white,
                      fontSize:15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          child: Image.asset(
            'assets/images/pumpkin.png',
            height: 55.0,
            width: 55.0,
          ),
        ),
      ],
    );
  }
}
