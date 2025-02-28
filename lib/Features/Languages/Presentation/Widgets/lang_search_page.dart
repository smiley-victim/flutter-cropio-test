import 'package:flutter/material.dart';

class LangSearchPage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final ValueChanged<String>? filterLanguages;

   LangSearchPage({super.key, this.filterLanguages});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Search languages...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onChanged: filterLanguages,
      ),
    );
  }
}
