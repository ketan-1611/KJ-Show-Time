import 'package:flutter/material.dart';
import 'package:moive_details_api/screens/movies/movie_screen.dart';
import 'package:moive_details_api/screens/tv_shows/tv_shows_screen.dart';
import 'package:moive_details_api/services/api_services.dart';
import 'package:moive_details_api/widgets/custom_appbar.dart';
import 'package:moive_details_api/widgets/custom_btn.dart';

import '../models/TvModel.dart';
import '../models/movies_model.dart';

class HomeScreen extends StatelessWidget {
  List<MovieModel>? movies = [];
  List<TvModel>? tvShows = [];

  HomeScreen({Key? key,this.movies,this.tvShows}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: CustomAppbar(text: "Show Time",),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.7,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/moive_bg.jpg"),
                  fit: BoxFit.cover
                )
              ),
            ),
          ) ,

          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome to the KJ Movies Details App",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                  fontWeight: FontWeight.bold
                ),
                ),
                SizedBox(height: 10,),
                InkWell(
                    onTap:(){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => MovieScreen()
                      ));
                    },
                    child: CustomButton(text: "Movies")
                ),
                SizedBox(height: 10,),
                InkWell(
                    onTap:(){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => TvShowsScreen()
                          ));
                    },
                    child: CustomButton(text: "Tv Shows")
                ),
              ],
            ),
          )
        ],
      )
    );
  }

  void fetchData() async{
    ApiService api = ApiService();
    movies = await api.getMovieData();
    print(movies?.length.toString());

    tvShows = await api.getTvData();
    print(tvShows?.length.toString());
  }
}
