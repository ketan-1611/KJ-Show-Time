import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget{
  final String text;
  final Function(int)? onMenuItemSelected;
  CustomAppbar({Key? key,required this.text,this.onMenuItemSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.redAccent,
      leading: text=="Show Time" ?
      null : IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.white,)
      ),
      title: Text(text,
        style: TextStyle(
            color: Colors.white,
            fontSize: 18
        ),
      ),
      actions: [
        if(text=="Movies" || text=="Tv Shows")
          PopupMenuButton(
            onSelected: onMenuItemSelected,
              color: Colors.white,
              itemBuilder: (context){
                return [
                  PopupMenuItem(
                    child: Text("High Rating"),
                    value: 1,
                    // onTap: (){
                    //
                    //   print("Hello");
                    // },
                  ),
                  PopupMenuItem(
                      child: Text("Release Date"),
                      value: 2,
                      // onTap: (){
                      //   print("j");
                      // },
                  ),
                ];
              })
      ],

    );

  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
