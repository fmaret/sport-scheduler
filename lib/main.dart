import 'package:flutter/material.dart';
import 'notification.dart' as custom_notification;
import 'program_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState(){
    super.initState();
    custom_notification.Notification.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF3ac3cb), Color(0xFFf85187)])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.blue.withOpacity(0.5),

          ),
          body: Center(
            child: Column(
              children: [
                Container(decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  width: 200,
                  height: 80,
                  child: ElevatedButton(
                    onPressed: (){
                      custom_notification.Notification.sendNotification(
                        title: "Canard",
                        body: "Coin Coin",
                      );
                  // custom_notification.Notification.schedulePeriodicNotification(title: "Canard", body: "Coin Coin");
                    }, child: const Text("Envoyer la notification"),
                  ),
                ),
                Container(decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  width: 200,
                  height: 80,
                  child: ElevatedButton(
                  onPressed: (){
                    programs[0].startProgram();
                // custom_notification.Notification.schedulePeriodicNotification(title: "Canard", body: "Coin Coin");
                  }, child: const Text("S'abonner au programme test"),
                ),
              ),
              ]
              ,
          )),
    ));
  }
}