import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class Todo {
  bool isDone;
  String title;

  Todo(this.title, {this.isDone = false});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '할 일 관리',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {

  var _todoController = TextEditingController();

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }
  
  //할 일 추가 메서드
  void _addTodo(Todo todo){
    Firestore.instance
    .collection('todo').add({'title': todo.title, 'isDone': todo.isDone});
    _todoController.text = '';
  }
  
  //할 일 삭제 메서드
  void _deleteTodo(DocumentSnapshot doc){
    Firestore.instance.collection('todo').document(doc.documentID).delete();
  }
  
  //할 일 완료/미완료 메서드
  void _toggleTodo(DocumentSnapshot doc){
    Firestore.instance.collection('todo').document(doc.documentID).updateData({
      'isDone': !doc['isDone'],
    });
  }

  Widget _buildItemWidget(DocumentSnapshot doc) {
    final todo = Todo(doc['title'], isDone: doc['isDone']);
    return ListTile(
      onTap: () => _toggleTodo(doc),
      title: Text(
        todo.title,
        style: todo.isDone
            ? TextStyle(
          decoration: TextDecoration.lineThrough,
          fontStyle: FontStyle.italic,
        )
            : null,
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete_forever),
        onPressed: () => _deleteTodo(doc),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('남은 할 일'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _todoController,
                  ),
                ),
                RaisedButton(
                  child: Text('추가'),
                  onPressed: () => _addTodo(Todo(_todoController.text)),
                ),
              ],
            ),
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('todo').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData){
                  return CircularProgressIndicator();
                }
                final documents = snapshot.data.documents;
                return Expanded(
                  child: ListView(
                    children: documents.map((doc) => _buildItemWidget(doc)).toList(),
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
