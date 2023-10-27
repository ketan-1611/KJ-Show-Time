import 'package:flutter/material.dart';
import 'package:moive_details_api/models/TvModel.dart';
import 'package:moive_details_api/widgets/custom_appbar.dart';

class TvShowDetails extends StatelessWidget {
  TvModel tvShow;
  TvShowDetails({Key? key,required this.tvShow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(text: "${tvShow.name}",),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.maxFinite,
            height: 300,
            child: Image.network(
              'https://image.tmdb.org/t/p/w300/${tvShow.posterPath}',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20,),
          Container(
            margin: EdgeInsets.only(left: 12),
            child: Text(
              "Release Date: ${tvShow.firstAirDate}",
              style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left:12,top: 20),
            child: Text("Rating : ${tvShow.voteAverage}",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700)),
          ),
          Container(
            margin: EdgeInsets.only(left:12,top: 20),
            child: Text("Language : ${tvShow.originalLanguage}",style: TextStyle(fontSize: 22,)),
          ),
          Container(
            margin: EdgeInsets.only(left:12,top: 20),
            child: Text("OverView : ",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
          ),
          Container(
            margin: EdgeInsets.only(left: 12,right: 12,top: 20),
            child: Text("${tvShow.overview}",style: TextStyle(fontSize: 16),),
          )
        ],
      ),
    );
  }
}
