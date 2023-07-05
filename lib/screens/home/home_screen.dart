import 'package:flutter/material.dart';
import 'package:gobid_admin/screens/home/blocked_useres/blocked_users.dart';
import 'package:gobid_admin/screens/home/end_auctions/end_auction_screen.dart';

import 'exist_list/exists_products_list.dart';
import 'waiting_list/waiting_products_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('GoBid'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>BlockedUsers()));
            },icon: Icon(Icons.lock),)
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Waiting List',
                icon: Icon(Icons.my_library_add),
              ),
              Tab(
                text: 'Confirmed',
                icon: Icon(Icons.filter),
              ),
              Tab(
                text: 'End Auctions',
                icon: Icon(Icons.alarm_on),
              )
            ],
          ),
        ),
        body: const TabBarView(children: [
          WaitingProductsList(),
          ExistProductsList(),
          EndAuctionsScreen(),
        ]),
      ),
    );
  }
}
