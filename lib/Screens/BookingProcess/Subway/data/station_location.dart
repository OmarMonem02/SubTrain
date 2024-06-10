import 'package:subtraingrad/nearestStation.dart';

class StationLocation {
  static List<TestLocation> locations = [
    TestLocation(
        id: 1,
        stationName: 'Helwan',
        latitude: 29.788219,
        longitude: 31.301781),
    TestLocation(
        id: 2,
        stationName: 'Ain Helwan',
        latitude: 29.867821,
        longitude: 31.315590),
    TestLocation(
        id: 3,
        stationName: 'Helwan University',
        latitude: 29.788220,
        longitude: 31.301780),
    TestLocation(
        id: 4,
        stationName: 'Wadi Hof',
        latitude: 29.879070,
        longitude: 31.313565),
    TestLocation(
        id: 5,
        stationName: 'Elmasraa',
        latitude: 29.90611111,
        longitude: 31.29972222),
    TestLocation(
        id: 6,
        stationName: 'Tura El-Esmant',
        latitude: 29.92583333,
        longitude: 31.28777778),
    TestLocation(
        id: 7,
        stationName: 'Cairo University',
        latitude: 30.02611111,
        longitude: 31.20111111),
    TestLocation(
        id: 8,
        stationName: 'Kozzika',
        latitude: 29.93611111,
        longitude: 31.28166667),
    TestLocation(
        id: 9,
        stationName: 'Tura El-Balad',
        latitude: 29.94638889,
        longitude: 31.27361111),
    TestLocation(
        id: 10,
        stationName: 'Sakanat El-Maadi',
        latitude: 29.95277778,
        longitude: 31.26333333),
    TestLocation(
        id: 11,
        stationName: 'Maadi',
        latitude: 29.95972222,
        longitude: 31.25805556),
    TestLocation(
        id: 12,
        stationName: 'Hadayek El-Maadi',
        latitude: 29.97000000,
        longitude: 31.25055556),
    TestLocation(
        id: 13,
        stationName: 'Dar El-Salam',
        latitude: 29.98194444,
        longitude: 31.24222222),
    TestLocation(
        id: 14,
        stationName: 'Hadayek Helwan',
        latitude: 29.897140,
        longitude: 31.303996),
    TestLocation(
        id: 15,
        stationName: 'El-Zahraa',
        latitude: 29.99527778,
        longitude: 31.23166667),
    TestLocation(
        id: 16,
        stationName: 'Mar Girgis',
        latitude: 30.00583333,
        longitude: 31.23444444),
    TestLocation(
        id: 17,
        stationName: 'El-Malak El-Saleh',
        latitude: 30.01694444,
        longitude: 31.23083333),
    TestLocation(
        id: 18,
        stationName: 'Al-Sayeda Zeinab',
        latitude: 30.03166667,
        longitude: 31.23527778),
    TestLocation(
        id: 19,
        stationName: 'Saad Zaghloul',
        latitude: 30.03666667,
        longitude: 31.23805556),
    TestLocation(
        id: 20,
        stationName: 'Gamet El-Dowal',
        latitude: 30.05083333,
        longitude: 31.19972222),
    TestLocation(
        id: 21,
        stationName: 'Boulak El-Dakrour',
        latitude: 30.03611111,
        longitude: 31.17972222),
    TestLocation(
        id: 22,
        stationName: 'Orabi',
        latitude: 30.05750000,
        longitude: 31.24250000),
    TestLocation(
        id: 23,
        stationName: 'Wadi El-Nile',
        latitude: 30.05833333,
        longitude: 31.20111111),
    TestLocation(
        id: 24,
        stationName: 'Ghamra',
        latitude: 30.06888889,
        longitude: 31.26472222),
    TestLocation(
        id: 25,
        stationName: 'El-Demerdash',
        latitude: 30.07722222,
        longitude: 31.27777778),
    TestLocation(
        id: 26,
        stationName: 'Manshiet El-Sadr',
        latitude: 30.08222222,
        longitude: 31.28777778),
    TestLocation(
        id: 27,
        stationName: 'Kobri El-Qobba',
        latitude: 30.08694444,
        longitude: 31.29388889),
    TestLocation(
        id: 28,
        stationName: 'Hammamat El-Qobba',
        latitude: 30.09027778,
        longitude: 31.29805556),
    TestLocation(
        id: 29,
        stationName: 'Saraya El-Qobba',
        latitude: 30.09805556,
        longitude: 31.30472222),
    TestLocation(
        id: 30,
        stationName: 'Hadayeq El-Zaitoun',
        latitude: 30.10527778,
        longitude: 31.31000000),
    TestLocation(
        id: 31,
        stationName: 'Helmeyet El-Zaitoun',
        latitude: 30.11444444,
        longitude: 31.31388889),
    TestLocation(
        id: 32,
        stationName: 'El-Matareyya',
        latitude: 30.12138889,
        longitude: 31.31388889),
    TestLocation(
        id: 33,
        stationName: 'Ain Shams',
        latitude: 30.13111111,
        longitude: 31.31916667),
    TestLocation(
        id: 34,
        stationName: 'Ezbet El-Nakhl',
        latitude: 30.13916667,
        longitude: 31.32444444),
    TestLocation(
        id: 35,
        stationName: 'El-Marg',
        latitude: 30.15222222,
        longitude: 31.33555556),
    TestLocation(
        id: 36,
        stationName: 'New Marg',
        latitude: 30.16333333,
        longitude: 31.33833333),
    TestLocation(
        id: 37,
        stationName: 'El-Monib',
        latitude: 29.98138889,
        longitude: 31.21194444),
    TestLocation(
        id: 38,
        stationName: 'Sakiat Mekky',
        latitude: 29.99555556,
        longitude: 31.20861111),
    TestLocation(
        id: 39,
        stationName: 'Omm El-Masryeen',
        latitude: 30.00527778,
        longitude: 31.20805556),
    TestLocation(
        id: 40,
        stationName: 'Giza',
        latitude: 30.01055556,
        longitude: 31.20694444),
    TestLocation(
        id: 41,
        stationName: 'Faisal',
        latitude: 30.01722222,
        longitude: 31.20388889),
    TestLocation(
        id: 42,
        stationName: 'Tawfikia',
        latitude: 30.08194444,
        longitude: 31.20250000),
    TestLocation(
        id: 43,
        stationName: 'Rod El-Farag Corridor',
        latitude: 30.10194444,
        longitude: 31.18416667),
    TestLocation(
        id: 44,
        stationName: 'El-Bohoth',
        latitude: 30.03583333,
        longitude: 31.20027778),
    TestLocation(
        id: 45,
        stationName: 'Dokki',
        latitude: 30.03833333,
        longitude: 31.21194444),
    TestLocation(
        id: 46,
        stationName: 'Opera',
        latitude: 30.04194444,
        longitude: 31.22527778),
    TestLocation(
        id: 47,
        stationName: 'Sadat',
        latitude: 30.04444444,
        longitude: 31.23555556),
    TestLocation(
        id: 48,
        stationName: 'Nageib',
        latitude: 30.04527778,
        longitude: 31.24416667),
    TestLocation(
        id: 49,
        stationName: 'Attaba',
        latitude: 30.05250000,
        longitude: 31.24694444),
    TestLocation(
        id: 50,
        stationName: 'Al-Shohadaa',
        latitude: 30.06194444,
        longitude: 31.24611111),
    TestLocation(
        id: 51,
        stationName: 'Masarra',
        latitude: 30.07111111,
        longitude: 31.24500000),
    TestLocation(
        id: 52,
        stationName: 'Rod El-Farag',
        latitude: 30.08055556,
        longitude: 31.24555556),
    TestLocation(
        id: 53,
        stationName: 'St. Teresa',
        latitude: 31.245298,
        longitude: 31.245298),
    TestLocation(
        id: 54,
        stationName: 'Khalafawy',
        latitude: 30.09805556,
        longitude: 31.24527778),
    TestLocation(
        id: 55,
        stationName: 'Mazallat',
        latitude: 30.10500000,
        longitude: 31.24666667),
    TestLocation(
        id: 56,
        stationName: 'Koliet El-Zeraa',
        latitude: 30.11388889,
        longitude: 31.24861111),
    TestLocation(
        id: 57,
        stationName: 'Shubra Al Khaimah',
        latitude: 30.12250000,
        longitude: 31.24472222),
    TestLocation(
        id: 58,
        stationName: 'Adly Mansour',
        latitude: 30.14694444,
        longitude: 31.42138889),
    TestLocation(
        id: 59,
        stationName: 'Haykestep',
        latitude: 30.14388889,
        longitude: 31.40472222),
    TestLocation(
        id: 60,
        stationName: 'Omar Ibn El-Khattab',
        latitude: 30.14055556,
        longitude: 31.39416667),
    TestLocation(
        id: 61,
        stationName: 'Qubaa',
        latitude: 30.13472222,
        longitude: 31.38388889),
    TestLocation(
        id: 62,
        stationName: 'Hesham Barakat',
        latitude: 30.13111111,
        longitude: 31.37277778),
    TestLocation(
        id: 63,
        stationName: 'El Nozha',
        latitude: 30.12833333,
        longitude: 31.36000000),
    TestLocation(
        id: 64,
        stationName: 'El Shams Club',
        latitude: 30.12222222,
        longitude: 31.34388889),
    TestLocation(
        id: 65,
        stationName: 'Alf Maskan',
        latitude: 30.11805556,
        longitude: 31.33972222),
    TestLocation(
        id: 66,
        stationName: 'Heliopolis',
        latitude: 30.10805556,
        longitude: 31.33805556),
    TestLocation(
        id: 67,
        stationName: 'Haroun',
        latitude: 30.10111111,
        longitude: 31.33277778),
    TestLocation(
        id: 68,
        stationName: 'Al-Ahram',
        latitude: 30.09138889,
        longitude: 31.32638889),
    TestLocation(
        id: 69,
        stationName: 'Koleyet El-Banat',
        latitude: 30.08361111,
        longitude: 31.32888889),
    TestLocation(
        id: 70,
        stationName: 'Stadium',
        latitude: 30.07305556,
        longitude: 31.31750000),
    TestLocation(
        id: 71,
        stationName: 'Fair Zone',
        latitude: 30.07333333,
        longitude: 31.30111111),
    TestLocation(
        id: 72,
        stationName: 'Abbassiya',
        latitude: 30.06972222,
        longitude: 31.28083333),
    TestLocation(
        id: 73,
        stationName: 'Abdou Basha',
        latitude: 30.06472222,
        longitude: 31.27472222),
    TestLocation(
        id: 74,
        stationName: 'El-Geish',
        latitude: 30.06194444,
        longitude: 31.26694444),
    TestLocation(
        id: 75,
        stationName: 'Bab El-Shaariya',
        latitude: 30.05388889,
        longitude: 31.25611111),
    TestLocation(
        id: 76,
        stationName: 'Gamal AbdelNaser',
        latitude: 30.053496,
        longitude: 31.238722),
    TestLocation(
        id: 77,
        stationName: 'Maspiro',
        latitude: 30.05555556,
        longitude: 31.23222222),
    TestLocation(
        id: 78,
        stationName: 'Safaa Hijazy',
        latitude: 30.05555556,
        longitude: 31.23222222),
    TestLocation(
        id: 79,
        stationName: 'Kit-Kat ',
        latitude: 30.06666667,
        longitude: 31.21305556),
    TestLocation(
        id: 80,
        stationName: 'Sudan',
        latitude: 30.06972222,
        longitude: 31.20527778),
    TestLocation(
        id: 81,
        stationName: 'Imbaba',
        latitude: 30.07583333,
        longitude: 31.20750000),
    TestLocation(
        id: 82,
        stationName: 'El-Bohy',
        latitude: 30.08222222,
        longitude: 31.21055556),
    TestLocation(
        id: 83,
        stationName: 'El-Qawmia',
        latitude: 30.07666667,
        longitude: 31.20888889),
    TestLocation(
        id: 84,
        stationName: 'Ring Road ',
        latitude: 30.09638889,
        longitude: 31.19972222),
  ];
}
