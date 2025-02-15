
import 'package:flutter/material.dart';
import '../Widgets/search_chips.dart';

class SearchPageMobile extends StatefulWidget {
  const SearchPageMobile({super.key});

  @override
  State<SearchPageMobile> createState() => _SearchPageMobileState();
}

class _SearchPageMobileState extends State<SearchPageMobile> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'searchPage',
      transitionOnUserGestures: true,
      createRectTween: (begin, end) {
        return MaterialRectCenterArcTween(begin: begin, end: end);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search Plants',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search for plants...',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    // contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                ),
              ),

              const SizedBox(height: 16.0),

              // Suggestions Section
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Suggestions:',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 12.0),

              // Suggestion Chips
              SearchSuggestionChips(
                suggestions: [
                  'Monstera',
                  'Succulents',
                  'Cactus',
                  'Fern',
                  'Bonsai'
                ],
              ),
              const SizedBox(height: 24.0),
              // Info for the user
              Center(
                child: Column(
                  children: const [
                    Text(
                  'Search for plants by name, type, or characteristic.',
                      style: TextStyle(fontSize: 14.0, color: Colors.grey),
                ),
                    SizedBox(height: 8.0),
                    Text('Tap on suggestions for quick search.',
                        style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


