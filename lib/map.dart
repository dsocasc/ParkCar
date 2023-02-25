import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:point_in_polygon/point_in_polygon.dart';

import 'main.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map',
      theme: ThemeData(
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

class Colores {
  static final Color gris = Colors.grey;
  static final Color rojo = Colors.red;
  static final Color granate = Colors.purple;
  static final Color amarillo = Colors.yellow;
  static final Color azul = Colors.blueAccent;
  static final Color verde = Colors.green;
}

class Estados {
  const Estados({required this.texto, required this.color});
  final String texto;
  final Color color;
}

class Area {
  const Area({required this.name, required this.points,
    required this.estado});
  final String name;
  final List<LatLng> points;
  final Estados estado;
}

class NewMap extends State<Map> {
  MapController mapController = MapController();
  LatLng center = LatLng(43.33356100440097, -8.409176083298943);
  double zoom = 13;

  Estados completo = Estados(texto: 'Completo', color: Colores.rojo);
  Estados pseudocompleto = Estados(texto: 'Casi lleno', color: Colores.granate);
  Estados medio = Estados(texto: 'Medio lleno', color: Colores.amarillo);
  Estados pseudovacio = Estados(texto: 'Casi vacío', color: Colores.azul);
  Estados vacio = Estados(texto: 'Vacío', color: Colores.verde);
  Estados sininfo = Estados(texto: 'NaN', color: Colores.gris);

  var areas = [
    Area(name: "juzgados", points: [
      LatLng(43.352013, -8.406989),
      LatLng(43.357186, -8.405929),
      LatLng(43.357519, -8.407758),
      LatLng(43.354900, -8.411033)],
      estado: sininfo,
    ),
    Area(name: "cc", points: [
      LatLng(43.358008, -8.405575),
      LatLng(43.351803, -8.406835),
      LatLng(43.351674, -8.403607),
      LatLng(43.355533, -8.401042),],
      estado: sininfo,
    ),
  ];



  Point latLngToPoint(LatLng latlng) {
    return Point(x: latlng.latitude, y: latlng.longitude);
  }

  Area? whichInside(LatLng point) {
    for (var area in areas) {
      if (Poly.isPointInPolygon(latLngToPoint(point),
          area.points.map((p) => latLngToPoint(p)).toList())) {
        return area;
      }
    }
  }

  List<Marker> markers = [
    Marker(
      width: 50.0,
      height: 50.0,
      point: LatLng(43.33299391315873, -8.410923367239457),
      builder: (ctx) =>
          const Icon(Icons.location_on, color: Colors.blue, size: 40),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: ElevatedButton(
        child: const Icon(
          Icons.arrow_left,
          size: 60,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyApp()),
          );
        },
      )),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: center,
              zoom: zoom,
              onTap: (x, latlng) {
                var inside = whichInside(latlng);
                if (inside != null) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                              width: 8,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(inside.name),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
            nonRotatedChildren: areas
                .map((a) => PolygonLayer(
                      polygonCulling: false,
                      polygons: [
                        Polygon(
                          points: a.points,
                          borderStrokeWidth: 2,
                          color: const Color(0x6000FF00),
                          disableHolesBorder: true,
                          isFilled: true,
                          borderColor: const Color(0xA0000000),
                        ),
                      ],
                    ))
                .toList(),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: markers,
              )
            ],
          ),
          const Positioned(
            top: 0,
            right: 0,
            child: Text(
              'Verde = Libre         ',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
          ),
          const Positioned(
            top: 22,
            right: 0,
            child: Text(
              'Azul = Casi vacio     ',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
          ),
          const Positioned(
            top: 44,
            right: 0,
            child: Text(
              'Amarillo = Medio lleno',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow),
            ),
          ),
          const Positioned(
            top: 66,
            right: 0,
            child: Text(
              'Morado = Casi lleno   ',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple),
            ),
          ),
          const Positioned(
            top: 88,
            right: 0,
            child: Text(
              'Rojo = Lleno          ',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.gps_fixed),
        onPressed: () {
          mapController.move(LatLng(43.33299391315873, -8.410923367239457), 18);
          setState(() {
            center = LatLng(40.7128, -74.0060);
            zoom = 18;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
