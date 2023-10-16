import 'package:flutter/material.dart';
import 'package:module_10_assignment/style.dart';
import 'package:module_10_assignment/todo.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return ToDoPageView();
  }
}

class ToDoPageView extends State<ToDoPage> {
  final List<ListItem> _items = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();

  void addItem(String title, String subtitle) {
    setState(() {
      _items.add(ListItem(title, subtitle));
      titleController.clear();
      subtitleController.clear();
    });
  }

  void editItem(int index, String title, String subtitle) {
    setState(() {
      _items[index] = ListItem(title, subtitle);
    });
  }

  void deleteItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  void _showEditBottomSheet(BuildContext context, ListItem item, int index) {
    final TextEditingController titleController = TextEditingController(text: item.title);
    final TextEditingController subtitleController = TextEditingController(text: item.subtitle);

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: AppInputDecoration('Add Title')
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: subtitleController,
                decoration:  AppInputDecoration('Add Description'),
              ),
              const SizedBox(height: 10,),

              ElevatedButton(
                onPressed: () {
                  editItem(index, titleController.text, subtitleController.text);
                  Navigator.of(context).pop();
                },
                child: const Text('Edit Done'),
              ),
            ],
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 6,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white10,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: AppInputDecoration('Add Title')
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: subtitleController,
                  decoration: AppInputDecoration('Add Description')
                ),
                const SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () {
                    final title = titleController.text;
                    final subtitle = subtitleController.text;
                    if (title.isNotEmpty && subtitle.isNotEmpty) {
                      addItem(title, subtitle);
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text(item.title),
                  subtitle: Text(item.subtitle),
                  trailing: const Icon(Icons.arrow_forward),
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Alert'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                _showEditBottomSheet(context, item, index);
                              },
                              child: const Text('Edit'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                deleteItem(index);
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

    );
  }
}