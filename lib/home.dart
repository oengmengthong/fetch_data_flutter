import 'package:cached_network_image/cached_network_image.dart';
import 'package:fetch_data_flutter/api/requestData.dart';
import 'package:fetch_data_flutter/model/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeUI();
  }
}

class HomeUI extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text('Contributor Flutter'), centerTitle: true),
      body: FutureBuilder(
        future: ApiDatas.loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return _buildErrorWidget();
            } else {
              return _buildDatasListView(snapshot.data);
            }
          } else {
            return _buildLoadingWidget();
          }
        },
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: SpinKitCubeGrid(
        color: Colors.teal,
        size: 50.0,
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Text('Load data error.'),
    );
  }

  Widget _buildDatasListView(List<Datas> datas) {
    return ListView.builder(
      itemCount: datas.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: CachedNetworkImage(
                  imageUrl: datas[index].profile_pic,
                  imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover))),

                  ),
            ),
            title: Text('Name: ' + datas[index].name),
          ),
        );
      },
    );
  }


}
