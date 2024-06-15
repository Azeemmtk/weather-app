import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:wheather/utils/constants.dart';
import 'package:wheather/utils/network_errors.dart';

import '../model/weather_model.dart';
import '../widgets/status.dart';

class Whether extends StatefulWidget {
  const Whether({super.key});
  @override
  State<Whether> createState() => _WhetherState();
}

class _WhetherState extends State<Whether> {
  double? lat;
  double? longt;
  int? dt;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services'),
        ),
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location permissions are denied'),
          ),
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.'),
        ),
      );
      return false;
    }
    return true;
  }

  void getlocation() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    print(position);
    lat = position.latitude;
    longt = position.longitude;

    setState(() {});
  }

  Future<Weathermodel> Weather() async {
    if (lat != null || longt != null) {
      var data = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$longt&appid=$apikey'),
      );
      var decoded = jsonDecode(data.body);
      dt = decoded['dt'];

      Weathermodel weatherr = Weathermodel.fromJson(decoded);
      return weatherr;
    } else {
      throw Exception('error');
    }
  }

  Future<Weathermodel> Locations() async {
    var data = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=${locationname.trim()}&appid=$apikey'),
    );
    var decoded = jsonDecode(data.body);
    print(data.statusCode);
    print(data.body);
    if (data.statusCode == 200) {
      dt = decoded['dt'];
      Weathermodel weatherr = Weathermodel.fromJson(decoded);
      return weatherr;
    } else {
      throw error(data);
    }
  }

  TextEditingController location = TextEditingController();
  String locationname = '';

  @override
  void initState() {
    getlocation();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: lat == null || longt == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : FutureBuilder<Weathermodel>(
                future: locationname.isEmpty ? Weather() : Locations(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                            dt! * 1000,
                            isUtc: true)
                        .toLocal();
                    String formattedDate =
                        DateFormat('hh:mm a - EEEE, d MMM ‘yy')
                            .format(dateTime);
                    int currentHour = dateTime.hour;
                    String backgroundImage =
                        currentHour >= 6 && currentHour < 18
                            ? 'assets/images/day.png'
                            : 'assets/images/night.png';

                    return Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                          child: Image.asset(
                            backgroundImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 40,
                          right: 10,
                          child: SizedBox(
                            width: 200,
                            height: 70,
                            child: TextFormField(
                              controller: location,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    locationname = location.text;
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                hintText: 'Search Location...',
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 140,
                          left: 10,
                          child: Text(
                            '${((snapshot.data!.main?.temp)! - 273.15).toStringAsFixed(1)}°',
                            style: TextStyle(
                                color: Colors.white,
                                // fontWeight: FontWeight.bold,
                                fontSize: 90),
                          ),
                        ),
                        Positioned(
                          top: 250,
                          left: 20,
                          child: Text(
                            '${snapshot.data!.name}',
                            style: TextStyle(
                                color: Colors.white,
                                // fontWeight: FontWeight.bold,
                                fontSize: 40),
                          ),
                        ),
                        Positioned(
                          top: 295,
                          left: 22,
                          child: Text(
                            formattedDate,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        Positioned(
                          top: 340,
                          child: Container(
                            height: 575,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Color(0xFF688180).withOpacity(.4),
                            ),
                            // child: BackdropFilter(
                            //   filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            //   child: Container(
                            //     height: 100,
                            //     width: 100,
                            //     decoration:
                            //         BoxDecoration(color: Colors.white.withOpacity(0)),
                            //   ),
                            // ),
                          ),
                        ),
                        Positioned(
                          top: 390,
                          left: 25,
                          child: Text(
                            '${snapshot.data!.weather![0].main}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 428,
                          left: 35,
                          child: Text(
                            '${snapshot.data!.weather![0].description}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 330,
                          right: 10,
                          child: Container(
                            height: 170,
                            width: 170,
                            child: CloudChange(
                                snapshot.data!.weather![0].description ?? 'ggg',
                                currentHour),
                          ),
                        ),
                        Positioned(
                          top: 500,
                          child: Statuses(
                            data:
                                '${((snapshot.data!.main?.tempMax)! - 273.15).toStringAsFixed(1)}°',
                            name: 'Temp max',
                            icons: Icons.thermostat_outlined,
                            color: Color(0xFFDFA1A1),
                          ),
                        ),
                        Positioned(
                          top: 550,
                          child: Statuses(
                            data:
                                '${((snapshot.data!.main?.tempMin)! - 273.15).toStringAsFixed(1)}°',
                            name: 'Temp min',
                            icons: Icons.thermostat_outlined,
                            color: Color(0xFF6D97CA),
                          ),
                        ),
                        Positioned(
                            top: 600,
                            child: Statuses(
                                data:
                                    '${((snapshot.data!.main?.humidity))!.toStringAsFixed(1)}%',
                                name: 'Humidity',
                                icons: Icons.water_drop_outlined,
                                color: Colors.white)),
                        Positioned(
                            top: 650,
                            child: Statuses(
                                data:
                                    '${((snapshot.data!.clouds?.all))!.toStringAsFixed(1)}%',
                                name: 'Cloudy',
                                icons: Icons.wb_cloudy_outlined,
                                color: Colors.white)),
                        Positioned(
                            top: 700,
                            child: Statuses(
                              data:
                                  '${((snapshot.data!.wind?.speed))!.toStringAsFixed(1)}Km/h',
                              name: 'Wind',
                              icons: CupertinoIcons.wind,
                              color: Colors.white,
                            )),
                        Positioned(
                            bottom: 50,
                            left: 50,
                            child: Container(
                              height: 2,
                              width: 300,
                              decoration: BoxDecoration(color: Colors.white),
                            )),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Lottie.asset(
                            'assets/images/Animation - 1718432001922.json'),
                        Text('${snapshot.error}'),
                        SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              locationname = '';
                              setState(() {});
                            },
                            child: Text('Re-search...'))
                      ],
                    ));
                  }
                  return CircularProgressIndicator();
                },
              ));
  }
}
