class addedMember {
  addedMember({
    this.fname,
    this.lname,
    this.fathername,
    this.mothername,
    this.homeTown,
    this.language,
    this.Occupation,
    this.PlaceofWork,
    this.group,
    this.location,
    this.company,
    this.quantity,
    this.image,
    this.accountNumber,
    this.mobile,
    this.agentname,
    this.availablebalance,
  });

  String? fname;
  String? lname;
  String? agentname;
  String? fathername;
  String? mothername;
  String? homeTown;
  String? language;

  String? Occupation;
  String? PlaceofWork;
  int? availablebalance;
  int? Deposit = 0;
  int? TotalBalance = 0;
  String? group;
  String? location;
  String? company;
  String? mobile;
  int? quantity;
  String? image;
  String? accountNumber;

  factory addedMember.fromMap(Map<String, dynamic> json) => addedMember(
      // name: json["name"] as String?,

      group: json["UserType"] as String?,
      location: json["location"] as String?,
      mobile: json["mobile"] as String?,
      agentname: json["agentname"] as String?,
      // company: json["company"] as String?,
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
