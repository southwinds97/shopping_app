import 'package:shopping_app/data/banner.dart';

List<banner> banners() {
  banner one = banner();
  one.image = '1.webp';
  one.name = '구직타이거1';
  one.price = '₩ 6,000';
  banner two = banner();
  two.image = '2.webp';
  two.name = '구직타이거2';
  two.price = '₩ 5,000';
  banner three = banner();
  three.image = '3.webp';
  three.name = '구직타이거3';
  three.price = '₩ 4,000';
  banner four = banner();
  four.image = '4.webp';
  four.name = '구직타이거4';
  four.price = '₩ 3,000';
  return [one, two, three, four];
}
