
import 'package:provider/provider.dart';

class addedMember {
  addedMember({
    this.name,
    this.Deposit,
    this.TotalBalance,
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

  String? name;
  String? agentname;
  int? availablebalance;
  int? Deposit=0;
  int? TotalBalance =0;
  String? group;
  String? location;
  String? company;
  String? mobile;
  int? quantity;
  String? image;
  String? accountNumber;

  factory addedMember.fromMap(Map<String, dynamic> json) => addedMember(
      name: json["name"] as String?,
      Deposit: json["Deposit amount"] as int?,
      group: json["UserType"] as String?,
      location: json["location"] as String?,
      mobile: json["mobile"] as String?,
      agentname: json["agentname"] as String?,
      // company: json["company"] as String?,
      // quantity: json["quantity"] as int?,
      image: json["image"] as String?,
      accountNumber: json["Account Number"] as String?,
      TotalBalance:json["TotalBalance"] as int?
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "Deposit amount": Deposit,
    "TotalBalance": TotalBalance!+Deposit!,
    "UserType": group,
    "agentname": agentname,
    "location": location,
    "image": image,
    "Account Number": accountNumber,
    "mobile": mobile,
  };
}
