import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimal/components/chat_bubble.dart';
import 'package:minimal/components/my_text.dart';
import 'package:minimal/services/auth/auth_service.dart';
import 'package:minimal/services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String recieveremail;
  final String recieverID;

   ChatPage(
      this.recieveremail,
      this.recieverID,
      );

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthServices _authServices = AuthServices();

  FocusNode myFocusNode = FocusNode();

  @override
  void initState(){
    super.initState();

    myFocusNode.addListener(() {
      if(myFocusNode.hasFocus){
        Future.delayed(Duration(milliseconds: 500),
            () => scrollDown(),
        );
      }
    });
    
    Future.delayed(
      Duration(milliseconds: 500,),
        () => scrollDown(),
    );
  }

  @override
  void dispose(){
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();
  void scrollDown(){
    _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
    );
  }

  void sendMessage() async{
   if(_messageController.text.isNotEmpty){
     await _chatService.sendMessage(widget.recieverID, _messageController.text);

     _messageController.clear();
   }
   scrollDown();
  }

  @override


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(widget.recieveremail),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList(),
          ),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList(){
    String senderID = _authServices.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(widget.recieverID, senderID),
        builder: (context , snapshot) {

          if(snapshot.hasError){
            return Text("Error");
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Text("Loading..");
          }
          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
          );
        },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderID'] == _authServices.getCurrentUser()!.uid;

    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
          isCurrentUser ?   CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
          ChatBubble(data["message"], isCurrentUser),
          ],
        ));
  }

  Widget _buildUserInput(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          Expanded(
              child:MyTextField(
                hintext: "Type a message",
                obscuretext: false,
                controller: _messageController,
                focusNode: myFocusNode,
              ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage ,
              icon: Icon(Icons.arrow_upward,
              color: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }
}
