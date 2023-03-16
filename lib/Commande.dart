import 'package:flutter/material.dart';
import 'DatabaseHelper.dart';

class CommandePage extends StatefulWidget {
  @override
  _CommandePageState createState() => _CommandePageState();
}

class _CommandePageState extends State<CommandePage> {
  List<Map<String, dynamic>>? _commands;

  @override
  void initState() {
    super.initState();
    _loadCommands();
  }

  Future<void> _loadCommands() async {
    final dbHelper = DatabaseHelper();
    final commands = await dbHelper.getAllCommands();
    setState(() {
      _commands = commands;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_commands == null) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('List of Orders'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _commands!.length,
        itemBuilder: (BuildContext context, int index) {
          final command = _commands![index];
          return Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    command['description'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Open Sans',
                    ),
                  ),
                  subtitle: Text(
                    'Total: ${command['total']}',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Open Sans',
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.blueGrey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '© 2023 My App',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Open Sans',
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
