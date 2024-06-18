import 'package:flutter/material.dart';
import 'package:row_city/row_town.dart';
import 'package:row_city/time_team.dart';

import 'const.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  // code credit for routeObersver: https://medium.com/@sumit.ghoshqa/understanding-routeobserver-in-flutter-309ce2997c27
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ObserverUtils.routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: maroon,
          automaticallyImplyLeading: false,
          title: const Text("Row City", style: TextStyle(color: Colors.white)),
        ),
        body: SafeArea(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Websites: ",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    alignment: Alignment.center,
                    width: 450,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => [
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const RowTownPage(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                    opacity: animation, child: child);
                              },
                            ))
                      ],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 20),
                          Padding(
                              padding: const EdgeInsets.all(5),
                              child: Image.asset('assets/images/rowtown.png',
                                  scale: 1.5)),
                          const Spacer(),
                          const Text("RowTown Regatta Workbench",
                              style: TextStyle(
                                fontSize: 20,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    alignment: Alignment.center,
                    width: 450,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => [
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const TimeTeamPage(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                    opacity: animation, child: child);
                              },
                            ))
                      ],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/time_team.png',
                              scale: 1.5),
                          const Spacer(),
                          const Text("Time Team Regatta Systems",
                              style: TextStyle(
                                fontSize: 20,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )));
  }
}
