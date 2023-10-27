import 'package:flutter/material.dart';
import 'package:moive_details_api/widgets/custom_appbar.dart';

import '../../models/movies_model.dart';
import '../../services/api_services.dart';
import 'movies_detail_screen.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  List<MovieModel> moviesDetails = [];

  Future<void>fetchMovies() async{
    ApiService api = ApiService();
    List<MovieModel>list = await api.getMovieData();

    setState(() {
      moviesDetails = list;
    });

    // tvShows = await api.getTvData();
    // print(tvShows?.length.toString());
  }

  void handleMenuItemSelected(int value){
    if(value==1){
      moviesDetails.sort((a,b) {
        final ratingA = a.voteAverage ?? 0.0;
        final ratingB = b.voteAverage ?? 0.0;

        return ratingB.compareTo(ratingA);
      });

      setState(() {

      });
    }
    else{
      moviesDetails.sort((a,b){
        final firstAirDateA = a.releaseDate ?? "";
        final firstAirDateB = b.releaseDate ?? "";

        return firstAirDateB.compareTo(firstAirDateA);
      });

      setState(() {

      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMovies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(text: "Movies",
      onMenuItemSelected: handleMenuItemSelected,),
      body:Column(
        children: [


          Expanded(
            child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1
                    ),
                    itemCount: moviesDetails.length,
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => MovieDetail(movie: moviesDetails[index],
                                  )
                              ));
                        },
                        child: Card(
                          elevation: 5,
                          color: Colors.grey,
                          shadowColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: double.maxFinite,
                                height: 200,
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w500/${moviesDetails[index].backdropPath}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text("Name: ${moviesDetails[index].title}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              SizedBox(height: 10,),
                              Text("Rating: ${moviesDetails[index].voteAverage}",style: TextStyle(fontSize:16)),
                              SizedBox(height: 10,),
                              Text("Release Date: ${moviesDetails[index].releaseDate}",style: TextStyle(fontSize:16))
                            ],
                          ),
                        ),
                      );

                    }

            ),
          ),
        ],
      )
    );
  }
}
