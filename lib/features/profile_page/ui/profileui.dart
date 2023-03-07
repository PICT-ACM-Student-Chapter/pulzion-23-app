import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'card.dart';
import 'package:panorama/panorama.dart';
import 'package:glowstone/glowstone.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());
}

class ProfileState {
  final String? name;
  final String? emailId;
  final String? contactNo;
  final String? year;
  final String? college;

  ProfileState(
      {this.name, this.contactNo, this.emailId, this.year, this.college});
} //the part above this is just for the bloc which I am not able to implement exactly

List<ProfileState> list = [
  ProfileState(
    name: "Soumya Garg",
    contactNo: "7777888800",
    emailId: "soumyagarg2905@gmail.com",
    year: "SE",
    college: "PICT",
  )
];

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  //main ui starts from here
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var h = MediaQuery.of(context).size.height;
        var w = MediaQuery.of(context).size.width;
        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(
              color: Colors.white,
            ),
            backgroundColor: Colors.transparent,
          ),
          extendBodyBehindAppBar: true,
          body: Stack(children: [
            Panorama(
              animSpeed: 0.5,
              sensorControl: SensorControl.Orientation,
              child:
                  Image.asset('assets/images/space_bg.jpg', fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: kToolbarHeight,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: h * 0.01),
                          height: h / 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(h * 0.04),
                              bottomRight: Radius.circular(h * 0.04),
                            ),
                            color: Colors.black.withOpacity(0.7),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(h * 0.02),
                                    border: Border.all(
                                      width: h * 0.001,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  child: const Image(
                                    image: AssetImage(
                                        'assets/images/pasc_logo.png'),
                                  ),
                                ),
                              ),
                              // const SizedBox(
                              //   height: 20,
                              // )
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(top: h * 0.01),
                                  child: Text(
                                    'WELCOME TO YOUR PROFILE',
                                    style: TextStyle(
                                      fontSize: h * 0.025,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: w * 0.05),
                            padding: EdgeInsets.all(h * 0.01),
                            child: Glowstone(
                              color: Colors.white,
                              velocity: 15,
                              radius: 5,
                              child: CircleAvatar(
                                radius: w / 14,
                                backgroundImage:
                                    Image.asset("assets/images/astronaut.jpeg")
                                        .image,
                                //     as ImageProvider<Object>,
                              ),
                            ),
                          ),
                          SizedBox(height: h * 0.1, width: w * 0.1),
                          LimitedBox(
                            maxWidth: w - w * 0.2,
                            child: Text(
                              list[0].name.toString(),
                              style: TextStyle(
                                  fontSize: w * 0.08,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: h * 0.001),

                    // Add other profile information widgets here.
                    //The carddesign is a separate dart file which returns the widget (here in main we only call the dunction and pass arguments)
                    cardDesign(
                        "USERNAME",
                        h,
                        w,
                        list[0].name,
                        const Icon(
                          Icons.person,
                          color: Colors.white,
                        )),
                    SizedBox(
                      height: h * 0.01,
                    ),
                    cardDesign(
                        "EMAIL",
                        h,
                        w,
                        list[0].emailId,
                        const Icon(
                          Icons.email,
                          color: Colors.white,
                        )),
                    SizedBox(
                      height: h * 0.01,
                    ),

                    cardDesign(
                        "CONTACT NO.",
                        h,
                        w,
                        list[0].contactNo,
                        const Icon(
                          Icons.phone,
                          color: Colors.white,
                        )),
                    SizedBox(
                      height: h * 0.01,
                    ),
                    cardDesign(
                        "YEAR",
                        h,
                        w,
                        list[0].year,
                        const Icon(
                          Icons.school,
                          color: Colors.white,
                        )),
                    SizedBox(
                      height: h * 0.01,
                    ),
                    cardDesign(
                        "COLLEGE",
                        h,
                        w,
                        list[0].college,
                        const Icon(
                          Icons.book,
                          color: Colors.white,
                        )),
                    SizedBox(
                      height: h * 0.01,
                    ),
                    // SizedBox(height: 0.0000001, width: double.infinity),
                  ],
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
}
