class Product {
  final String id;
  final String title;
  final String description;
  final String image;
  final String percent;
  final String numberPerson;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.percent,
    required this.numberPerson,
  });
}

List<Product> productFake = [
  Product(
    id: '4',
    description:
        'Ổi là một loại trái cây nhiệt đới phổ biến được trồng ở nhiều vùng nhiệt đới và cận nhiệt đới. Ổi thường là loài ổi phổ biến nhất, quen thuộc nhất và được ăn nhiều nhất, thuộc họ Sim, có nguồn gốc từ México, Trung Mỹ, Caribe và phía bắc Nam Mỹ',
    title: 'Trái ổi',
    image:
        'https://cdn.pixabay.com/photo/2017/10/06/07/29/guava-2822182_1280.png',
    percent: '35%',
    numberPerson: '20',
  ),
  Product(
    id: '1',
    title: 'Dưa hấu',
    description:
        'Dưa hấu (Citrullus lanatus) là một loại trái cây lớn, có xuất xứ từ miền nam châu Phi, cùng họ với dưa đỏ, bí xanh, bí ngô và dưa chuột. Dưa hấu thường có vị ngọt mát, chỉ chứa 46 calo mỗi cốc, nhưng rất giàu vitamin A, vitamin C và các hợp chất thực vật khác như citrulline và lycopene tốt cho sức khỏe.Bên cạnh đó, loại dưa này còn mang lại nhiều lợi ích sức khỏe cho người sử dụng, bao gồm cải thiện độ nhạy insulin, giảm đau nhức cơ bắp và hạ huyết áp.Dưa hấu thường được ăn trực tiếp, để dưới dạng động lạnh, làm thành nước trái cây hoặc nước sinh tố.',
    image:
        'https://cdn.pixabay.com/photo/2013/07/12/19/18/watermelon-154510_960_720.png',
    percent: '85%',
    numberPerson: '30',
  ),
  Product(
    id: '2',
    description:
        'Cam là một loại quả của nhiều loài cây có múi khác nhau thuộc họ Cửu lý hương; nó chủ yếu đề cập đến Citrus × sinensis, mà còn được gọi là cam ngọt, để phân biệt với Citrus × aurantium có liên quan, được gọi là cam chua. Cam ngọt sinh sản vô tính; giống cam ngọt phát sinh do đột biến',
    title: 'Trái cam',
    image: 'https://dt-pro.vn/upload/product/cam-my.jpg',
    percent: '35%',
    numberPerson: '30',
  ),
  Product(
    id: '3',
    description:
        'Quả táo có chứa rất nhiều dưỡng chất có lợi cho sức khỏe của bạn chẳng hạn như Carb, chất xơ, đường, chất béo, vitamin C, kali, magie,… Tuy cung cấp nhiều dinh dưỡng nhưng một quả táo chỉ có chứa 52 calo. ',
    title: 'Trái táo',
    image:
        'https://cdn.pixabay.com/photo/2014/12/21/23/25/apples-575317_640.png',
    percent: '85%',
    numberPerson: '30',
  ),
];
