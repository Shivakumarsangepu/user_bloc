import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_list_bloc/modules/home/models/home_page_response.dart';
import 'package:users_list_bloc/modules/home/screens/home_bloc.dart';
import 'package:users_list_bloc/modules/home/screens/home_event.dart';
import 'package:users_list_bloc/modules/utils/base_state.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final HomeBloc _bloc = HomeBloc(initialState: Loading());
  HomePageResponse response = HomePageResponse();

  @override
  void initState() {
    callHomePageAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
          onPressed: () {  },
      child: const Icon(Icons.add,color: Colors.white,)),
      appBar: AppBar(
        elevation: 0.0,
        title: const Center(child: Text('Random Users',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),)),
        backgroundColor: Colors.grey.withOpacity(0.08),
      ),
      body:  BlocProvider(
          create: (_) => _bloc,
          child: BlocBuilder<HomeBloc, BaseState>(builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is DataLoaded) {
              if (state.event == "GetHomePageDetails") {
                response = state.data;
              }
            }
            if (state is Error) {
              return const Center(
                child: Text(
                  'error',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                ),
              );
            }
            return userDetailsWidget();
          })),
    );
  }

  userDetailsWidget(){
    return RefreshIndicator(
      onRefresh: () async {
       callHomePageAPI();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: response.results!=null && response.results!.isNotEmpty?response.results!.length:0,
            itemBuilder: (context , index){
              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height/3.4,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            response.results![index].picture.large,
                            height: 180.0,
                            width: 120.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 14,),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Text(''
                                  '${response.results![index].name.first} ${response.results![index].name.last}',
                                style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                              const SizedBox(),
                              const Text('Country',style: (TextStyle(fontSize: 10,color: Colors.grey)),),
                              Text(response.results![index].location.country,style: const TextStyle(fontWeight: FontWeight.w500,),),
                              const SizedBox(),
                              const Text('Email',style: (TextStyle(fontSize: 10,color: Colors.grey)),),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Text(response.results![index].email,style: const TextStyle(fontWeight: FontWeight.w500),)),
                              const SizedBox(),
                              const Text('D.O.B',style: (TextStyle(fontSize: 10,color: Colors.grey)),),

                              Text(getActualTime(response.results![index].dob.date,).toString(),style: const TextStyle(fontWeight: FontWeight.w500),),
                              const SizedBox(),
                              const Text('Id number',style: (TextStyle(fontSize: 10,color: Colors.grey)),),
                              Text('${response.results![index].id.name}${response.results![index].id.value!=null ?response.results![index].id.value!.replaceAll(('-'), '').trim():"N/A"}',style: const TextStyle(fontWeight: FontWeight.w500),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Divider(
                            color: Colors.grey.shade400,thickness: 1.5,)))

                ],
              );
            }
        ),
      ),
    );
  }

  String getActualTime(DateTime dateTime) {
    final format = DateFormat("dd.MM.yyyy");
    String time = format.format(dateTime);
    return time;
  }

  callHomePageAPI(){
    _bloc.add(GetHomePageDetails(num: 5));
  }
}
