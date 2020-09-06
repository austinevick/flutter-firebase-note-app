import 'package:firebase_note_app/models/note.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = new TextEditingController();
  final List<Note> noteList = [];
  searchNote(String search) {
    final List<Note> searchResult = [];
    if (search.isEmpty) {}
    noteList.forEach((note) {
      if (note.title.toLowerCase().contains(search.toLowerCase()) ||
          note.content.toLowerCase().contains(search.toLowerCase())) {
        searchResult.add(note);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            padding: EdgeInsets.all(12),
            child: TextField(
              controller: controller,
              onChanged: (value) => null,
              decoration: InputDecoration(
                  enabledBorder: InputBorder.none, hintText: 'Search'),
            )),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
