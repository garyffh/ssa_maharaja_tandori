class User {
  User({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.cardNumber,
    required this.ceo,
    required this.admin,
    required this.driver,
    required this.waiter,
  });

  final String email;
  final String firstName;
  final String lastName;
  final String cardNumber;
  final bool ceo;
  final bool admin;
  final bool driver;
  final bool waiter;

}
