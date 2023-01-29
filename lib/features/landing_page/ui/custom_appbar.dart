import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(builder: (context) {
        return IconButton(
          onPressed: (() {
            Scaffold.of(context).openDrawer();
          }),
          icon: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color.fromARGB(255, 83, 51, 126),
                width: 1,
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 10, top: 8, right: 8, bottom: 8),
              child: SvgPicture.asset(
                'assets/images/menu.svg',
                color: const Color.fromARGB(255, 217, 217, 217),
              ),
            ),
          ),
        );
      }),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: (() {}),
            child: Container(
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color.fromARGB(255, 83, 51, 126),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Expanded(
                      child: Center(
                        child: Text(
                          'Ananya',
                          style: TextStyle(
                            color: Color.fromARGB(255, 217, 217, 217),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: FittedBox(
                        child: Image(
                            image: AssetImage('assets/images/person.png')),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
      backgroundColor: const Color.fromRGBO(49, 19, 91, 1),
      shadowColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
