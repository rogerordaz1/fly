import 'package:flutter/material.dart';
import 'package:fly_cliente/Business_logic/Provaiders/flip_provider.dart';
import 'package:fly_cliente/Business_logic/Provaiders/login_provider.dart';
import 'package:fly_cliente/Business_logic/Provaiders/user_provider.dart';
import 'package:fly_cliente/Constants/contants.dart';
import 'package:fly_cliente/UI/Widgets/PerosnalInfoWidgets/crad_body1.dart';
import 'package:fly_cliente/UI/Widgets/PerosnalInfoWidgets/crad_body2.dart';
import 'package:fly_cliente/UI/Widgets/PerosnalInfoWidgets/crad_body4.dart';
import 'package:fly_cliente/UI/Widgets/PerosnalInfoWidgets/crad_body5.dart';
import 'package:provider/provider.dart';

import '../Widgets/CustomWidget/custom_circle_avatar.dart';
import '../Widgets/PerosnalInfoWidgets/crad_body3.dart';

class PersonalInfoHome extends StatelessWidget {
  const PersonalInfoHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final flipProvaider = Provider.of<FlipProvider>(context);
    final userprovider = Provider.of<UserProvider>(context);
    final loginprovider = Provider.of<LoginProvider>(context);
    return Scaffold(
      //TODO:cambiar la condicion por si tiene o no agregada su info personal
      body: loginprovider.loggedUser!.user.userContacts!.isEmpty
          ? Center(
              child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.1,
                    horizontal: size.width * 0.05,
                  ),
                  child: const AppBarCustom(),
                ),
                SizedBox(
                  height: size.height * 0.15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/PersonalInfo');
                  },
                  child: Icon(
                    Icons.group_add_outlined,
                    size: 100,
                    color: kprimarycolor,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.1,
                  width: size.width * 0.8,
                  child: Center(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.12),
                      child: const Text(
                        "Add my personal information",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ))
          : PageView(
              scrollDirection: Axis.vertical,
              children: [
                BodyCustom(
                    body: CardBody1(
                  space: 40,
                  firstname: userprovider.selectedContact!.firstName,
                  lastname: userprovider.selectedContact!.lastName,
                  passengerType: userprovider.selectedContact!.passengerType,
                  birthDate: userprovider.selectedContact!.birthDate!,
                  gender: userprovider.selectedContact!.gender!,
                  email: userprovider.selectedContact!.email!,
                  phone: userprovider.selectedContact!.phone!,
                )),
                BodyCustom(
                    body: CardBody2(
                  address: userprovider.selectedContact!.address!,
                  city: userprovider.selectedContact!.city!,
                  state: userprovider.selectedContact!.state!,
                  zipCode: userprovider.selectedContact!.zip!,
                  country: userprovider.selectedContact!.country!,
                  nationality: userprovider.selectedContact!.nationality!,
                  space: 40,
                )),
                BodyCustom(
                    body: CardBody3(
                  ofacCode: userprovider.selectedContact!.ofacCode!,
                  motherMaiden: userprovider.selectedContact!.mothersMaiden!,
                  foreignAdress: userprovider.selectedContact!.foreignAddress!,
                  foreignCity: userprovider.selectedContact!.foreignCity!,
                  foreignprovince:
                      userprovider.selectedContact!.foreignProvince!,
                  emergencyNumber:
                      userprovider.selectedContact!.emergencyPhone!,
                  foreignZipCode: userprovider.selectedContact!.foreignZip!,
                  space: 40,
                )),
                BodyCustom(
                    body: CardBody4(
                  emergencyPhone: userprovider.selectedContact!.emergencyPhone!,
                  cubanFirstName: userprovider.selectedContact!.cubanFirstName!,
                  cubanLastName: userprovider.selectedContact!.cubanLastName!,
                  arrivalDocs: userprovider.selectedContact!.arrivalDoc!,
                  countryIssue: userprovider.selectedContact!.countryOfIssue!,
                  arrivalDocNo: userprovider.selectedContact!.arrivalDocNo!,
                  space: 40,
                )),
                BodyCustom(
                    body: CardBody5(
                  expDate: userprovider.selectedContact!.expDate!,
                  passportNumbersec:
                      userprovider.selectedContact!.passportNumberSec!,
                  contryOfIssuesec:
                      userprovider.selectedContact!.countryOfIssueSec!,
                  arrivalDocNumbersec:
                      userprovider.selectedContact!.arrivalDocNoSec!,
                  expDatesec: userprovider.selectedContact!.expDateSec!,
                  space: 40,
                )),
              ],
            ),
    );
  }
}

class BodyCustom extends StatelessWidget {
  const BodyCustom({
    Key? key,
    required this.body,
  }) : super(key: key);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          height: size.height,
          width: size.width,
        ),
        Positioned(
          top: size.height * 0.1,
          left: size.width * 0.05,
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              // color: Colors.white,
              //  height: size.height * 0.87,
              width: size.width * 0.9,
              child: body),
        ),
      ],
    );
  }
}

class AppBarCustom extends StatelessWidget {
  const AppBarCustom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.navigate_before,
            size: 40,
            color: kprimarycolor,
          ),
        ),
        const CustomCircleAvatar()
      ],
    );
  }
}
