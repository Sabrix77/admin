import 'package:flutter/material.dart';
import 'package:gobid_admin/screens/winnig_products/new_winners/new_winners_screen.dart';
import 'package:gobid_admin/screens/winnig_products/on_progress/on_progress_screen.dart';

class WinningProductsScreen extends StatefulWidget {
  const WinningProductsScreen({Key? key}) : super(key: key);

  @override
  _WinningProductsScreenState createState() => _WinningProductsScreenState();
}

class _WinningProductsScreenState extends State<WinningProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('GoBid'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'New Winners',
                icon: Icon(Icons.person_pin_sharp),
              ),
              Tab(
                text: 'On Progress',
                icon: Icon(Icons.local_shipping),
              ),

            ],
          ),
        ),
        body: const TabBarView(children: [
         NewWinnersScreen(),
          OnProgressScreen(),
        ]),
      ),
    );
  }
}
