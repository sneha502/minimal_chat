import 'package:flutter/material.dart';
import 'package:minimal/components/my_drawer.dart';
import 'package:minimal/components/user_tile.dart';
import 'package:minimal/services/auth/auth_service.dart';
import 'package:minimal/services/chat/chat_service.dart';

import 'chat_page.dart';

class HomePage extends StatelessWidget {

  final ChatService _chatService = ChatService();
  final AuthServices _authServices = AuthServices();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey,
      ),
      drawer: MyWidget(),
      body: _buildUserList(),
    );
  }

    Widget _buildUserList(){
      return StreamBuilder(
          stream: _chatService.getUsersStream(),
          builder: (context, snapshot){

            if(snapshot.hasError){
              return Text("Error");
            }
             if(snapshot.connectionState == ConnectionState.waiting)
              {
                return Text("Loading..");
              }
             return ListView(
               children: snapshot.data!
                   .map<Widget>((userData) => _buildUserListItem(userData, context))
                   .toList(),
             );
          },
      );
    }

    Widget _buildUserListItem(
        Map<String, dynamic> userData, BuildContext context) {
      if(userData["email"]!= _authServices.getCurrentUser()!.email){
        return UserTile(
          userData["email"],
              () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ChatPage(
                        userData["email"],
                        userData["uid"],
                      ),
                )
            );
          },
        );
      }
      else
        return Container();
    }
}
