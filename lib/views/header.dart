import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: const <TextSpan>[
              TextSpan(
                  text: 'Hello,',
                  style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: 'light')),
              TextSpan(
                  text: ' Jane!',
                  style: TextStyle(fontFamily: 'Bold',
                      fontWeight: FontWeight.w400,color: Colors.white,fontSize: 18)),
            ],
          ),
        ),
        const Image(image: AssetImage('assets/images/notfication_icon.png'),width: 24,height: 24,),
      ],
    );
  }
}
