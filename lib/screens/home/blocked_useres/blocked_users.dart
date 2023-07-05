import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'demo_users.dart';

class BlockedUsers extends StatelessWidget {
  List<BlockedUser> blockedUsers = BlockedUser.blockedUsers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('GoBid'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
        child: ListView.separated(
            itemCount: blockedUsers.length,
          separatorBuilder: (context, index) {
            return SizedBox(height: 10);
          },
            itemBuilder: (context, index) {
              return Card(
                elevation: 4,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            blockedUsers[index].name,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 6),
                          Text(blockedUsers[index].email,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54)),
                          SizedBox(height: 6),
                          Text(blockedUsers[index].address,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54)),
                        ],
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.lock_open))
                    ],
                  ),
                ),
              );
            },

           ),
      ),
    );
  }
}
