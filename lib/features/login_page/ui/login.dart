import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:lottie/lottie.dart';
import 'package:panorama/panorama.dart';
import 'package:pulzion23/constants/widgets/halloween_button.dart';
import 'package:pulzion23/features/login_page/ui/widgets/enter_email.dart';

import '../../../constants/colors.dart';
import '../../../constants/images.dart';
import '../../../constants/styles.dart';
import '../../../constants/widgets/loader.dart';
import '../cubit/check_login_cubit.dart';
import '../logic/login_cubit.dart';
import 'widgets/go_back_button.dart';
import 'widgets/roundedbutton.dart';
import 'widgets/text_field.dart';
import '../../../project/cubit/animation_toggle_cubit.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var padding = MediaQuery.of(context).padding;

    return Stack(
      children: [
        BlocConsumer<GlobalParameterCubit, bool>(
          listener: (context, state) {},
          buildWhen: (previous, current) {
            if (previous != current) {
              return true;
            }

            return false;
          },
          builder: (context, state) {
            return Container(
              constraints: BoxConstraints.expand(),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/app_background.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),);
          },
        ),
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: GoBackButton(context),
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          body: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) async {
              if (state is LoginSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Login Successful"),
                    backgroundColor: Colors.green,
                  ),
                );
                await context.read<CheckLoginCubit>().checkLogin();
                if (mounted) {
                  while (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                }
              }
              if (state is LoginFailure) {

                if(mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            builder: (context, state) {
              if (state is LoginInitial ||
                  state is LoginFailure ||
                  state is LoginError) {
                return SingleChildScrollView(
                  child: Container(
                    height: size.height -
                        kToolbarHeight -
                        padding.bottom -
                        padding.top,
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipOval(child: Image.asset('assets/images/bat.gif')),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Login',
                          style:
                              AppStyles.NormalText().copyWith(fontSize: 30,color:Color.fromARGB(255, 208, 168, 116),),
                        ),
                        Text(
                          'Please sign in to continue.',
                          style:
                             AppStyles.NormalText().copyWith(fontSize: 15,color:Color.fromARGB(255, 208, 168, 116),),
                        ),
                        LoginSignUpTextField(
                          'Email',
                          Icons.email,
                          controller: emailController,
                          obscureText: false,
                        ),
                        LoginSignUpTextField(
                          'Password',
                          Icons.lock,
                          controller: passwordController,
                          obscureText: true,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => LoginCubit(),
                                    child: const GetUserEmail(),
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Forgot Password?',
                                style: AppStyles.NormalText().copyWith(
                                  fontSize: 15,
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          height: 100,
                          width: 700,
                          padding: const EdgeInsets.only(left: 90),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: HalloweenButton(
                            buttonText: 'LOGIN',
                            icon: Icons.login,
                            onPressed: () async {
                              context.read<LoginCubit>().login(
                                    emailController.text,
                                    passwordController.text,
                                  );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (state is LoginLoading) {
                return const Center(child: Loader());
              }

              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
