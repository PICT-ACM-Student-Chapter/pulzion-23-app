import 'dart:async';
import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion23/features/event_description/ui/event_description.dart';
import 'package:pulzion23/features/home_page/logic/event_details_cubit_cubit.dart';
import '../../../../constants/models/event_model.dart';

class DarkSample extends StatefulWidget {
  final Events event;
  const DarkSample({required this.event, Key? key}) : super(key: key);
  @override
  _DarkSampleState createState() => _DarkSampleState();
}

class _DarkSampleState extends State<DarkSample> {
  bool isDark = false;
  int isFirst = 0;
  late Timer t1, t2;

  @override
  void initState() {
    super.initState();
    t1 = Timer(const Duration(milliseconds: 100), () {
      setState(() {
        isDark = !isDark;
      });
    });
    t2 = Timer(const Duration(milliseconds: 600), () {
      setState(() {
        isDark = !isDark;
      });
    });
  }

  @override
  void dispose() {
    if (t1.isActive) t1.cancel();
    if (t2.isActive) t2.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final circleOffset = Offset(size.width - 20, size.height - 20);

    return DarkTransition(
      childBuilder: (context, x) => BlocProvider.value(
        value: BlocProvider.of<EventDetailsCubitCubit>(context),
        child: EventDescription(
          event: widget.event,
          isDark: isDark,
          getTheme: () => isDark ? _darkTheme : _lightTheme,
          onChange: () {
            setState(() {
              isDark = !isDark;
            });
          },
        ),
      ),
      offset: circleOffset,
      isDark: isDark,
    );
  }
}

// work
ThemeData _darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.grey[700],
  scaffoldBackgroundColor: Colors.black.withOpacity(0.4),
  cardColor: Colors.black,
  canvasColor: Colors.black,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
  ),
);

ThemeData _lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.black,
  cardColor: Colors.white,
  canvasColor: Colors.white,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
  ),
);

class DarkTransition extends StatefulWidget {
  const DarkTransition({
    required this.childBuilder,
    Key? key,
    this.offset = Offset.zero,
    this.themeController,
    this.radius,
    this.duration = const Duration(milliseconds: 900),
    this.isDark = false,
  }) : super(key: key);

  final Widget Function(BuildContext, int) childBuilder;
  final bool isDark;
  final AnimationController? themeController;
  final Offset offset;
  final double? radius;
  final Duration? duration;
  @override
  _DarkTransitionState createState() => _DarkTransitionState();
}

class _DarkTransitionState extends State<DarkTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double x = 0;
  double y = 0;
  bool isDark = false;
  // bool isBottomThemeDark = true;
  bool isDarkVisible = false;
  late double radius;
  Offset position = Offset.zero;

  @override
  void dispose() {
    _darkNotifier.dispose();
    super.dispose();
  }

  final _darkNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _animationController = widget.themeController == null
        ? AnimationController(vsync: this, duration: widget.duration)
        : widget.themeController!;
  }

  double _radius(Size size) {
    final maxVal = Math.max(size.width, size.height);

    return maxVal * 1.5;
  }

  ThemeData getTheme(bool dark) {
    return (dark) ? _darkTheme : _lightTheme;
  }

  @override
  void didUpdateWidget(DarkTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    _darkNotifier.value = widget.isDark;
    if (widget.isDark != oldWidget.isDark) {
      if (isDark) {
        _animationController.reverse();
        _darkNotifier.value = false;
      } else {
        _animationController.reset();
        _animationController.forward();
        _darkNotifier.value = true;
      }
    }
    if (widget.radius != oldWidget.radius) {
      _updateRadius();
    }
    if (widget.duration != oldWidget.duration) {
      _animationController.duration = widget.duration;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateRadius();
  }

  void _updateRadius() {
    final size = MediaQuery.of(context).size;
    radius = widget.radius == null ? _radius(size) : widget.radius!;
  }

  @override
  Widget build(BuildContext context) {
    isDark = _darkNotifier.value;
    Widget _body(int index) {
      return ValueListenableBuilder<bool>(
        valueListenable: _darkNotifier,
        builder: (BuildContext context, bool isDark, Widget? child) {
          return Theme(
            data:
                index == 2 ? getTheme(!isDarkVisible) : getTheme(isDarkVisible),
            child: widget.childBuilder(context, index),
          );
        },
      );
    }

    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return Stack(
          children: [
            if (!isDark) _body(1),
            // if (isDark)
            ClipPath(
              clipper: CircularClipper(
                _animationController.value * radius,
              ),
              child: _body(2),
            ),
          ],
        );
      },
    );
  }
}

class CircularClipper extends CustomClipper<Path> {
  const CircularClipper(this.radius);
  final double radius;

  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.addOval(Rect.fromCircle(
      radius: radius,
      center: Offset(size.width * 0.5, size.height * 0.3),
    ));

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
