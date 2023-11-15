class MmobCustomerInfo {
  String? email;
  String? firstName;
  String? surname;
  String? gender;
  String? title;
  String? buildingNumber;
  String? address1;
  String? townCity;
  String? postcode;
  String? dob;

  MmobCustomerInfo({
    this.email,
    this.firstName,
    this.surname,
    this.gender,
    this.title,
    this.buildingNumber,
    this.address1,
    this.townCity,
    this.postcode,
    this.dob,
  });
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'first_name': firstName,
      'surname': surname,
      'gender': gender,
      'title': title,
      'building_number': buildingNumber,
      'address_1': address1,
      'town_city': townCity,
      'postcode': postcode,
      'dob': dob,
    };
  }
}
