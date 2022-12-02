import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Container(
          width: w,
          height: h * 0.3,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("img/logo-color.png"), fit: BoxFit.cover)),
          child: Column(
            children: [
              SizedBox(
                height: h * 0.18,
              ),
              CircleAvatar(
                radius: 44,
                backgroundImage: AssetImage("img/backProfile.jpeg"),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          width: w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome on YouBike",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: w * 0.5,
          height: h * 0.08,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                  image: AssetImage("img/btnBackground.png"),
                  fit: BoxFit.cover)),
          child: Center(
            child: Text(
              "Sign up",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: w * 0.08),
        RichText(
            text: TextSpan(
                text: "Already have an account ?",
                style: TextStyle(color: Colors.grey[500], fontSize: 20),
                // ignore: prefer_const_literals_to_create_immutables
                children: [
              TextSpan(
                  text: " Login",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold))
            ]))
      ]),
    );
  }
}
