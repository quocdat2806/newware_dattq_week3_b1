import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:week3b2/model/movie.dart';

class Detail extends StatefulWidget {
  Movie movie;

  Detail(this.movie, {super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool isSeeAll = false;
  bool isMore = false;

  @override
  void initState() {
    isSeeAll = false;
    isMore = false;
    super.initState();
  }

  void renderState() {
    setState(() {
      isMore = !isMore;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? text = widget.movie.overview;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 3 / 4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'http://image.tmdb.org/t/p/w500/${widget.movie.poster_path}'),
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 40,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(
                  "assets/images/Back.svg",
                  height: 24,
                  width: 24,
                  // ignore: deprecated_member_use
                  color: Colors.white70,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: DraggableScrollableSheet(
                    minChildSize: 0.5,
                    initialChildSize: 0.5,
                    maxChildSize: 1,
                    shouldCloseOnMinExtent: true,
                    builder: (BuildContext context, myScrollController) {
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        padding: const EdgeInsets.only(
                            left: 50, right: 50, top: 10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [0.1, 0.9],
                            colors: <Color>[
                              Color(0xff2B5876),
                              Color(0xff4E4376)
                            ],
                          ),
                        ),
                        child: ListView(
                          controller: myScrollController,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 10, left: 130, right: 130),
                              height: 1,
                              color: Colors.white70,
                            ),
                            const Text(
                              'Thor',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 54,
                                fontFamily: 'Bold',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Text(
                              'The dark World',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                  fontFamily: 'Medium'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF547E9D),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: const Text('Action'),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF547E9D),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: widget.movie.adult!
                                        ? const Text('18+')
                                        : const Text('16+'),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF5C518),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/imdb.svg',
                                          width: 20,
                                          height: 20,
                                        ),
                                        Text(
                                          '${widget.movie.vote_average!}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      child: SvgPicture.asset(
                                        "assets/images/share.svg",
                                        width: 24,
                                        height: 24,
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      "assets/images/Favorite.svg",
                                      width: 24,
                                      height: 24,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            isMore
                                ? RichTextMore(
                                    text: text!,
                                    onTab: () {
                                      setState(
                                        () {
                                          isMore = !isMore;
                                        },
                                      );
                                    },
                                  )
                                : RichTextLess(
                                    text: text!,
                                    onTab: () {
                                      setState(
                                        () {
                                          isMore = !isMore;
                                        },
                                      );
                                    },
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Cast',
                                  style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Medium',
                                      fontSize: 18),
                                ),
                                InkWell(
                                  child: Text(
                                    isSeeAll ? 'Sell less' : 'Sell all',
                                    style: const TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 12,
                                        fontFamily: 'Medium',
                                        fontWeight: FontWeight.w500),
                                  ),
                                  onTap: () {
                                    setState(
                                      () {
                                        isSeeAll = !isSeeAll;
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              height: 200,
                              child: GridView.builder(
                                controller: myScrollController,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 70,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 10),
                                itemCount:
                                    isSeeAll ? widget.movie.list.length : 4,
                                itemBuilder: (BuildContext ctx, index) {
                                  return Column(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          image: DecorationImage(
                                            fit: BoxFit.fitWidth,
                                            image: NetworkImage(widget.movie
                                                        .list[index].image !=
                                                    null
                                                ? 'http://image.tmdb.org/t/p/w500/${widget.movie.list[index].image}'
                                                : 'https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI='),
                                          ),
                                        ),
                                      ),


                                    ],
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class RichTextMore extends StatelessWidget {
  final String text;
  final VoidCallback onTab;

  const RichTextMore({
    super.key,
    required this.text,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        children: [
          TextSpan(
            text: text.substring(0, 100),
            style: const TextStyle(
                color: Color(0xBFFFFFFF),
                fontWeight: FontWeight.w500,
                fontFamily: 'Medium',
                fontSize: 12),
          ),
          TextSpan(
            text: ' ...More',
            style: TextStyle(
                color: Colors.blue[300], fontSize: 14, fontFamily: 'Medium'),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                onTab();
              },
          ),
        ],
      ),
    );
  }
}

class RichTextLess extends StatelessWidget {
  final String text;
  final VoidCallback onTab;

  const RichTextLess({
    super.key,
    required this.text,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(
                color: Color(0xBFFFFFFF),
                fontWeight: FontWeight.w500,
                fontSize: 12,
                fontFamily: 'Medium'),
          ),
          TextSpan(
            text: ' Less',
            style: TextStyle(
                color: Colors.blue[300], fontFamily: 'Medium', fontSize: 14),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                onTab();
              },
          ),
        ],
      ),
    );
  }
}
