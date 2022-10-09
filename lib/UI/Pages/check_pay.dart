import 'package:flutter/material.dart';
import 'package:fly_cliente/Business_logic/Provaiders/payment_provider.dart';
import 'package:fly_cliente/Constants/contants.dart';
import 'package:fly_cliente/UI/Widgets/fligthDetailWidgets/card_flight_details.dart';
import 'package:fly_cliente/UI/Widgets/fligthDetailWidgets/horizontal_discontinuos_line.dart';
import 'package:provider/provider.dart';

import '../../DataLayer/Models/flight_model.dart';

class CheckPay extends StatelessWidget {
  const CheckPay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paymentProvider = context.read<PaymentsProvider>();

    return SafeArea(
      child: _CheckPayBody(
        departureFlight: paymentProvider.convertflightInRelationtoFlight(),
        returnFlight: paymentProvider.convertflightOutRelationtoFlight(),
      ),
    );
  }
}

class _CheckPayBody extends StatelessWidget {
  const _CheckPayBody({
    Key? key,
    required this.departureFlight,
    required this.returnFlight,
  }) : super(key: key);

  final Flight departureFlight;
  final Flight returnFlight;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _BackButton(),
              SizedBox(height: size.height * 0.015),
              CardFlightDetails(
                customtext: "Flight",
                isCheckedPage: true,
                flight: departureFlight,
              ),
              SizedBox(height: size.height * 0.015),
              CardFlightDetails(
                customtext: 'Return Fligth',
                isCheckedPage: true,
                flight: returnFlight,
              ),
              SizedBox(height: size.height * 0.015),
              const _ContactList(),
              SizedBox(height: size.height * 0.015),
              const PriceCard(),
              SizedBox(height: size.height * 0.015),
              Center(
                child: MaterialButton(
                    height: size.height * 0.06,
                    minWidth: size.width * 0.6,
                    color: kprimarycolor,
                    onPressed: () {
                      final payProvider =
                          Provider.of<PaymentsProvider>(context, listen: false);
                      payProvider.pay();
                    },
                    child: const Text(
                      "Pay Now",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PriceCard extends StatelessWidget {
  const PriceCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paymentProvider = context.read<PaymentsProvider>();
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.18,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey,
          ),
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: size.width * 0.025,
          right: size.width * 0.025,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.02,
                bottom: size.height * 0.01,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sub Total",
                    style: TextStyle(fontSize: 20, color: kprimarycolor),
                  ),
                  Text(
                    '\$ ${paymentProvider.payResponse!.subtotal.toString()}',
                    style: const TextStyle(fontSize: 20, color: Colors.green),
                  ),
                ],
              ),
            ),
            const HorizontalDiscontinuosLine(),
            Padding(
              padding: EdgeInsets.only(
                bottom: size.height * 0.01,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Taxes",
                    style: TextStyle(fontSize: 20, color: kprimarycolor),
                  ),
                  Text(
                    '\$ ${paymentProvider.payResponse!.fees.toString()}',
                    style: const TextStyle(fontSize: 20, color: Colors.green),
                  ),
                ],
              ),
            ),
            const HorizontalDiscontinuosLine(),
            Padding(
              padding: EdgeInsets.only(
                bottom: size.height * 0.01,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20, color: kprimarycolor),
                  ),
                  Text(
                    '\$ ${paymentProvider.payResponse!.total.toString()}',
                    style: const TextStyle(fontSize: 20, color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactList extends StatelessWidget {
  const _ContactList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final paymentProvider = context.read<PaymentsProvider>();
    return Container(
      height: size.height * 0.21,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey,
          ),
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.03, vertical: size.height * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.02),
              child: const Text(
                'Contacts',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.01),
              child: const HorizontalDiscontinuosLine(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: paymentProvider.payResponse!.bookingsContacts.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          paymentProvider.payResponse!.bookingsContacts[index]
                              .contact.firstName,
                          style: const TextStyle(fontSize: 16),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.emoji_people_sharp),
                            Text(
                              paymentProvider
                                  .payResponse!
                                  .bookingsContacts[index]
                                  .contact
                                  .passengerType,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Text(
                          paymentProvider.payResponse!.bookingsContacts[index]
                                          .contact.passengerType ==
                                      "Adult" ||
                                  paymentProvider
                                          .payResponse!
                                          .bookingsContacts[index]
                                          .contact
                                          .passengerType ==
                                      "child"
                              ? "\$ ${paymentProvider.payResponse!.flightInRelation.adultPrice}"
                              : "\$ ${paymentProvider.payResponse!.flightInRelation.boysPrice}",
                          style: const TextStyle(
                              fontSize: 20, color: Colors.green),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Icon(
        Icons.arrow_back_ios_new,
        size: 30,
        color: kprimarycolor,
      ),
    );
  }
}
