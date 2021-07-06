import 'dart:convert';
import 'package:http/http.dart' as http;

dynamic getJsonData() async {
  try {
    final response =
        await http.get(Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=47.6204,-122.3491&radius=2500&type=restaurant&key=AIzaSyDkGIvqAXuuOE5TUoDedazelbPdKtQxb1E'));
    final jsonString = response.body;
    // print(jsonString);
    final data = jsonDecode(jsonString);
    // print(data['results']);
    return data['results'];
  } catch (e) {
    print(e);
    return null;
  }
}

dynamic getRestaurants() async {
  // list of restaurants
  final data = (await getJsonData()) as List;
  final restaurants = data
      .map((r) => <String, dynamic>{
            'name': r['name'],
            'icon': r['icon'],
            'rating': r['rating'],
            'address': r['vicinity'],
            'types': r['types'],
          })
      .toList();
  // restaurants.forEach(print);
  return restaurants;
}
