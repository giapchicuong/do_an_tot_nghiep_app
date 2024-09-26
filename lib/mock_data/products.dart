class Product {
  final String id;
  final String title;
  final String image;
  final String percent;
  final String numberPerson;

  Product({
    required this.id,
    required this.title,
    required this.image,
    required this.percent,
    required this.numberPerson,
  });
}

List<Product> productFake = [
  Product(
    id: '1',
    title: 'Dưa hấu',
    image:
        'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2021/7/6/927674/Dua-Hau.jpeg',
    percent: '85%',
    numberPerson: '30',
  ),
  Product(
    id: '2',
    title: 'Trái cam',
    image:
        'https://images.pexels.com/photos/2771926/pexels-photo-2771926.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    percent: '35%',
    numberPerson: '30',
  ),
  Product(
    id: '3',
    title: 'Trái táo',
    image:
        'https://genk.mediacdn.vn/2019/11/22/photo-1-1574415918938570279854.jpg',
    percent: '85%',
    numberPerson: '30',
  ),
  Product(
    id: '4',
    title: 'Trái ổi',
    image:
        'https://inkythuatso.com/uploads/thumbnails/800/2023/03/4-hinh-anh-qua-oi-inkythuatso-27-11-03-29.jpg',
    percent: '35%',
    numberPerson: '20',
  ),
];
