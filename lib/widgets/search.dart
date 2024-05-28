import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
// import 'package:subtraingrad/Screens/BookingProcess/Subway/data/subway_stations.dart';

class CustomSearchField extends StatelessWidget {
  final List<String> suggestions;
  final TextEditingController controller;
  final Function(String) onSearchTextChanged;
  final Function(SearchFieldListItem<String>) onSuggestionTap;
  final String hint;

  const CustomSearchField({
    required this.suggestions,
    required this.controller,
    required this.onSearchTextChanged,
    required this.onSuggestionTap, required this.hint,
  });

  Widget searchChild(String x) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12),
        child:
            Text(x, style: const TextStyle(fontSize: 18, color: Colors.black)),
      );

  @override
  Widget build(BuildContext context) {
    return SearchField(
      suggestionDirection: SuggestionDirection.flex,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || !suggestions.contains(value.trim())) {
          return 'Enter a valid Station Name';
        }
        return null;
      },
      autofocus: false,
      key: const Key('searchfield'),
      hint: hint,
      itemHeight: 50,
      suggestionStyle: const TextStyle(fontSize: 18, color: Colors.black),
      searchStyle: const TextStyle(fontSize: 18, color: Colors.black),
      suggestionItemDecoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      searchInputDecoration: InputDecoration(
        hintStyle: const TextStyle(fontSize: 18, color: Colors.grey),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(
            width: 1,
            color: Color.fromARGB(255, 56, 88, 103),
            style: BorderStyle.solid,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.black,
            style: BorderStyle.solid,
          ),
        ),
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
        ),
      ),
      suggestionsDecoration: SuggestionDecoration(
        elevation: 8.0,
        selectionColor: Colors.grey.shade100,
        hoverColor: Colors.purple.shade100,
        gradient: const LinearGradient(
          colors: [
            Colors.white,
            Colors.white,
          ],
          stops: [0.25, 0.75],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      suggestions: suggestions
          .map((e) => SearchFieldListItem<String>(e, child: searchChild(e)))
          .toList(),
      suggestionState: Suggestion.expand,
      onSuggestionTap: onSuggestionTap,
    );
  }
}
