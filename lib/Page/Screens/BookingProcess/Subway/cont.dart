// // ignore_for_file: avoid_print
// import 'dart:io';

// void main() {
//   Map<String, Map<String, int>> graph = {
//     'Helwan': {'Ain Helwan': 1},
//     'Ain Helwan': {'Helwan University': 1, 'Helwan': 1},
//     'Helwan University': {'Wadi Hof': 1, 'Ain Helwan': 1},
//     'Wadi Hof': {'Hadayek Helwan': 1, 'Helwan University': 1},
//     'Hadayek Helwan': {'Elmasraa': 1, 'Wadi Hof': 1},
//     'Elmasraa': {'Tura El-Esmant': 1, 'Hadayek Helwan': 1},
//     'Tura El-Esmant': {'Kozzika': 1, 'Elmasraa': 1},
//     'Kozzika': {'Tura El-Balad': 1, 'Tura El-Esmant': 1},
//     'Tura El-Balad': {'Sakanat El-Maadi': 1, 'Kozzika': 1},
//     'Sakanat El-Maadi': {'Maadi': 1, 'Tura El-Balad': 1},
//     'Maadi': {'Hadayek El-Maadi': 1, 'Sakanat El-Maadi': 1},
//     'Hadayek El-Maadi': {'Dar El-Salam': 1, 'Maadi': 1},
//     'Dar El-Salam': {'El-Zahraa': 1, 'Hadayek El-Maadi': 1},
//     'El-Zahraa': {'Mar Girgis': 1, 'Dar El-Salam': 1},
//     'Mar Girgis': {'El-Malak El-Saleh': 1, 'El-Zahraa': 1},
//     'El-Malak El-Saleh': {'Al-Sayeda Zeinab': 1, 'Mar Girgis': 1},
//     'Al-Sayeda Zeinab': {'Saad Zaghloul': 1, 'El-Malak El-Saleh': 1},
//     'Saad Zaghloul': {'Sadat': 1, 'Al-Sayeda Zeinab': 1},
//     'Orabi': {'Al-Shohadaa': 1, 'Nasser': 1},
//     'Ghamra': {'El-Demerdash': 1, 'Al-Shohadaa': 1},
//     'El-Demerdash': {'Ghamra': 1, 'Manshiet El-Sadr': 1},
//     'Manshiet El-Sadr': {'El-Demerdash': 1, 'Kobri El-Qobba': 1},
//     'Kobri El-Qobba': {'Manshiet El-Sadr': 1, 'Hammamat El-Qobba': 1},
//     'Hammamat El-Qobba': {'Kobri El-Qobba': 1, 'Saraya El-Qobba': 1},
//     'Saraya El-Qobbaa': {'Hammamat El-Qobba': 1, 'Hadayeq El-Zaitoun': 1},
//     'Hadayeq El-Zaitoun': {'Saraya El-Qobbaa': 1, 'Helmeyet El-Zaitoun': 1},
//     'Helmeyet El-Zaitoun': {'Hadayeq El-Zaitoun': 1, 'El-Matareyya': 1},
//     'El-Matareyya': {'Helmeyet El-Zaitoun': 1, 'Ain Shams': 1},
//     'Ain Shams': {'El-Matareyya': 1, 'Ezbet El-Nakhl': 1},
//     'Ezbet El-Nakhl': {'Ain Shams': 1, 'El-Marg': 1},
//     'El-Marg': {'Ezbet El-Nakhl': 1, 'New Marg': 1},
//     /////////////////////////////////////Fist Line/////////////////////////////////////////////
//     'El-Monib': {'Sakiat Mekky': 1},
//     'Sakiat Mekky': {'El-Monib': 1, 'Omm Em-Masryeen': 1},
//     'Omm Em-Masryeen': {'Sakiat Mekky': 1, 'Giza': 1},
//     'Giza': {'Omm Em-Masryeen': 1, 'Faisal': 1},
//     'Faisal': {'Giza': 1, 'Cairo University': 1},
//     'Cairo University': {'Faisal': 1, 'El-Bohoth': 1, 'Boulak El-Dakrour': 1},
//     'El-Bohoth': {'Cairo University': 1, 'Dokki': 1},
//     'Dokki': {'El-Bohoth': 1, 'Opera': 1},
//     'Opera': {'Dokki': 1, 'Sadat': 1},
//     'Nageib': {'Attaba': 1, 'Sadat': 1},
//     'Masarra': {'Al-Shohadaa': 1, 'Rod El-Farag': 1},
//     'Rod El-Farag': {'Masarra': 1, 'St. Teresa': 1},
//     'St. Teresa': {'Rod El-Farag': 1, 'Khalafawy': 1},
//     'Khalafawy': {'St. Teresa': 1, 'Mazallat': 1},
//     'Mazallat': {'Koliet El-Zeraa': 1, 'Khalafawy': 1},
//     'Koliet El-Zeraa': {'Mazallat': 1, 'Shubra Al Khaimah': 1},
//     'Shubra Al Khaimah': {'Koliet El-Zeraa': 1},
//     /////////////////////////////////////Second Line/////////////////////////////////////////////
//     'Adly Mansour': {'Haykestep': 1},
//     'Haykestep': {'Adly Mansour': 1, 'Omar Ibn El-Khattab': 1},
//     'Omar Ibn El-Khattab': {'Haykestep': 1, 'Qubaa': 1},
//     'Qubaa': {'Omar Ibn El-Khattab': 1, 'Hesham Barakat': 1},
//     'Hesham Barakat': {'Qubaa': 1, 'El Nozha': 1},
//     'El Nozha': {'Hesham Barakat': 1, 'El Shams Club': 1},
//     'El Shams Club': {'El Nozha': 1, 'Alf Maskan': 1},
//     'Alf Maskan': {'El Shams Club': 1, 'Heliopolis': 1},
//     'Heliopolis': {'Alf Maskan': 1, 'Haroun': 1},
//     'Haroun': {'Heliopolis': 1, 'AL-Ahram': 1},
//     'AL-Ahram': {'Haroun': 1, 'Koleyet El-Banat': 1},
//     'Koleyet El-Banat': {'AL-Ahram': 1, 'Stadium': 1},
//     'Stadium': {'Koleyet El-Banat': 1, 'Fair Zone': 1},
//     'Fair Zone': {'Stadium': 1, 'Abbassiya': 1},
//     'Abbassiya': {'Fair Zone': 1, 'Abdou Pasha': 1},
//     'Abdou Pasha': {'Abbassiya': 1, 'El-Geish': 1},
//     'El-Geish': {'Abdou Pasha': 1, 'Bab El-Shaariya': 1},
//     'Bab El-Shaariya': {'El-Geish': 1, 'Attaba': 1},
//     'Maspiro': {'Nasser': 1, 'Safaa Hijazy': 1},
//     'Safaa Hijazy': {'Maspiro': 1, 'Kit-Kat': 1},
//     'Kit-Kat': {'Safaa Hijazy': 1, 'Sudan': 1, 'Tawfikia': 1},
//     ////
//     'Sudan': {'Imbaba': 1, 'Kit-Kat': 1},
//     'Imbaba': {'Sudan': 1, 'El-Bohy': 1},
//     'El-Bohy': {'Imbaba': 1, 'El-Qawmia': 1},
//     'El-Qawmia': {'El-Bohy': 1, 'Ring Road': 1},
//     'Ring Road': {'El-Qawmia': 1, 'Rod El-Farag Corridor': 1},
//     'Rod El-Farag Corridor': {'Ring Road': 1},
//     ////
//     ////
//     'Tawfikia': {'Kit-Kat': 1, 'Wadi El-Nile': 1},
//     'Wadi El-Nile': {'Tawfikia': 1, 'Gamet El-Dowal': 1},
//     'Gamet El-Dowal': {'Wadi El-Nile': 1, 'Boulak El-Dakrour': 1},
//     'Boulak El-Dakrour': {'Gamet El-Dowal': 1, 'Cairo University': 1},
//     ////
//     /////////////////////////////////////Third Line/////////////////////////////////////////////
//     'Nasser': {'Maspiro': 1, 'Sadat': 1, 'Orabi': 1, 'Attaba': 1},
//     'Sadat': {'Opera': 1, 'Saad Zaghloul': 1, 'Nasser': 1, 'Nageib': 1},
//     'Attaba': {
//       'Nageib': 1,
//       'Al-Shohadaa': 1,
//       'Nasser': 1,
//       'Bab El-Shaariya': 1
//     },
//     'Al-Shohadaa': {'Ghamra': 1, 'Masarra': 1, 'Orabi': 1, 'Attaba': 1},
//   };
//   print('Please enter your Pickup Point:');
//   String start = stdin.readLineSync()!;
//   print('Please enter your Drop Down Point:');
//   String end = stdin.readLineSync()!;
//   List<String> path = findShortestPath(graph, start, end);
//   print("Start Point is $start");
//   print("End Point is $end");
//   print("Your Path is $path");
//   int counter = path.length;
//   print("Your Path is $counter");
// }

// List<String> findShortestPath(
//     Map<String, Map<String, int>> graph, String start, String end) {
//   // Store distances to each node (initially infinite except for the start node)
//   Map<String, double> distances = {};

//   // Store previous nodes along the shortest path
//   Map<String, String?> previous = {};

//   // Set of unvisited nodes
//   Set<String> unvisited = Set.from(graph.keys);

//   // Initialize distances
//   for (var node in graph.keys) {
//     distances[node] = double.infinity;
//   }
//   distances[start] = 0;

//   while (unvisited.isNotEmpty) {
//     // Find node with the smallest distance among unvisited nodes
//     String? currentNode =
//         unvisited.reduce((a, b) => distances[a]! < distances[b]! ? a : b);

//     unvisited.remove(currentNode);

//     if (currentNode == end) {
//       // Destination reached - reconstruct the path
//       List<String> path = [];
//       while (previous[currentNode] != null) {
//         path.insert(0, currentNode!);
//         currentNode = previous[currentNode];
//       }
//       path.insert(0, start);
//       return path;
//     }

//     for (var neighbor in graph[currentNode]!.keys) {
//       double altDistance =
//           distances[currentNode]! + graph[currentNode]![neighbor]!;
//       if (altDistance < (distances[neighbor] ?? double.infinity)) {
//         // Add null check
//         distances[neighbor] = altDistance;
//         previous[neighbor] = currentNode;
//       }
//     }
//   }
//   return [];
// }