import 'package:shopping_app/data/banner.dart';

List<banner> banners() {
  banner one = banner();
  one.image = 'new1.jpg';
  one.name = '구직타이거1';
  one.price = '6000';
  banner two = banner();
  two.image = 'new2.jpg';
  two.name = '구직타이거2';
  two.price = '5000';
  banner three = banner();
  three.image = 'new3.jpg';
  three.name = '구직타이거3';
  three.price = '4000';
  banner four = banner();
  four.image = 'new4.jpg';
  four.name = '구직타이거4';
  four.price = '3000';
  return [one, two, three, four];
}
