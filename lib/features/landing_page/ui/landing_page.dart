// Use the sample cubit to show use of the cubit in the UI

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pulzion23/constants/colors.dart';
import 'package:pulzion23/constants/styles.dart';
import 'package:pulzion23/constants/widgets/loader.dart';
import 'package:pulzion23/features/landing_page/logic/sample_cubit_cubit.dart';
import 'package:pulzion23/features/landing_page/ui/app_logo_image.dart';
import 'package:pulzion23/project/routes/app_route_constant.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Landing Page'),
        actions: [
          IconButton(
            onPressed: () {
              context.goNamed(RouteName.profile);
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          logoWidget(),
          BlocProvider(
            create: (context) => SampleCubitCubit(),
            child: BlocBuilder<SampleCubitCubit, SampleCubitState>(
              // listenWhen: (previous, current) =>
              //     previous.runtimeType != current.runtimeType,
              // listener: (context, state) {
              //   if (state is SampleCubitLoaded) {
              //     print("State Loaded");
              //   }
              // },
              builder: (context, state) {
                if (state is SampleCubitInitial) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Initial', style: AppStyles.bodyTextStyle1()),
                        const SizedBox(height: 20),
                        FloatingActionButton(
                          onPressed: () {
                            BlocProvider.of<SampleCubitCubit>(context).load();
                          },
                          backgroundColor: AppColors.primary,
                          child: const Icon(Icons.add_circle),
                        ),
                      ],
                    ),
                  );
                } else if (state is SampleCubitLoading) {
                  return const Center(
                    child: Loader(),
                  );
                } else if (state is SampleCubitLoaded) {
                  return Center(
                    child:
                        Text(state.message, style: AppStyles.bodyTextStyle1()),
                  );
                } else if (state is SampleCubitError) {
                  return Center(
                    child:
                        Text(state.message, style: AppStyles.bodyTextStyle1()),
                  );
                } else {
                  return Center(
                    child: Text('Unknown', style: AppStyles.bodyTextStyle1()),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
