import 'package:shopping_app/data/banner.dart';

List<banner> banners() {
  banner one = banner();
  one.image = '1.jpg';
  one.image1 = '1-1.jpg';
  one.image2 = '1-2.jpg';
  one.image3 = '1-3.jpg';
  one.name = '구직타이거1';
  one.price = '6000';
  banner two = banner();
  two.image = '2.jpg';
  two.image1 = '2-1.jpg';
  two.image2 = '2-2.jpg';
  two.image3 = '2-3.jpg';
  two.name = '구직타이거2';
  two.price = '5000';
  banner three = banner();
  three.image = '3.jpg';
  three.image1 = '3-1.jpg';
  three.image2 = '3-2.jpg';
  three.image3 = '3-3.jpg';
  three.name = '구직타이거3';
  three.price = '4000';
  banner four = banner();
  four.image = '4.jpg';
  four.name = '구직타이거4';
  four.price = '3000';
  return [one, two, three, four];
}
