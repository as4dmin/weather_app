import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:weather_app/hourly_forcast_item.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  @override
  void initState(){
    super.initState();
    getCurrentWeather();
  }

  Future getCurrentWeather() async{
    try{
      String cityName='London';
      final res =await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&APPID=$openWeatherAPIKey'
        ),
    );

    final data = jsonDecode(res.body);
    print(data['cod']);
    print(data['list'][0]['main']['temp']);

    if (data['cod'] == '200') {
        print(data['list'][0]['main']['temp']);
      } else {
        print('zzzzzzzzzzzzzzzzz');
        print('An error occurred: ${data['message']}');
        throw 'An error occurred: ${data['message']}';
      }

    // if(data['cod'] != '200'){
    //   print('zzzzzzzzzzzzzzzzz');
    //   throw 'An error occur55655';
    // }
    
    print(data['list'][0]['main']['temp']);
    print('object');

  } catch (e) {
    throw e;
  }   
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text('Weather App',
        style: TextStyle(
          fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        actions:[
          IconButton(
            onPressed: (){
              print('sdfasdfasdfasdfasdfasdfasdfasdfsdf');
          }, icon:const  Icon(Icons.refresh))
        ],
      ),
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //main card
            SizedBox(
              width: double.infinity,
              child: Card(
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10,
                      sigmaY: 10,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text("300° K",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            ),
                          ),
                           SizedBox(height: 20,),
                          Icon(Icons.cloud,
                          size: 64, 
                          ),
                          SizedBox(height: 20,),
                          Text("Rain",
                          style: TextStyle(
                            fontSize: 20),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
            ,
            //Weather forcast card
             const SizedBox(height: 20),
             const Text("Weather forcast",
             style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
             ),
             ),
             const SizedBox(height: 10),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                children: [
                  HourlyForcastItem(
                    time: '00:00',
                    icon: Icons.cloud,
                    temperature: '301.22',
                  ),
                  HourlyForcastItem(
                    time: '3:00',
                    icon: Icons.sunny,
                    temperature: '300.52',
                  ),
                  HourlyForcastItem(
                    time: '06:00',
                    icon: Icons.cloud,
                    temperature: '301.00',
                  ),
                  HourlyForcastItem(
                    time: '09:00',
                    icon: Icons.sunny,
                    temperature: '303.66',
                  ),
                  HourlyForcastItem(
                    time: '12:00',
                    icon: Icons.cloud,
                    temperature: '304.12',
                  ),
                ],
                           ),
              ),
            const  SizedBox(height: 30),
            const Text("Additional Information",
             style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
             ),
             ),
            const SizedBox(height: 10),
            
            //Additional Information
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                 AdditionalInfoItem(
                  icon: Icons.water_drop,
                  label: 'Humidity',
                  value: '91',
                  ),
                 AdditionalInfoItem(
                  icon: Icons.air,
                  label: 'Wind Speed',
                  value: '7.5',
                 ),
                 AdditionalInfoItem(
                  icon: Icons.beach_access,
                  label: 'Pressure',
                  value: '1006',
                 ),
                ],
            ),

            const SizedBox(height: 30),
            //additional information
          ],
        ),
      ),
    );
  }
}
