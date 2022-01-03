import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({Key? key}) : super(key: key);

  @override
  _HomeScreen1State createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
// carousel slider store
  List<String> _carouselImage = [];
  var _dotPosition = 0;
//instance
  var _firestoreInstance = FirebaseFirestore.instance;

//product
  List _product = [];

//search controller
  final TextEditingController _searchController = new TextEditingController();

// carouselslider image function
  carouselImage() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("carousel-slider").get();

    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImage.add(
          qn.docs[i]["img"],
        );

        print(qn.docs[i]["img"]);
      }
    });
    return qn.docs;
  }

//product function
  fatchProduct() async {
    QuerySnapshot qn = await _firestoreInstance.collection("product").get();

    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _product.add({
          "product-name": qn.docs[i]["product-name"],
          "product-description": qn.docs[i]["product-description"],
          "product-price": qn.docs[i]["product-price"],
          "product-img": qn.docs[i]["product-img"],
        });
      }
    });
    return qn.docs;
  }

  @override
  void initState() {
    carouselImage();
    fatchProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF55CBED),
        actions: [
          AnimSearchBar(
            closeSearchOnSuffixTap: true,
            color: Color(0xFFC2F9FF),
            width: 400,
            textController: _searchController,
            onSuffixTap: () {
              setState(() {
                _searchController.clear();
              });
            },
            suffixIcon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            helpText: "Search Item Here",
          ),
        ],
      ),
      drawer: Drawer(),
      body: SafeArea(
          child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            ),
            SizedBox(
              height: 5.h,
            ),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CarouselSlider(
                  items: _carouselImage
                      .map((item) => Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(item),
                                    fit: BoxFit.fitHeight)),
                          ))
                      .toList(),
                  options: CarouselOptions(
                      autoPlay: true,
                      viewportFraction: 0.8,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (val, carouselPageChangeReason) {
                        setState(() {
                          _dotPosition = val;
                        });
                      })),
            ),
            SizedBox(
              height: 5.h,
            ),
            Center(
              child: DotsIndicator(
                dotsCount:
                    _carouselImage.length == 0 ? 1 : _carouselImage.length,
                position: _dotPosition.toDouble(),
                reversed: true,
                decorator: DotsDecorator(
                    activeColor: Colors.blueAccent,
                    color: Colors.blueAccent.withOpacity(0.5),
                    spacing: EdgeInsets.all(10),
                    activeSize: Size(18.0, 9.0),
                    size: Size(9, 0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
                child: GridView.builder(
                    itemCount: _product.length,
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 1),
                    itemBuilder: (_, index) {
                      return Card(
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 2,
                              child: Image.network(
                                _product[index]["product-img"][0],
                                // fit: BoxFit.contain,
                              ),
                            ),
                            Text("${_product[index]["product-name"]}"),
                            Text(_product[index]["product-price"]),
                          ],
                        ),
                        elevation: 3,
                      );
                    }))
            // ElevatedButton(onPressed: ()=>print(_product), child: Text("Print Product"))
          ],
        ),
      )),
    );
  }
}
