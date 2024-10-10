import 'package:flutter/material.dart';
import 'package:shopping_app/auth/main_auth.dart';
import 'package:shopping_app/constants/colors.dart';
import 'package:shopping_app/screens/cart.dart';
import 'package:shopping_app/screens/category.dart';
import 'package:shopping_app/screens/home.dart';
import 'package:shopping_app/screens/profil.dart';
import 'package:shopping_app/screens/wish_list.dart';

class Navi extends StatefulWidget {
  const Navi({super.key});

  @override
  State<Navi> createState() => _NaviState();
}

int index = 0;
List screens = [Home(), Category(), WishList(), MainAuth()];

class _NaviState extends State<Navi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Cart(),
            ),
          );
        },
        child: Icon(
          Icons.shopping_cart_outlined,
          color: Colors.white,
        ),
        backgroundColor: mains,
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: 60,
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 0;
                  });
                },
                child: Icon(
                  Icons.home,
                  size: 27,
                  color: index == 0 ? mains : Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 1;
                  });
                },
                child: Icon(
                  Icons.category,
                  size: 27,
                  color: index == 1 ? mains : Colors.grey,
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 2;
                  });
                },
                child: Icon(
                  Icons.favorite,
                  size: 27,
                  color: index == 2 ? mains : Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 3;
                  });
                },
                child: Icon(
                  Icons.person,
                  size: 27,
                  color: index == 3 ? mains : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      body: screens[index],
    );
  }
}
