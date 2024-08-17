import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<String> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
         backgroundColor: Colors.black,
          centerTitle: true,
          foregroundColor: Colors.white,
        
        
      ),
      body: todos.isEmpty
          ? const Center(
              child: Text(
                'No todos yet!',
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(todos[index]),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      todos.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Todo deleted'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    child: const Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: ListTile(
                    title: Text(todos[index]),
                    leading: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 2, 2, 2),
                      child: Icon(Icons.check, color: Colors.white),
                    ),
                    onTap: () {
                      // Add your onTap functionality here
                    },
                  ),
                );
              },
            ),
     floatingActionButton: FloatingActionButton(
  onPressed: _addTodo,
  tooltip: 'Add Todo',
  backgroundColor: Colors.black, // Background color
  foregroundColor: Colors.white, // Plus sign (icon) color
  child: const Icon(Icons.add),
),

    );
  }

  void _addTodo() async {
    final TextEditingController textController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Todo'),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(hintText: 'Enter your task'),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Add'),
            onPressed: () {
              setState(() {
                todos.add(textController.text);
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}