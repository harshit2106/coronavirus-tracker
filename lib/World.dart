import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';

class World extends StatefulWidget {
  @override
  _WorldState createState() => _WorldState();
}

class _WorldState extends State<World> {


  Future  onRefresh() async{
    await Container(
      padding: EdgeInsets.all(10),
      child: FutureBuilder(

        future: datas,
        builder: (BuildContext context,AsyncSnapshot snapshot){

          if(snapshot.hasData)
          {print(snapshot.data);
            return  GridView.builder(
              

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0
              ),
              itemCount: 199,
              

              itemBuilder: (BuildContext context, index) => SizedBox(
                
                
                height : 50.0,
                width : 50.0,
               child: GestureDetector(
                  onTap: ()=> showcard(snapshot.data[index]['cases'].toString(),
                 snapshot.data[index]['todayDeaths'].toString(),
                 snapshot.data[index]['recovered'].toString(),
                 snapshot.data[index]['deaths'].toString()),

                child: Card(

               child: Container(color: Color(0xFF292929),
                 child : Center(
                  child: Column( 
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children : <Widget>[
                 Image(image: AssetImage("images/wdeath.png"),
                 height: 85,
                 width: 85
                 ,),

                 Padding(padding: EdgeInsets.all(10)),
                     
                  

                  Text(snapshot.data[index]['country'],style: TextStyle(fontSize: 18,color: Colors.white),),
                
                
                
                  ]
              ),)

            ),
              
              )
            )
            )
            );
             
            
            
          }
              return Center(
                child: CircularProgressIndicator(),
              );

        }


      )
          
        
      
    );
    
  }

 Future showcard (String ind,inter,recover,death) async
  {
     await showDialog(
        context: context,
        builder: (BuildContext contect)
        {
          return AlertDialog(
            backgroundColor: Color(0xFF363636),
            shape: RoundedRectangleBorder(),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                
                    Text("Total Cases :$ind",style: TextStyle(fontSize: 25,color : Colors.white),),
                    Text("Today's Deaths :$inter",style: TextStyle(fontSize: 25,color : Colors.red),),
                    Text("Total Recoveries :$recover",style: TextStyle(fontSize: 25,color : Colors.green),),
                    Text("Total Deaths :$death",style: TextStyle(fontSize: 25,color : Colors.red),),


                    
                  
                ],
              ),
            ),
          );
        }
      );
  }

 final String url = "https://corona.lmao.ninja/countries";
 Future <List>  datas;

 Future <List>  getData() async
{
  var response = await Dio().get(url);
   return response.data;
}


  
 @override
 void initState()
 {
   super.initState();
   datas = getData();
 }


@override
Widget build(BuildContext context)
{
  return Scaffold(
    appBar: AppBar(
      title: Text('Countrywise Statistics'),
        backgroundColor: Color(0xFF152238)
      
    ),
    backgroundColor: Colors.black,
    body: RefreshIndicator(
    child: Container(
      padding: EdgeInsets.all(10),
      child: FutureBuilder(

        future: datas,
        builder: (BuildContext context,AsyncSnapshot snapshot){

          if(snapshot.hasData)
          {print(snapshot.data);
            return  GridView.builder(
              

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0
              ),
              itemCount: 199,
              

              itemBuilder: (BuildContext context, index) => SizedBox(
                
                
                height : 50.0,
                width : 50.0,
               child: GestureDetector(
                  onTap: ()=> showcard(snapshot.data[index]['cases'].toString(),
                 snapshot.data[index]['todayDeaths'].toString(),
                 snapshot.data[index]['recovered'].toString(),
                 snapshot.data[index]['deaths'].toString()),

                child: Card(

               child: Container(color: Color(0xFF292929),
                 child : Center(
                  child: Column( 
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children : <Widget>[
                // Padding(padding: EdgeInsets.only(top :10)),
                    


                    Text('Total Cases:${snapshot.data[index]['cases'].toString()}',
                    style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold),),
                 Padding(padding: EdgeInsets.only(top :5)),


                 Image(image: AssetImage("images/wdeath.png"),
                 height: 85,
                 width: 85
                 ,),

                // Padding(padding: EdgeInsets.only(top :5)),
                     
                  

                  Text(snapshot.data[index]['country'],style: TextStyle(fontSize: 18,color: Colors.white),),
                
                
                
                  ]
              ),)

            ),
              
              )
            )
            )
            );
             
            
            
          }
              return Center(
                child: CircularProgressIndicator(),
              );

        }


      )
          
        
      
    ),
     onRefresh: ()=>onRefresh()  ,
    
    )
  );
}
}

















