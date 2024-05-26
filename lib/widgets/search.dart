import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

class SearchWidget extends StatelessWidget {
  final Function() onSuggestionSelected;

  const SearchWidget({Key? key, required this.onSuggestionSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var suggestions = <String>[
      'Helwan', 'Ain Helwan', 'Helwan University', 'Wadi Hof', 'Hadayek Helwan', 'Elmasraa',
      'Tura El-Esmant', 'Kozzika', 'Tura El-Balad', 'Sakanat El-Maadi', 'Maadi', 'Hadayek El-Maadi',
      'Dar El-Salam', 'El-Zahraa', 'Mar Girgis', 'El-Malak El-Saleh', 'Al-Sayeda Zeinab', 'Saad Zaghloul',
      'Orabi', 'Ghamra', 'El-Demerdash', 'Manshiet El-Sadr', 'Kobri El-Qobba', 'Hammamat El-Qobba',
      'Saraya El-Qobba', 'Hadayeq El-Zaitoun', 'Helmeyet El-Zaitoun', 'El-Matareyya', 'Ain Shams',
      'Ezbet El-Nakhl', 'El-Marg', 'El-Monib', 'Sakiat Mekky', 'Omm Em-Masryeen', 'Giza', 'Faisal',
      'Cairo University', 'El-Bohoth', 'Dokki', 'Opera', 'Nageib', 'Masarra', 'Rod El-Farag', 'St. Teresa',
      'Khalafawy', 'Mazallat', 'Koliet El-Zeraa', 'Shubra Al Khaimah', 'Adly Mansour', 'Haykestep',
      'Omar Ibn El-Khattab', 'Qubaa', 'Hesham Barakat', 'El Nozha', 'El Shams Club', 'Alf Maskan',
      'Heliopolis', 'Haroun', 'AL-Ahram', 'Koleyet El-Banat', 'Stadium', 'Fair Zone', 'Abbassiya',
      'Abdou Pasha', 'El-Geish', 'Bab El-Shaariya', 'Maspiro', 'Safaa Hijazy', 'Kit-Kat', 'Sudan', 'Imbaba',
      'El-Bohy', 'El-Qawmia', 'Ring Road', 'Rod El-Farag Corridor', 'Tawfikia', 'Wadi El-Nile',
      'Gamet El-Dowal', 'Boulak El-Dakrour', 'Nasser', 'Sadat', 'Attaba', 'Al-Shohadaa',
    ];

    final TextEditingController startSearchController = TextEditingController();
    final focus = FocusNode();

    Widget searchChild(String suggestion) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12),
          child: Text(suggestion, style: const TextStyle(fontSize: 18, color: Colors.black)),
        );

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SearchField(
            suggestionDirection: SuggestionDirection.down,
            onSearchTextChanged: (query) {
              final filter = suggestions
                  .where((element) => element.toLowerCase().contains(query.toLowerCase()))
                  .toList();
              return filter
                  .map((e) => SearchFieldListItem<String>(e, child: searchChild(e)))
                  .toList();
            },
            controller: startSearchController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || !suggestions.contains(value.trim())) {
                return 'Enter a valid Station Name';
              }
              return null;
            },
            onSubmit: (x) {},
            autofocus: false,
            key: const Key('searchfield'),
            hint: 'Start Station',
            itemHeight: 50,
            onTapOutside: (x) {},
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
                .map((e) => SearchFieldListItem<String>(e, child: searchChild(e)))
                .toList(),
            focusNode: focus,
            suggestionState: Suggestion.expand,
            onSuggestionTap: (SearchFieldListItem<String> item) {
              onSuggestionSelected();
            },
          ),
        ),
      ),
    );
  }
}
