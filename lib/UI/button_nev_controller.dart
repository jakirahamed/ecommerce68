import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:ecommerce68/UI/bottom_nav_pages/Search.dart';
import 'package:ecommerce68/UI/bottom_nav_pages/account.dart';
import 'package:ecommerce68/UI/bottom_nav_pages/cart.dart';
import 'package:ecommerce68/UI/bottom_nav_pages/favourite.dart';
import 'package:ecommerce68/UI/bottom_nav_pages/home.dart';
import 'package:flutter/material.dart';
class ButtonNavController extends StatefulWidget {
  const ButtonNavController({ Key? key }) : super(key: key);

  @override
  _ButtonNavControllerState createState() => _ButtonNavControllerState();
}

class _ButtonNavControllerState extends State<ButtonNavController> {
  final _pages = [
    HomeScreen1(),
    SearchPage(),
    FavouriteScreen(),
    CartScreen(),
    AccountScreen(),
  ];
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: CustomLineIndicatorBottomNavbar(
        selectedColor: Colors.blue,
        unSelectedColor: Colors.black54,
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        enableLineIndicator: true,
        lineIndicatorWidth: 3,
        indicatorType: IndicatorType.Top,

        customBottomBarItems: [
          CustomBottomBarItems(
            label: 'Home',
            icon: Icons.home,
          ),
          CustomBottomBarItems(
            label: 'Search',
            icon: Icons.search,
          ),
          CustomBottomBarItems(
            label: 'favorites', 
            icon: Icons.favorite
            ),
          CustomBottomBarItems(
            label: 'Cart',
            icon: Icons.shopping_cart,
          ),
          CustomBottomBarItems(
            label: 'Account',
            icon: Icons.account_circle,
          ),
        ],
      ),
      body: _pages[_currentIndex],
    );
  }
}