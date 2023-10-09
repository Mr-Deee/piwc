class addedMember {
  addedMember({
    this.fname,
    this.firstchild,
    this.secondchild,
    this.thirdchild,
    this.fourthchild,
    this.lname,
    this.fathername,
    this.mothername,
    this.homeTown,
    this.language,
    this.Occupation,
    this.PlaceofWork,
    this.Noofchildren,
    this.residence,
    this.placeofwork,
    this.group,
    this.location,
    this.Region,
    this.company,
    this.quantity,
    this.image,
    this.email,
    this.accountNumber,
    this.mobile,
    this.agentname,
   this.fatherReligion,
    this.motherReligion,
    this.availablebalance,
  });

  String? fname;
  String? Noofchildren;
  String? group;
  String? lname;
  String? agentname;
  String? fathername;
  String? fathershometown;
  String? fatherReligion;
  String? motherReligion;
  String? mothershometown;
  bool ?Maritalstatus;
  String? SpouseName;
  bool? registered;
  String? Where;
  String? when;
  String? email;
  String? mothername;
  String? homeTown;
  String? residence;
  String? language;
  String? firstchild;
  String? secondchild;
  String? thirdchild;
  String? fourthchild;


  String? Occupation;
  String? PlaceofWork;
  String? Region;
  int? availablebalance;
  int? Deposit = 0;
  int? TotalBalance = 0;
  String? placeofwork;
  String? location;
  String? company;
  String? mobile;
  int? quantity;
  String? image;
  String? accountNumber;

  factory addedMember.fromMap(Map<String, dynamic> json) => addedMember(
      // name: json["name"] as String?,

      email: json["Email"] as String?,
      location: json["location"] as String?,
      mobile: json["mobile"] as String?,
      agentname: json["agentname"] as String?,
      homeTown: json["HomeTown"] as String?,
      residence: json["Residence"]as String?,
      // quantity: json["quantity"] as int?,
      image: json["image"] as String?,
      accountNumber: json["Account Number"] as String?,

  );
  Map<String, dynamic> toMap() => {
        // "name": name,
        "TotalBalance": TotalBalance! + Deposit!,
        "UserType": group,
        "agentname": agentname,
        "location": location,
        "image": image,
        "Account Number": accountNumber,
        "mobile": mobile,
      };
}
