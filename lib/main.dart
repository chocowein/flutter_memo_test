import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MemoList(),
    );
  }
}

class MemoList extends StatefulWidget {
  @override
  _MemoListState createState() => _MemoListState();
}

class _MemoListState extends State<MemoList> {
  List<String> memos = ['Sample Memo'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memo List'),
      ),
      body: ListView.builder(
        itemCount: memos.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(memos[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MemoDetail(memo: memos[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MemoEditor()),
          ).then((value) {
            if (value != null) {
              setState(() {
                memos.add(value);
              });
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class MemoDetail extends StatelessWidget {
  final String memo;

  MemoDetail({required this.memo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memo Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(memo),
      ),
    );
  }
}

class MemoEditor extends StatefulWidget {
  @override
  _MemoEditorState createState() => _MemoEditorState();
}

class _MemoEditorState extends State<MemoEditor> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Memo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _textEditingController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Enter your memo',
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, _textEditingController.text);
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
