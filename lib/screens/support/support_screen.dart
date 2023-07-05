import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gobid_admin/base.dart';
import 'package:gobid_admin/model/chat.dart';
import 'package:gobid_admin/screens/support/messages/messages_screen.dart';
import 'package:gobid_admin/screens/support/support_navigator.dart';
import 'package:gobid_admin/screens/support/support_vm.dart';
import 'package:gobid_admin/shared/constants/app_strings.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends BaseView<SupportScreen, SupportViewModel>
    implements SupportNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  SupportViewModel initViewModel() {
    return SupportViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
            color: Colors.grey[300],
            width: double.infinity,
            child: Text(
              'Support',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Colors.black),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
              child: StreamBuilder(
                stream: viewModel.getAllChat(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.active) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text(AppStrings.somethingWontWrong));
                  }

                  List<Chat> chats =
                      snapshot.data!.docs.map((e) => e.data()).toList();
                  if(chats.isEmpty){
                    return Center(child: Image.asset('assets/images/empty-messages.png'));

                  }
                  return ListView.separated(
                      itemCount: chats.length,
                      separatorBuilder: (context, index) => const Divider(
                            thickness: 1,
                            height: 14,
                            color: Colors.black12,
                            indent: 70,
                            endIndent: 10,
                          ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            //naviget to message with user id
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed(MessagesScreen.routeName,
                                    arguments: chats[index]);
                          },
                          child: Container(
                            //color: Colors.grey[100],
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),

                            //height: 80,
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Colors.black45,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/avatar.jpg'),
                                    radius: 27,

                                    // minRadius: 28,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(chats[index].name,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500)),
                                      const SizedBox(height: 4),
                                      Text(
                                        chats[index].lastContent ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
