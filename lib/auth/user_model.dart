
class UserModel {
    var id;
    var email;
    var firstName;
    var lastName;
    var phoneNumber;
    var password;

    UserModel(
      this.email,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.password,
      this.id
    );
    

    Map<String, dynamic> toJson() => {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'password': password,
        'userId': id
      };
}