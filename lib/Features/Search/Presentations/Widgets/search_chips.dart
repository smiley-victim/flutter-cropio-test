import 'package:flutter/material.dart';

class SearchSuggestionChips extends StatelessWidget {
  final List<String> suggestions;

  const SearchSuggestionChips({super.key, required this.suggestions});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: suggestions.map((suggestion) {
        return ActionChip(
          label: Text(suggestion),
          onPressed: () {
            // Perform search with the selected suggestion
          },
          backgroundColor: Colors.green[100], // Light green background
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 14, 114, 17)), // Dark green text for better contrast
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        );
      }).toList(),
    );
  }
}