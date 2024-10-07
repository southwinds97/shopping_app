import 'package:flutter/material.dart';
import 'package:shopping_app/constans/colors.dart';
import 'package:shopping_app/constans/navigation.dart';
import 'package:shopping_app/data/banner_model.dart';
import 'package:shopping_app/screens/home.dart';

class ProductDetailScreen extends StatefulWidget {
  int index;
  ProductDetailScreen({super.key, required this.index});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

int indexx = 0;
int indexxx = 0;
List option = ['옵션1', '옵션2', '옵션3', '옵션4'];

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    List get_images = [
      banners()[widget.index].image!,
      banners()[widget.index].image1!,
      banners()[widget.index].image2!,
      banners()[widget.index].image3!,
    ];

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\₩ ' + banners()[widget.index].price!,
              style: TextStyle(
                color: mains,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: 190,
              height: 50,
              decoration: BoxDecoration(
                color: mains,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                  Text(
                    'Add To Cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/images/${get_images[indexx]}',
                  fit: BoxFit.cover,
                ),
              ),
              expandedHeight: 400,
              backgroundColor: backgroundColor,
              bottom: PreferredSize(
                child: Container(
                  height: 20,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70),
                      topRight: Radius.circular(70),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 7),
                      Container(
                        height: 4,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(70),
                            topRight: Radius.circular(70),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                preferredSize: Size.fromHeight(10),
              ),
              automaticallyImplyLeading: false,
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CircleAvatar(
                    backgroundColor: Color.fromRGBO(250, 250, 250, 0.6),
                    radius: 18,
                    child: Icon(
                      Icons.favorite_border,
                      color: mains,
                      size: 25,
                    ),
                  ),
                ),
              ],
              title: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(
                    MaterialPageRoute(
                      builder: (BuildContext context) => Home(),
                    ),
                  );
                },
                child: CircleAvatar(
                  backgroundColor: Color.fromRGBO(250, 250, 250, 0.6),
                  radius: 18,
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      banners()[index].name!,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        SizedBox(width: 6),
                        Text(
                          '4.3',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 70,
                      child: ListView.builder(
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(left: index == 0 ? 0 : 24),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  indexx = index;
                                });
                              },
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color:
                                        indexx == index ? mains : Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/${get_images[index]}',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 25),
                    Text(
                      '디자인',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 35,
                      child: ListView.builder(
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 11),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  indexxx = index;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 100,
                                height: 35,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.2,
                                    color:
                                        indexxx == index ? mains : Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '${option[index]}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '상세정보',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        "이쁜 뚱랑이예요",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    indexx = 0;
    indexxx = 0;
    super.deactivate();
  }
}
