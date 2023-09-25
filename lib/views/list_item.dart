import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:week3b2/pages/detail.dart';

import '../model/movie.dart';

class ListItem extends StatelessWidget {
  List<Movie> list;
  int index;

  ListItem(this.list, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Detail(list[index])));
      },
      child: Container(
        height: 141,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            image: NetworkImage(
                'http://image.tmdb.org/t/p/w500/${list[index].poster_path}'),
            fit: BoxFit.cover,
          ),
        ),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white, fontSize: 20),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 0, 0, 0.3),
                    borderRadius: BorderRadius.circular(30)),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Text(
                  list[index].title.length > 15
                      ? '${list[index].title.split(' ')[0]} ...'
                      : list[index].title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Bold',
                      fontWeight: FontWeight.w700),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 50, minWidth: 30),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5C518),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/imdb.svg',
                        width: 18,
                        height: 14,
                      ),
                      Text(
                        '${list[index].vote_average}',
                        style: const TextStyle(
                            fontFamily: 'Bold',
                            color: Colors.black,
                            fontSize: 6,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ListDot extends StatefulWidget {
  int position;
  int index;

  ListDot(this.position, this.index, {super.key});

  @override
  State<ListDot> createState() => _ListDotState();
}

class _ListDotState extends State<ListDot> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 4, right: 4),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: (widget.position == widget.index)
            ? const Color(0xFF7389D1)
            : const Color(0xFF4B6292),
      ),
    );
  }
}

class ListContainer extends StatelessWidget {
  String path;
  String text;

  ListContainer(this.path, this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.1, 0.9],
          colors: <Color>[Color(0xff526E96), Color(0xff55819E)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 34,
            height: 34,
            margin: const EdgeInsets.only(bottom: 10),
            child: SvgPicture.asset(path),
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 10),
          )
        ],
      ),
    );
  }
}
