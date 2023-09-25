import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:week3b2/views/header.dart';
import 'package:week3b2/views/list_item.dart';
import 'package:week3b2/views/search.dart';
import 'package:week3b2/model/movie.dart';

import '../model/cast.dart';
import 'detail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _controller = ScrollController();
  int currentPostionSlider = 0;
  int currentPostion = 0;

  int myFirstPage = 0;
  late List<Movie> list;
  bool isLoading = true;

  Future<dynamic> fetchAlbum() async {
    List<Movie> listMovie = [];
    List<Cast> listCart = [];
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MWY5ODkxOGQ2NjQ0NDJiMDNjYWU5YjZhNjFmODNiNyIsInN1YiI6IjY1MDI4YjNhZTBjYTdmMDEwZGVhZjM0YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.n-QhBEfyLwxNTwJaEegevzsQutFuwg0B27H6tR2qEXM'
    };
    final response = await http.get(
        Uri.parse('https://api.themoviedb.org/3/movie/popular'),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body)['results'];
      var resultLength = result?.length;
      for (int i = 0; i < resultLength; i++) {
        int movieId = result[i]['id'];
        final response = await http.get(
            Uri.parse('https://api.themoviedb.org/3/movie/$movieId/credits'),
            headers: requestHeaders);
        var res = jsonDecode(response.body);
        var cast = res['cast'];
        for (int i = 0; i < cast.length; i++) {
          listCart.add(Cast(cast[i]['name'], cast[i]['original_name'],
              cast[i]['profile_path']));
        }

        var movie = Movie(
            result[i]['adult'],
            result[i]['poster_path'],
            result[i]['title'],
            result[i]?['overview'],
            result[i]['vote_average'],
            listCart);
        listMovie.add(movie);
        listCart = [];
      }
      setState(() {
        isLoading = false;
        list = listMovie;
        listMovie = [];
      });
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    list = [];
    fetchAlbum();
  }

  final _pageController = PageController(viewportFraction: 0.75);
  final pageController = PageController(viewportFraction: 0.35);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.only(top: 40),
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.1, 0.9],
                colors: <Color>[Color(0xff2B5876), Color(0xff4E4376)],
              ),
            ),
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: const Header(),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: const Search(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Most Popular',
                      style: TextStyle(
                          fontFamily: 'Bold',
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 0),
                        height: 141,
                        child: PageView.builder(
                          controller: _pageController,
                          pageSnapping: true,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (value) {
                            setState(
                              () {
                                currentPostionSlider = value;
                              },
                            );
                          },
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            var scale =
                                currentPostionSlider == index ? 1.0 : 0.8;
                            return TweenAnimationBuilder(
                              duration: const Duration(milliseconds: 350),
                              tween: Tween(begin: scale, end: scale),
                              child: ListItem(list, index),
                              builder: (context, value, child) {
                                return Transform.scale(
                                  scale: value,
                                  child: child,
                                );
                              },
                            );
                          },
                        ),
                      ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  height: 10,
                  child: SizedBox(
                    width: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return ListDot(currentPostionSlider, index);
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ListContainer('assets/images/Vector.svg', 'Genres'),
                      ListContainer('assets/images/tv.svg', 'Tv series'),
                      ListContainer('assets/images/movie.svg', 'Movies'),
                      ListContainer('assets/images/Cinema.svg', 'In Theatre'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 29,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 50),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Up coming releases',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(left: 50),
                        height: 215,
                        child: PageView.builder(
                          padEnds: false,
                          controller: pageController,
                          pageSnapping: true,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (value) {
                            setState(
                              () {
                                currentPostion = value;
                              },
                            );
                          },
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            var scale = currentPostion == index ? 1.0 : 0.9;
                            return TweenAnimationBuilder(
                              duration: const Duration(milliseconds: 350),
                              tween: Tween(begin: scale, end: scale),
                              child: Container(
                                width: 145,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'http://image.tmdb.org/t/p/w500/${list[index].poster_path}'))),
                              ),
                              builder: (context, value, child) {
                                return Transform.scale(
                                  scale: value,
                                  child: child,
                                );
                              },
                            );
                          },
                        ),
                      ),


                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  height: 10,
                  child: SizedBox(
                    width: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return ListDot(currentPostion, index);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
