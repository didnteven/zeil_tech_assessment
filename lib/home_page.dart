import 'package:flutter/material.dart';
import 'package:zeil_tech_assessment/custom_widgets/show_error_alert_dialog.dart';

import 'package:zeil_tech_assessment/models/restaurant.dart';
import 'package:zeil_tech_assessment/services/api_calls.dart';
import 'package:zeil_tech_assessment/view_restaurant.dart';

class MyHomePage extends StatefulWidget {
  ///Home page, allows users to search for a restaurants by location
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ///List of businesses (restaurants to display)
  List<Business> _restaurantList = <Business>[];

  ///loading variable, true when fetching data
  var _loading = false;

  ///Search string to be passed to the api
  var _searchLocation = 'Auckland, nz';

  @override
  void initState() {
    getRestaurants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //clears textBox focus
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: _buildBody()),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Widget _buildBody() {
    //to calculate screen sizes
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Search restaurants, by location',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 3, right: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.black),
                  ),
                  width: 240,
                  child: TextFormField(
                    initialValue: _searchLocation,
                    decoration: const InputDecoration(
                      hintText: 'eg Auckland nz',
                    ),
                    onChanged: (value) {
                      if (value != '') {
                        _searchLocation = value;
                      }
                    },
                  ),
                ),
                if (!_loading)
                  IconButton(
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      await getRestaurants();
                    },
                    icon: const Icon(Icons.search),
                  ),
              ],
            ),
          ),
          if (!_loading && _restaurantList.isEmpty)
            const Text('No restaurants found'),
          if (_loading)
            const Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          if (!_loading && _restaurantList.isNotEmpty)
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                SizedBox(
                  height: height - 100 - topPadding - bottomPadding,
                  child: ListView.builder(
                    itemCount: _restaurantList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          _restaurantListTile(_restaurantList[index], width),
                          //gap for image after last item
                          if (_restaurantList.length - 1 == index)
                            const SizedBox(
                              height: 40,
                            ),
                        ],
                      );
                    },
                  ),
                ),
                //image overlay
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    height: 40,
                    child: Image.asset('assets/images/yelp_logo.png'),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  ///list tile for displaying in list view
  Widget _restaurantListTile(Business restaurant, double width) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0), width: 0.5),
        // color: Colors.grey[50],
      ),
      height: 100,
      child: Row(
        children: [
          SizedBox(
            width: width * 0.75,
            child: ListTile(
              onTap: () {
                //navigate to view more details
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ViewRestaurant(restaurantAlias: restaurant.alias),
                  ),
                );
              },
              title: Text(restaurant.name),
              subtitle: Text(
                'Rating: ${restaurant.rating} (${restaurant.reviewCount})',
                style: const TextStyle(fontSize: 12),
              ),
            ),
            // contentPadding: const EdgeInsets.all(4),
          ),
          //for displaying a slightly bigger picture than list tile
          SizedBox(
            width: width * 0.24,
            height: 90,
            child: Image.network(
              restaurant.imageUrl,
              errorBuilder: (context, object, stackTrace) {
                return const Icon(Icons.image);
              },
            ),
          )
        ],
      ),
    );
  }

  ///Gets restaurants from the api
  ///
  ///Updates loading state while loading,
  ///Updates _restaurantList when done
  Future<void> getRestaurants() async {
    try {
      setState(() {
        _loading = true;
      });
      _restaurantList = await searchRestaurants(_searchLocation);
      setState(() {
        _restaurantList;
        _loading = false;
      });
    } on Exception catch (e) {
      await showErrorAlertDialog(
          context, 'Error loading restaurants', e.toString());
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }
}
