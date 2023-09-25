import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1,color: const Color(0x33FFFFFF),),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        decoration:  InputDecoration(
          prefixIcon:const Icon(Icons.search,size: 30,color: Colors.white,),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: const TextStyle(
            fontFamily: 'Light',
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Color(0x80FFFFFF),
          ),
          suffixIcon: Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: const BoxDecoration(
              border: Border(left: BorderSide(width: 1,color: Colors.white))
            ),
            // ignore: deprecated_member_use
            child: SvgPicture.asset('assets/images/mic.svg',color: const Color(0x80FFFFFF),),
          )
        ),
      ),

    );
  }
}
