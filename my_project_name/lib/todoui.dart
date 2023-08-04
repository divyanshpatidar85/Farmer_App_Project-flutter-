import 'package:flutter/material.dart';

import 'dbhelper.dart';
import 'package:flutter/src/rendering/box.dart';

class todoui extends StatefulWidget {
  @override
  _todouiState createState() => _todouiState();
}

class _todouiState extends State<todoui> {
  final dbhelper = Databasehelper.instance;
  final time = TextEditingController();
  final texteditingcontroller = TextEditingController();
  final texteditingcontrollerD = TextEditingController();
  final price =TextEditingController();
  var nprice =TextEditingController();
  bool validated = true;
  String errtext = "";
  String todoedited = "";
  int temp=0;
  int ? desc=0;
  double ? hour=0;
  int ? minitue=0;
  int? price_value=0;
  double ? newprice=0;
  
  var myitems = [];
  List<Widget> nayan = <Widget>[];
  

  void addtodo() async {
   print('bahi=>$minitue');
    print('hello=> $hour');
    Map<String, dynamic> row = {
      Databasehelper.columnName: todoedited,
      Databasehelper.columnDescription: (hour!*price_value!),
      Databasehelper.columnTime:hour,
    };
    final id = await dbhelper.insert(row);
    Navigator.pop(context);
    todoedited = "";
    hour=0;
    minitue=0;
    // price_value=0;
    validated = true;
    errtext = "";
    setState(() {
      
    });
   
  }

  Future<bool> query() async {
    myitems = [];
    nayan = [];
    int i=0;
    var allrows = await dbhelper.queryall();
    
    allrows?.forEach((row) {
       print('price => ${row['des']}');
    // print('hello=> $hour');
      myitems.add(row.toString());
      // print('dekh lo bhai ${allrows.elementAt(i)['time']}');
      i++;
     nayan.add(Card(
        elevation: 5.0,
        margin: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 5.0,
        ),
        child: Container(
          padding: EdgeInsets.all(5.0),
         
          child: ListTile(
            title: Text(
              row['todo'],
              style: TextStyle(
                color:Colors.black,
                fontSize: 25.0,
                fontFamily: "Raleway",
                fontWeight:FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                Text(
                  "Time : ${row['time']} hour",
                  style: TextStyle(
                     color:Colors.black,
                    fontSize: 20.0,
                    fontFamily: "Raleway",
                  ),
                ),
                Text(
                  "Cost : ${row['des']} Rs",
                  style: TextStyle(
                     color:Colors.black,
                    fontSize: 20.0,
                    fontFamily: "Raleway",
                  ),
                ),
              ],
            ),
          trailing:SingleChildScrollView(
            scrollDirection:Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                 InkWell(
                  onTap:(){
                    showSimpleDialog(context,row['id'],row['des']);
                    setState((){});
                    },
                 child:Icon(Icons.edit,color:Colors.black,),
                  ),
                  SizedBox(width: 20,),
                   InkWell(
                  onTap:(){
                    dbhelper.deletedata(row['id']);
                    setState(() {});
                    } ,
                 child:Icon(Icons.delete,color:Colors.black,),
                  ),
            ],),
          )
           
          ),
          color:Colors.white,
        ),
      ));
    }
  );
    return Future.value(true);
  }

  void showalertdialog() {
    texteditingcontroller.text = "";
    texteditingcontrollerD.text = "";
    time.text="";
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor:Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                
              ),
              title: Text(
                "Add Task",
                style: TextStyle(color:Colors.black,fontWeight:FontWeight.bold),
               
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: texteditingcontroller,
                    autofocus: true,
                   
                    
                    onChanged: (texteditingcontroller) {
                      todoedited = texteditingcontroller;
                    },
                    style: TextStyle(
                      color:Colors.black,
                      fontSize: 18.0,
                      fontFamily: "Raleway",
                    ),
                    decoration: InputDecoration(
                      errorText: validated ? null : errtext,
                       hintText:'Enter the name of person',
                      hintStyle:TextStyle(
                        color:Colors.black,
                      )
                    ),
                  ),
                   TextField(
                    controller:time,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    decoration: InputDecoration(
                     hintText:'hour',
                     hintStyle:TextStyle(
                      color:Colors.black
                     )
                     
                      
                     
                     
                    ),
                      onChanged: (texteditingcontrollerD) {
                                  
             hour = double.parse(time.text);
                       print('my god ${time.text} and $hour');
             








                    },
                    style: TextStyle(
                      color:Colors.black,
                      fontSize: 18.0,
                      fontFamily: "Raleway",
                    ),
                   ),
                    TextField(
                    controller: texteditingcontrollerD,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    decoration: InputDecoration(
                     hintText:'Minutes',
                      hintStyle:TextStyle(
                      color:Colors.black
                     ),
                    ),
                    //  onChanged: (_) => _updateHour(),,
                      onTapOutside: (textediting) {
                      minitue = int.parse(texteditingcontrollerD.text);
                      if(time.text.isEmpty){
                        hour=0;
                      hour=(hour!+((1.6666*minitue!)/100));
                      }else{
                        
                      hour=(hour!+(((1.6666*minitue!)+.1)/100));
                      print('divyNAH => $hour');
                      hour=double.parse(hour!.toStringAsFixed(2));
                     
                      }
                    },
                   style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: "Raleway",
                     color:Colors.black,
                    ),
                    
                  ),
                   TextField(
                     controller: price,
                     keyboardType:TextInputType.number,
                     onChanged: (s) {
                       price_value = int.parse(
                         price.text);
                    
                    },
                     style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: "Raleway",
                      fontWeight:FontWeight.bold,
                        color:Colors.black,
                    ),
                     decoration:
                        InputDecoration(
                                    hintText: 'Enter The rate of one hour',
                                    hintStyle:TextStyle(
                      color:Colors.black
                     ),
                             ),
                   ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            if (texteditingcontroller.text.isEmpty &&texteditingcontrollerD.text.isEmpty && time.text.isEmpty) {
                              setState(() {
                                errtext = "Can't Be Empty";
                                validated = false;
                              });
                            } else if (texteditingcontroller.text.length >
                                512 ) {
                              setState(() {
                                errtext = "Too may Chanracters";
                                validated = false;
                              });
                            } else {
                               setState((){});
                              addtodo();
                             
                            }
                          },
                          // color: Colors.purple,
                          child: Text("ADD",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: "Raleway",
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
     builder: (context, snap) {
        if (snap.hasData == null) {
          return Center(
            child: Text(
              "No Data",
            ),
          );
        } else {
          if (myitems.length == 0) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: showalertdialog,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: Colors.purple,
              ),
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                title: Text(
                  "My Tasks",
                  style: TextStyle(
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.bold,
                    color:Colors.black
                  ),
                ),
              ),
              backgroundColor:Colors.white,
              body: Center(
                child: Text(
                  "No Task Avaliable",
                  style: TextStyle(fontFamily: "Raleway",fontWeight:FontWeight.bold,
                  fontSize: 20.0,color:Colors.black),
                ),
              ),
            );
          } else {
            return Scaffold(
             
              floatingActionButton: FloatingActionButton(
                onPressed: showalertdialog,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: Colors.purple,
              ),
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                title: Text(
                  "My Tasks",
                  style: TextStyle(
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.bold,
                    color:Colors.black
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              body:SingleChildScrollView(
                   child: Column(
                    
                     children:nayan,
                    
                    ),
                  ),
                  
                
                
             
             
            );
          }
        }
      },
      future: query(),
    );
  }
  
 showSimpleDialog(BuildContext context,int id,double amt)  {
  showDialog(context: context,  builder: (context) {
    nprice.text="";
    print('id bhai is => $id');
   return AlertDialog(
    backgroundColor:Colors.white,
    title:Text('Enter the amount which did he give you',style:TextStyle(
      color:Colors.black,
      fontWeight:FontWeight.bold
    ),),
     content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                     keyboardType: TextInputType.number,
                     controller: nprice,
                     style:TextStyle(color:Colors.black),
                     decoration:InputDecoration(
                      hintText:'eg. total cost is 1250 and he gave you 250 than upadated cost is 1000 (here enter 250)',
                      hintStyle:TextStyle(
                        color:Colors.black,
                        fontWeight:FontWeight.bold

                      ),
                     ),
                     
                     onChanged:(on){
                        newprice= double.parse(
                         nprice.text);
                         // ignore: prefer_is_not_empty
                         if(!(nprice.text.isEmpty) ){
                          print('ram  $newprice \n');
                            newprice=amt-newprice!;
                            // nprice.clear()s
                          }
                         else{ 
                          print('heelo --> $newprice');
                          newprice=amt;
                          }
                     },
                  ),
                  // MovingHintText(),
                  TextButton(
                    
                    onPressed: ()   {
                      // print()
                      if(newprice!=0){
                   Future<int?> k=  dbhelper.updatedata(id,newprice!);
                      }
                     Navigator.pop(context);
                    //  newprice=0;
                     setState(() {
                      
                     });
                  }, child:Text('Submit')),
                ]
     )
    
    

  );
}

) ;
}

}







   
    
 
 
 
