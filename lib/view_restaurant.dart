import 'package:flutter/material.dart';
import 'package:zeil_tech_assessment/custom_widgets/copy_to_clip_board.dart';
import 'package:zeil_tech_assessment/custom_widgets/show_error_alert_dialog.dart';
import 'package:zeil_tech_assessment/models/restaurant_details.dart';
import 'package:zeil_tech_assessment/services/api_calls.dart';

class ViewRestaurant extends StatefulWidget {
  ///Display restaurant info and allow user to copy info to clipboard
  ///
  ///Required restaurant alias which is used for finding more info
  const ViewRestaurant({Key? key, required this.restaurantAlias})
      : super(key: key);
  final String restaurantAlias;

  @override
  State<ViewRestaurant> createState() => _ViewRestaurantState();
}

class _ViewRestaurantState extends State<ViewRestaurant> {
  ///Details object for the selected restaurant
  RestaurantDetails? _restaurantDetails;

  ///True if api is loading
  var _loading = false;

  ///int which represents today's date
  late int _todayInt;

  ///height of the display container
  final double _detailsHeight = 450;

  @override
  void initState() {
    loadRestaurantDetails();
    //minus one to match Yelp API
    _todayInt = DateTime.now().weekday - 1;
    setState(() {
      _todayInt;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            //column for building the background for restaurant info
            if (_restaurantDetails != null)
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (_restaurantDetails!.photos.length > 1)
                      for (var url in _restaurantDetails!.photos)
                        imageDisplay(url),
                    if (_restaurantDetails!.photos.length < 2 ||
                        _restaurantDetails!.photos.isEmpty)
                      for (int i = 0; i < 3; i++)
                        imageDisplay(_restaurantDetails!.imageUrl),
                  ],
                ),
              ),
            if (_restaurantDetails == null)
              Container(
                width: double.maxFinite,
              ),
            //Semi transparent background for displaying text on image
            SafeArea(
              child: Opacity(
                opacity: 0.7,
                child: Container(
                  width: 220,
                  height: _detailsHeight,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            //restaurant info body
            SafeArea(child: _buildBody(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    //details is null means could not load details
    //display this
    if (!_loading && _restaurantDetails == null) {
      return SizedBox(
        height: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 100,
              child: Column(
                children: [
                  _backButton(context),
                  const Text('Could not load restaurant info'),
                ],
              ),
            ),
          ],
        ),
      );
    }

    //if api is loading
    if (_loading) {
      return SizedBox(
        height: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 100,
              child: Column(
                children: const [
                  CircularProgressIndicator(),
                  Text('Loading restaurant info'),
                ],
              ),
            ),
          ],
        ),
      );
    }

    //return loaded details
    return Center(
      child: Container(
        width: 220,
        height: _detailsHeight,
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _backButton(context),
            SizedBox(
              //Restaurant title
              width: 220,
              height: 45,
              child: FittedBox(
                child: Text(
                  _restaurantDetails!.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            if (_restaurantDetails!.isClosed)
              const Text(
                'Closed ',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            const SizedBox(
              height: 10,
            ),
            if (_restaurantDetails!.price != null)
              Text(
                'Price: ${_restaurantDetails!.price}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            if (_restaurantDetails!.phone != '')
              Column(
                children: [
                  const Text(
                    'Phone: ',
                  ),
                  copyToClipBoard(
                    context,
                    _restaurantDetails!.phone,
                  ),
                ],
              ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Address: ',
            ),
            Center(
              child: copyToClipBoard(
                context,
                _restaurantDetails!.location.address1,
              ),
            ),
            if (_restaurantDetails!.location.address2 != null &&
                _restaurantDetails!.location.address2 != '')
              Center(
                child: copyToClipBoard(
                  context,
                  _restaurantDetails!.location.address2!,
                ),
              ),
            if (_restaurantDetails!.location.address3 != null &&
                _restaurantDetails!.location.address3 != '')
              Center(
                child: copyToClipBoard(
                  context,
                  _restaurantDetails!.location.address3!,
                ),
              ),
            Center(
              child: copyToClipBoard(
                context,
                _restaurantDetails!.location.city,
              ),
            ),
            Center(
              child: copyToClipBoard(
                context,
                _restaurantDetails!.location.country,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Opening hours:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            //display today's opening hours
            if (_restaurantDetails!.hours != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_restaurantDetails!.hours!.first.open[_todayInt].start),
                  const Text(' to '),
                  Text(_restaurantDetails!.hours!.first.open[_todayInt].end),
                ],
              ),
            const SizedBox(
              height: 10,
            ),
            //displays yelp logo
            SizedBox(
              height: 50,
              child: Image.asset('assets/images/yelp_logo.png'),
            ),
          ],
        ),
      ),
    );
  }

  ///network image display widget
  Widget imageDisplay(String url) {
    return Image.network(
      url,
      errorBuilder: (context, object, stackTrace) {
        return const Text('');
      },
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
          width: double.maxFinite,
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
    );
  }

  ///Load api to get further restaurant details
  Future<void> loadRestaurantDetails() async {
    try {
      setState(() {
        _loading = true;
      });

      _restaurantDetails = await getRestaurantDetails(widget.restaurantAlias);

      setState(() {
        _restaurantDetails;
        _loading = false;
      });
    } on Exception catch (e) {
      setState(() {
        _loading = false;
      });
      await showErrorAlertDialog(
          context, 'Error loading restaurant details', e.toString());
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }
}

///Pops current page, aligned to the right
///
///takes BuildContext
Widget _backButton(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      IconButton(
        iconSize: 25,
        color: Colors.black,
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ],
  );
}
