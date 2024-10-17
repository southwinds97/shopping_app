import 'package:flutter/material.dart';
import 'package:shopping_app/auth/main_auth.dart';
import 'package:shopping_app/constants/colors.dart';
import 'package:shopping_app/screens/cart.dart';
import 'package:shopping_app/screens/category.dart';
import 'package:shopping_app/screens/home.dart';
import 'package:shopping_app/screens/profil.dart';
import 'package:shopping_app/screens/wish_list.dart';

class Navi extends StatefulWidget {
  final int initialIndex;

  const Navi({super.key, this.initialIndex = 0});

  @override
  State<Navi> createState() => _NaviState();
}

class _NaviState extends State<Navi> {
  int index = 0;
  List screens = [const Home(), const Category(), const WishList(), const MainAuth()];

  @override
  void initState() {
    super.initState();
    index = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Cart(),
            ),
          );
        },
        backgroundColor: mains,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.shopping_cart_outlined,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: 60,
        shape: const CircularNotchedRectangle(),
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
              const SizedBox(width: 10),
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
