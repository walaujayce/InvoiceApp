import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  const CustomSearchBar({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        children: [
          Expanded(
            child: SearchBar(
              leading: Icon(Icons.search_rounded),
              hintText: hintText,
              elevation: WidgetStatePropertyAll(0),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),)),
            ),
          ),
          IconButton( onPressed: (){}, icon: Icon(Icons.sort_rounded))
        ],
      ),
    );
  }
}
