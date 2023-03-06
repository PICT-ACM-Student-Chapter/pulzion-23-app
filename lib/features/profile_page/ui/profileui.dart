import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'card.dart';
import 'package:panorama/panorama.dart';
import 'package:glowstone/glowstone.dart';

void main() {
  runApp(
    BlocProvider<ProfileCubit>(
        create: (BuildContext context) => ProfileCubit(), child: MyWidget()),
  );
}

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

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ProfilePage());
  }
}

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
  //main ui starts from here
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var h = MediaQuery.of(context).size.height;
        var w = MediaQuery.of(context).size.width;
        return Scaffold(
          body: Stack(children: [
            Panorama(
              animSpeed: 0.5,
              sensorControl: SensorControl.Orientation,
              child:
                  Image.asset('assets/images/spaceimg.jpg', fit: BoxFit.cover),
            ),
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: h * 0.06),
                      height: h / 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(h * 0.04),
                          bottomRight: Radius.circular(h * 0.04),
                        ),
                        color: Colors.black,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(h * 0.03),
                                border: Border.all(
                                    width: h * 0.001, color: Colors.blue),
                              ),
                              child: Image(
                                image:
                                    AssetImage('assets/images/pasc_logo.png'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: h * 0.03),
                              child: Text(
                                'WELCOME TO YOUR PROFILE',
                                style: TextStyle(
                                  fontSize: h * 0.03,
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
                      Padding(
                        padding: EdgeInsets.all(h * 0.01),
                        child: Glowstone(
                          color: Colors.white,
                          velocity: 20,
                          child: CircleAvatar(
                            radius: w / 8,
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
                    Icon(
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
                    Icon(
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
                    Icon(
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
                    Icon(
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
                    Icon(
                      Icons.book,
                      color: Colors.white,
                    )),
                SizedBox(
                  height: h * 0.01,
                ),
                // SizedBox(height: 0.0000001, width: double.infinity),
              ],
            ),
          ]),
        );
      },
    );
  }
}
