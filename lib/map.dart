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
      name: "Juzgados",
      points: [
        LatLng(43.352013, -8.406989),
        LatLng(43.357186, -8.405929),
        LatLng(43.357519, -8.407758),
        LatLng(43.354900, -8.411033)
      ],
      estado: Estados(texto: 'NaN', value: 0, color: Colores.gris, time: DateTime.now()),
    ),
    Area(
      name: "cc",
      points: [
        LatLng(43.358008, -8.405575),
        LatLng(43.351803, -8.406835),
        LatLng(43.351674, -8.403607),
        LatLng(43.355533, -8.401042),
      ],
      estado: Estados(texto: 'NaN',value: 0, color: Colores.gris,time: DateTime.now()),
    ),
    Area(
      name: "Universidad",
      points: [
        LatLng(43.33293215692912, -8.41229075004498),
        LatLng(43.335548011418524, -8.415479539477156),
        LatLng(43.334949075172545, -8.416469763023505),
        LatLng(43.33460570762639, -8.416519596702322),
        LatLng(43.332325816451245, -8.41400983926626),
        LatLng(43.33130996803137, -8.413974728593459),
        LatLng(43.33029397646857, -8.41356821576917),
        LatLng(43.33029397646857, -8.412244443238787),
        LatLng(43.33237130743383, -8.411602032522362),
        LatLng(43.33285625634265, -8.410164771243146),
        LatLng(43.33298505357639, -8.40953254292471),
        LatLng(43.33284147407765, -8.409214357102764),
        LatLng(43.333440336159484, -8.408183155419103),
        LatLng(43.33430346144314, -8.409513538949213),
      ],
      estado: Estados(texto: 'NaN', value: 0, color: Colores.gris, time: DateTime.now()),
    ),
    Area(
      name: "Coliseum",
      points: [
        LatLng(43.34128260244388, -8.410218651738646),
        LatLng(43.33993269424227, -8.412364418916098),
        LatLng(43.33971420916805, -8.412300045900777),
        LatLng(43.33868419751412, -8.41106622977374),
        LatLng(43.337583938485544, -8.409725125284039),
        LatLng(43.338333053177244, -8.409038479787252),
        LatLng(43.33756833183119, -8.407278950701741),
        LatLng(43.33816138187667, -8.406216795948904),
        LatLng(43.34028382931498, -8.407321866045292),
        LatLng(43.340408676861486, -8.40915649698408),
      ],
      estado: Estados(texto: 'NaN', value: 0, color: Colores.gris, time: DateTime.now()),
    ),
    Area(
      name: "As lagoas",
      points: [
        LatLng(43.38216673259682, -8.409120644473179),
        LatLng(43.38209512479938, -8.409362481717777),
        LatLng(43.38130092347766, -8.409120644498072),
        LatLng(43.380851739427804, -8.408556357645333),
        LatLng(43.38081267978217, -8.40859218537727),
        LatLng(43.379732019781734, -8.407597965693817),
        LatLng(43.3792502735629, -8.407159075919546),
        LatLng(43.37966040908811, -8.406764970820772),
        LatLng(43.37998591150295, -8.407096377369022),
        LatLng(43.380480671827435, -8.407284472984491),
        LatLng(43.381691515571895, -8.408144338654548),
      ],
      estado: Estados(texto: 'NaN', value: 0, color: Colores.gris, time: DateTime.now()),
    ),
    Area(
      name: "Monte Alto",
      points: [
        LatLng(43.38005787005131, -8.40651913803735),
        LatLng(43.378468628610115, -8.407406437020505),
        LatLng(43.3765338436759, -8.40613886704457),
        LatLng(43.37595800290549, -8.403286834598717),
        LatLng(43.374783270777726, -8.40303332060353),
        LatLng(43.375451258504135, -8.400688316148052),
        LatLng(43.37694844564461, -8.399198921426327),
        LatLng(43.37913657573973, -8.398343311692573),
        LatLng(43.37950509514423, -8.398533447188962),
        LatLng(43.38169313297744, -8.400181288157677),
        LatLng(43.38125553172785, -8.404522715325253),
      ],
      estado: Estados(texto: 'NaN', value: 0, color: Colores.gris, time: DateTime.now()),
    ),
    Area(
      name: "B Flores",
      points: [
        LatLng(43.347360528171066, -8.40199713891262),
        LatLng(43.34652095115621, -8.403505707735272),
        LatLng(43.34626347854502, -8.4038443660424),
        LatLng(43.34456189296197, -8.405029670117342),
        LatLng(43.343543157715146, -8.405783954528669),
        LatLng(43.3429946008859, -8.404921915201436),
        LatLng(43.342815479215076, -8.40449089553782),
        LatLng(43.34303938122101, -8.402074106709692),
        LatLng(43.343352842642034, -8.39999597618869),
        LatLng(43.344741009479954, -8.399395627371511),
        LatLng(43.34644259004231, -8.400950376872409),
        LatLng(43.34692394957256, -8.401458364333099),
      ],
      estado: Estados(texto: 'NaN', value: 0, color: Colores.gris, time: DateTime.now()),
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
                          padding: const EdgeInsets.all(16.0),
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.4,
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
                                      'ult. actualización: ' + DateFormat('yyyy-MM-dd kk:mm').format(inside.estado.time),
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    const Spacer(),
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
                                    const Spacer(),
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
                                      onPressed: () {
                                          calificacion(1, inside);
                                          Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.car_repair_outlined,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      hoverColor: Colors.blueAccent.withOpacity(0.5),
                                      splashRadius: 15,
                                      onPressed: () {
                                        calificacion(2, inside);
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.car_repair_outlined,
                                        color: Colors.blueAccent,
                                        size: 30,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      hoverColor: Colors.yellowAccent.withOpacity(0.5),
                                      onPressed: () {
                                        calificacion(3, inside);
                                        Navigator.pop(context);
                                      },
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
                                      onPressed: () {
                                        calificacion(4, inside);
                                        Navigator.pop(context);
                                      },
                                      splashRadius: 15,
                                      icon: const Icon(
                                        Icons.car_repair_outlined,
                                        color: Colors.purple,
                                        size: 30,
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        calificacion(5, inside);
                                        Navigator.pop(context);
                                      },
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
            width: 150,
            height: 120,
            alignment: AlignmentDirectional.topEnd,
            color: Colors.white.withOpacity(0.8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:  [
                Row(
                  children: const [
                    Icon(
                  Icons.where_to_vote,
                  color: Colors.green,
                ),

                Text(
                  ' Libre         ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                  ],
                ),
               Row(
                 children: const [
                   Icon(
                     Icons.where_to_vote,
                     color: Colors.blueAccent,
                   ),
                   Text(
                   ' Casi vacio     ',
                   style: TextStyle(
                       fontSize: 20,
                       fontWeight: FontWeight.bold,
                       color: Colors.black54),
                 ),
               ]
               ),
               Row(
                 children: const[
                   Icon(
                     Icons.where_to_vote,
                     color: Colors.yellow,
                   ),
                   Text(
                     ' Medio lleno',
                     style: TextStyle(
                         fontSize: 20,
                         fontWeight: FontWeight.bold,
                         color: Colors.black54),
                   ),
                 ],
               ),
                Row(
                  children: const[
                    Icon(
                      Icons.where_to_vote,
                      color: Colors.purple,
                    ),
                    Text(
                      ' Casi lleno   ',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                  ],
                ),
                Row(
                  children: const[
                    Icon(
                      Icons.where_to_vote,
                      color: Colors.red,
                    ),
                    Text(
                      ' Lleno          ',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),
                    ),
                  ],
                )
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
        a.estado.time = DateTime.now();
        a.estado.value = puntos;
        a.estado.color = Colores.verde;
      });
    } else if (1 < puntos && puntos <= 2) {
      setState(() {
        a.estado.time = DateTime.now();
        a.estado.value = puntos;
        a.estado.color = Colores.azul;
      });
    } else if (2 < puntos && puntos <= 3) {
      setState(() {
        a.estado.time = DateTime.now();
        a.estado.value = puntos;
        a.estado.color = Colores.amarillo;
      });
    } else if (3 < puntos && puntos <= 4) {
      setState(() {
        a.estado.time = DateTime.now();
        a.estado.value = puntos;
        a.estado.color = Colores.granate;
      });
    } else if (4 < puntos && puntos <= 5) {
      setState(() {
        a.estado.time = DateTime.now();
        a.estado.value = puntos;
        a.estado.color = Colores.rojo;
      });
    }
  }
}
