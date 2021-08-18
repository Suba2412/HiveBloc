import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:myhivebloc/main.dart';
import 'api/simple_response.dart';
import 'bloc/my_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}
class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ResponseBloc>(context).add(ResponseEvent());
  }

  BlocApi? blocApiModel;
  @override
  Widget build(BuildContext context) {

    Widget myContent(MyApiState state){
      if(blocApiModel==null){
        return Container();
      }else
      return ListView.builder(
        itemCount: 1,
          itemBuilder: (BuildContext context, int index){
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                    ),
                    Text("ID: ${blocApiModel!.id.toString()}", style: TextStyle(fontSize: 20),),
                    SizedBox(
                      height: 10,
                    ),
                    Text("User ID: ${blocApiModel!.userId.toString()}",style: TextStyle(fontSize: 20,),),
                    SizedBox(
                      height: 10 ,
                    ),
                    Text("Title: ${blocApiModel!.title.toString()}", style: TextStyle(fontSize: 20),),
                    SizedBox(
                      height:50 ,
                    ),
                    Center(
                      child: FloatingActionButton(onPressed:(){
                        var box = Hive.box("mybox");
                        box.put("myBox", blocApiModel!.title);
                        String data = box.get("myBox");
                        Fluttertoast.showToast(
                            msg: "$data",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.black,
                            fontSize: 16.0
                        );
                      },
                        child: Text("store",style: TextStyle(fontSize: 15),),

                      ),
                    ),
                  ],
                ),
              ),
            );
          }
      );
    }
    return BlocConsumer<ResponseBloc, MyApiState>(
      builder: (context, state){
      return Scaffold(
        body: SafeArea(child:
        (state is Loading)? Center(child: CircularProgressIndicator()) :
        (state is Loaded) ? myContent(state) :
        (state is Error) ? Center(child: Text(state.error)) :Container()
        ),


        //how to cretee a hive adapter using terminal
      );
    },
      listener: (context, state) {
        if(state is Loaded){
          blocApiModel = state.blocApiModel!;
          //HiveData(box!).addResponseDetails(blocApiModel!.id);
        }
      },
    );
  }
}
