class User {
  final String fullName;
  final String userName;
  final String email;
  final String avatar;

  User({
    required this.fullName,
    required this.userName,
    required this.email,
    required this.avatar,
  });
}

User userFake = User(
  fullName: 'Giap Chi Cuong',
  userName: 'giapchicuong',
  email: 'giapchicuong@gmail.com',
  avatar:
      'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1726358400&semt=ais_hybrid',
);
