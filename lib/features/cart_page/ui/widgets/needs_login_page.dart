import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/styles.dart';
import '../../../login_page/logic/login_cubit.dart';
import '../../../login_page/logic/sign_up_cubit.dart';
import '../../../login_page/ui/login.dart';
import '../../../login_page/ui/sign_up.dart';

class NeedsLoginPage extends StatelessWidget {
  const NeedsLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "You haven't logged in!",
              style: AppStyles.bodyTextStyle3().copyWith(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Please login to continue.",
              style: AppStyles.bodyTextStyle3().copyWith(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            height: size.height * 0.075,
            width: size.width * 0.6,
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(200),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              border: const Border.fromBorderSide(
                BorderSide(
                  color: AppColors.cardBorder,
                  width: 1.5,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => SignUpCubit(),
                            child: const SignUp(),
                          ),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        'Register',
                        style: AppStyles.NormalText().copyWith(
                          fontSize: 15,
                          color: AppColors.cardTitleTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const VerticalDivider(
                  color: AppColors.cardBorder,
                  width: 2,
                  thickness: 2,
                  indent: 8.0,
                  endIndent: 8.0,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => LoginCubit(),
                            child: const Login(),
                          ),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        'Sign In',
                        style: AppStyles.NormalText().copyWith(
                          fontSize: 15,
                          color: AppColors.cardTitleTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
