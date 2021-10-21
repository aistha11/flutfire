import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutfire/getx_app/controllers/firebaseAuthController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeView extends GetResponsiveView<HomeController> {
  HomeView() : super(alwaysUseBuilder: false);

  @override
  Widget? phone() {
    return SafeArea(
      child: Scaffold(
         appBar: AppBar(
          title: Text("Memories"),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: Text("Sign Out"),
                leading: Icon(Icons.logout),
                onTap: (){
                  Get.find<FirebaseAuthController>().signOut();
                }
              )
            ],
          ),
        ),
        body: MemoriesList(),
      ),
    );
  }

  @override
  Widget? tablet() {
   return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Memories"),
        ),
        body: MemoriesList(),
      ),
    );
  }

  @override
  Widget? desktop() {
    return SafeArea(
      child: Scaffold(
        body: MemoriesList(),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text('home')),
  //     body: MemoriesList(),
  //   );
  // }
}

class MemoriesList extends StatelessWidget {
  final Stream<QuerySnapshot> _memoriesStream =
      FirebaseFirestore.instance.collection('memories').snapshots();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: _memoriesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          print(snapshot.data!.docs[0]['title'].toString());

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (_, i) {
              String id = snapshot.data!.docs[0].id;
              String title = snapshot.data!.docs[i]['title'].toString();
              String imgUrl = snapshot.data!.docs[i]['imgUrl'].toString();
              bool featured = snapshot.data!.docs[i]['featured'];
              Timestamp updateDate = snapshot.data!.docs[i]['updateDate'];
              GeoPoint geoPoint = snapshot.data!.docs[i]['geoLocation'];
              print(updateDate.toDate().year);
              print(geoPoint.latitude);
              print(geoPoint.longitude);
              print(id);
              return Card(
                elevation: featured ? 4 : 8,
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      width: 500,
                      child: Container(
                        child: Image.network(imgUrl),
                      ),
                    ),
                    Text(title),

                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
