import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moive_details_api/models/TvModel.dart';
import 'package:moive_details_api/screens/tv_shows/tv_show_detail_screen.dart';
import 'package:moive_details_api/widgets/custom_appbar.dart';
import 'package:riverpod/riverpod.dart';

import '../../services/api_services.dart';

final tvShowsProvider = FutureProvider<List<TvModel>>((ref) async{
  final apiService = ref.read(apiServiceProvider);
  return await apiService.getTvData();
},);

class TvShowsScreen extends StatefulWidget {
  const TvShowsScreen({Key? key}) : super(key: key);

  @override
  State<TvShowsScreen> createState() => _TvShowsScreenState();
}

class _TvShowsScreenState extends State<TvShowsScreen> {
  List<TvModel>tvShowsDetails = [];

  // Future<void>fetchTvShows() async{
  //   ApiService api = ApiService();
  //   List<TvModel>list = await api.getTvData();
  //  // tvShowsDetails = list;
  //
  //   setState(() {
  //     tvShowsDetails = list;
  //   });
  // }

  void handleMenuItemSelected(int value){
    if(value==1){
      tvShowsDetails.sort((a,b) {
         final ratingA = a.voteAverage ?? 0.0;
         final ratingB = b.voteAverage ?? 0.0;

         return ratingB.compareTo(ratingA);
      });

      setState(() {

      });
    }
    else{
      tvShowsDetails.sort((a,b){
        final firstAirDateA = a.firstAirDate ?? "";
        final firstAirDateB = b.firstAirDate ?? "";

        return firstAirDateB.compareTo(firstAirDateA);
      });

      setState(() {

      });
    }
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   fetchTvShows();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(text: "Tv Shows",
      onMenuItemSelected: handleMenuItemSelected,),
        // body:GridView.builder(
        //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //         crossAxisCount: 1
        //     ),
        //     itemCount: tvShowsDetails.length,
        //     itemBuilder: (context,index){
        //       return GestureDetector(
        //         onTap: (){
        //           Navigator.of(context).push(
        //               MaterialPageRoute(
        //                   builder: (context) => TvShowDetails(tvShow: tvShowsDetails[index])
        //               ));
        //         },
        //         child: Card(
        //           elevation: 5,
        //           color: Colors.grey,
        //           shadowColor: Colors.redAccent,
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(20),
        //           ),
        //           margin: EdgeInsets.all(8),
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             children: [
        //               Container(
        //                 width: double.maxFinite,
        //                 height: 200,
        //                 child: Image.network(
        //                   'https://image.tmdb.org/t/p/w500/${tvShowsDetails[index].backdropPath}',
        //                   fit: BoxFit.cover,
        //                 ),
        //               ),
        //               SizedBox(height: 10,),
        //               Text("Name: ${tvShowsDetails[index].name}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        //               SizedBox(height: 10,),
        //               Text("Rating: ${tvShowsDetails[index].voteAverage}",style: TextStyle(fontSize:16)),
        //               SizedBox(height: 10,),
        //               Text("Release Date: ${tvShowsDetails[index].firstAirDate}",style: TextStyle(fontSize:16))
        //             ],
        //           ),
        //         ),
        //       );
        //
        //     }
        //
        // )
      body: Consumer(
        builder: (context,ref,child){
          final tvShowsProivder = ref.watch(tvShowsProvider);
          return tvShowsProivder.when(
              data: (tvShowsDetails){
                return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1
                        ),
                        itemCount: tvShowsDetails.length,
                        itemBuilder: (context,index){
                          return GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => TvShowDetails(tvShow: tvShowsDetails[index])
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
                                      'https://image.tmdb.org/t/p/w500/${tvShowsDetails[index].backdropPath}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text("Name: ${tvShowsDetails[index].name}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 10,),
                                  Text("Rating: ${tvShowsDetails[index].voteAverage}",style: TextStyle(fontSize:16)),
                                  SizedBox(height: 10,),
                                  Text("Release Date: ${tvShowsDetails[index].firstAirDate}",style: TextStyle(fontSize:16))
                                ],
                              ),
                            ),
                          );

                        }

                    );
              },
              error: (error,stackTrace){
                print(stackTrace);
                return Center(child: Text('$error\n $stackTrace'),);
              },
              loading: (){
                return CircularProgressIndicator();
              });
        },),

    );
  }
}
