import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:point_in_polygon/point_in_polygon.dart';
import 'package:intl/intl.dart';

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
  static final Color gris = Colors.grey.withOpacity(0.5);
  static final Color rojo = Colors.red.withOpacity(0.5);
  static final Color granate = Colors.purple.withOpacity(0.5);
  static final Color amarillo = Colors.yellow.withOpacity(0.5);
  static final Color azul = Colors.blueAccent.withOpacity(0.5);
  static final Color verde = Colors.green.withOpacity(0.5);
}

class Estados {
  Estados({required this.texto, required this.value, required this.color, required this.time});
  final String texto;
  double value;
  Color color;
  DateTime time;
}

class Area {
  const Area({required this.name, required this.points, required this.estado});
  final String name;
  final List<LatLng> points;
  final Estados estado;
}

class NewMap extends State<Map> {
  MapController mapController = MapController();
  LatLng center = LatLng(43.33356100440097, -8.409176083298943);
  double zoom = 13;

  var areas = [
    Area(
      name: "juzgados",
      points: [
        LatLng(43.352013, -8.406989),
        LatLng(43.357186, -8.405929),
        LatLng(43.357519, -8.407758),
        LatLng(43.354900, -8.411033)
      ],
      estado: Estados(texto: 'NaN', value: 0, color: Colors.grey, time: DateTime.now()),
    ),
    Area(
      name: "cc",
      points: [
        LatLng(43.358008, -8.405575),
        LatLng(43.351803, -8.406835),
        LatLng(43.351674, -8.403607),
        LatLng(43.355533, -8.401042),
      ],
      estado: Estados(texto: 'NaN', value: 0, color: Colors.grey, time: DateTime.now()),
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
      width: 30.0,
      height: 30.0,
      point: LatLng(43.33299391315873, -8.410923367239457),
      builder: (ctx) =>
          const Icon(Icons.my_location_outlined, color: Colors.blue, size: 20),
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
                          padding: EdgeInsets.all(16.0),
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: inside.estado.color,
                              width: 8,
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      DateFormat('yyyy-MM-dd kk:mm').format(inside.estado.time),
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    Spacer(),
                                    Align(
                                      alignment: Alignment.center,
                                        child: Row( children: [
                                            const Text(
                                              'Area: ',
                                              style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              inside.name,
                                              style: const TextStyle(
                                                fontSize: 30,
                                              ),
                                            ),
                                          ]
                                        ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  children: [
                                    IconButton(
                                      hoverColor: Colors.green.withOpacity(0.5),
                                      splashRadius: 15,
                                      onPressed: () => calificacion(1, inside),
                                      icon: const Icon(
                                        Icons.car_repair_outlined,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      hoverColor: Colors.blueAccent.withOpacity(0.5),
                                      splashRadius: 15,
                                      onPressed: () => calificacion(2, inside),
                                      icon: const Icon(
                                        Icons.car_repair_outlined,
                                        color: Colors.blueAccent,
                                        size: 30,
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      hoverColor: Colors.yellowAccent.withOpacity(0.5),
                                      onPressed: () => calificacion(3, inside),
                                      splashRadius: 15,
                                      icon: const Icon(
                                        Icons.car_repair_outlined,
                                        color: Colors.yellowAccent,
                                        size: 30,
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      hoverColor: Colors.purple.withOpacity(0.5),
                                      onPressed: () => calificacion(4, inside),
                                      splashRadius: 15,
                                      icon: const Icon(
                                        Icons.car_repair_outlined,
                                        color: Colors.purple,
                                        size: 30,
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      onPressed: () => calificacion(5, inside),
                                      hoverColor: Colors.red.withOpacity(0.5),
                                      splashRadius: 15,
                                      icon: const Icon(
                                        Icons.car_repair_outlined,
                                        color: Colors.red,
                                        size: 30,
                                        opticalSize: 50,
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            ],
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
                          color: a.estado.color,
                          disableHolesBorder: true,
                          isFilled: true,
                          borderColor: const Color(0xA0000000).withOpacity(0.5),
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
          Positioned(
            top: 0,
            right: 0,
            child: Container(
            width: 200,
            height: 120,
            alignment: AlignmentDirectional.topEnd,
            color: Colors.white.withOpacity(0.8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text(
                    'Verde = Libre         ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
               Text(
                    'Azul = Casi vacio     ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                Text(
                    'Amarillo = Medio lleno',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow),
                  ),
                Text(
                    'Morado = Casi lleno   ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple),
                  ),
                Text(
                    'Rojo = Lleno          ',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
              ],
            ),
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

  bool onlyNewAdd(Area area){
    // Solo evalua los datos de menos de hace un minuto
    DateTime viejo = area.estado.time.add(const Duration(minutes: 1));
    if (DateTime.now().compareTo(viejo) <= 0 && area.estado.value != 0){
      return false;
    }
    return true;
  }

  void calificacion(double puntos, Area a) {
    if (!onlyNewAdd(a)){
      puntos = (puntos + a.estado.value)/2;
    }
    if (0 < puntos && puntos <= 1) {
      setState(() {
        a.estado.value = puntos;
        a.estado.color = Colores.verde;
      });
    } else if (1 < puntos && puntos <= 2) {
      setState(() {
        a.estado.value = puntos;
        a.estado.color = Colores.azul;
      });
    } else if (2 < puntos && puntos <= 3) {
      setState(() {
        a.estado.value = puntos;
        a.estado.color = Colores.amarillo;
      });
    } else if (3 < puntos && puntos <= 4) {
      setState(() {
        a.estado.value = puntos;
        a.estado.color = Colores.granate;
      });
    } else if (4 < puntos && puntos <= 5) {
      setState(() {
        a.estado.value = puntos;
        a.estado.color = Colores.rojo;
      });
    }
  }
}
