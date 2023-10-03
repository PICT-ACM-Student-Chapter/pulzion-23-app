import 'package:flutter/material.dart';
import 'package:pulzion23/main.dart';
import 'package:video_player/video_player.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('lib/assets/intro.mp4');

    _controller.initialize().then((_) {
      setState(() {
        // Ensure the video is initialized
      });
      _controller.play();

      Future.delayed(Duration(seconds: 7), () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (_, __, ___) =>Pulzion23App(),
            transitionsBuilder: (_, animation, __, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(1.0, 0.0), // start sliding from right
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          ),
        );
      });

    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized


            ? AspectRatio(
          aspectRatio: MediaQuery.of(context).size.width / MediaQuery.of(context).size.height,
          child: VideoPlayer(_controller),

        )
            : CircularProgressIndicator(),
      ),
    );
  }
}
