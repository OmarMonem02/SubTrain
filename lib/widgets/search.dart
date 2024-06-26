import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import 'package:subtraingrad/Style/app_styles.dart';

class CustomSearchField extends StatelessWidget {
  final List<String> suggestions;
  final TextEditingController controller;
  final Function(String) onSearchTextChanged;
  final FocusNode focusNode;
  final Function(SearchFieldListItem<String>) onSuggestionTap;
  final String hint;

  const CustomSearchField({
    required this.suggestions,
    required this.controller,
    required this.onSearchTextChanged,
    required this.onSuggestionTap,
    required this.hint,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SearchField(
      suggestionDirection: SuggestionDirection.down,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || !suggestions.contains(value.trim())) {
          return;
        }
        return null;
      },
      hint: hint,
      itemHeight: 50,
      focusNode: focusNode,
      suggestionStyle: const TextStyle(fontSize: 18, color: Colors.black),
      searchStyle: const TextStyle(fontSize: 18, color: Colors.black),
      searchInputDecoration: InputDecoration(
        hintStyle: const TextStyle(fontSize: 18, color: Colors.grey),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1,
            color: Styles.primaryColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.black,
          ),
        ),
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18),
      ),
      suggestionsDecoration: SuggestionDecoration(
        elevation: 8.0,
        selectionColor: Colors.grey.shade100,
        hoverColor: Colors.purple.shade100,
        gradient: const LinearGradient(
          colors: [Colors.white, Colors.white],
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
          .map((e) => SearchFieldListItem<String>(
                e,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12),
                  child: Text(e,
                      style:
                          const TextStyle(fontSize: 18, color: Colors.black)),
                ),
              ))
          .toList(),
      suggestionState: Suggestion.expand,
      onSuggestionTap: onSuggestionTap,
    );
  }
}
