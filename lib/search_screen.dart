import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> items = [
    "Apple",
    "Banana",
    "Cherry",
    "Date",
    "Grapes",
    "Mango",
    "Orange",
    "Peach",
    "Pineapple",
    "Strawberry",
    "Watermelon"
  ]; //Original List.

  List<String> filteredItems = []; //Filtered List.
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = items; //Show all items initially.
  }

  // Function to filter the list based on search input
  void filterSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredItems = items;
      } else {
        filteredItems = items
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  // Function to clear the search field
  void clearSearch() {
    setState(() {
      searchController.clear();
      filteredItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Filter',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Search Bar with Clear Button
            TextField(
              controller: searchController,
              onChanged: filterSearch,
              decoration: InputDecoration(
                labelText: 'Search...',
                hintText: 'Search Fruits.',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: clearSearch,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 10),

            // Display Filtered List or "No Results Found" Message
            Expanded(
              child: filteredItems.isNotEmpty
                  ? ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(filteredItems[index]),
                          leading: const Icon(
                            Icons.food_bank,
                            color: Colors.blue,
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'No Match Found!',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
