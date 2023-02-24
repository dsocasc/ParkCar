import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'main.dart';

class MapPage extends StatelessWidget {

  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Map(title: 'AppParkCar'),
    );
  }

}

class Map extends StatefulWidget {

  const Map({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => NewMap();


}

class NewMap extends State<Map> {
  MapController mapController = MapController();
  LatLng center = LatLng(43.3713500, -8.3960000);
  double zoom = 14.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: ElevatedButton(
            child: const Icon(Icons.arrow_left,size: 50,),
            onPressed: () {
                Navigator.push(
                context,

                MaterialPageRoute(builder: (context) => const MyApp()),
                );
              },
            )
        ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: center,
          zoom: zoom,
        ),
        nonRotatedChildren: [
          PolygonLayer(
            polygonCulling: false,
            polygons: [
              Polygon(
                points: [LatLng(43.352013, -8.406989), LatLng(43.357186, -8.405929), LatLng(43.357519, -8.407758),LatLng(43.354900, -8.411033)],
                borderStrokeWidth: 2,
                color: const Color(0x6000FF00),
                disableHolesBorder: true,

                isFilled: true,
                borderColor: const Color(0xA0000000),
              ),
            ],

          ),
        ],
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          ElevatedButton(
            child: const Text('Go back'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.gps_fixed),
        onPressed: () {
          mapController.move(LatLng(43.33299391315873, -8.410923367239457), 17);
          setState(() {
            center = LatLng(40.7128, -74.0060);
            zoom = 17;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,);

  }
}
