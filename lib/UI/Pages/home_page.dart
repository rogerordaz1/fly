import 'package:flutter/material.dart';
import 'package:fly_cliente/UI/Pages/airline_details.dart';

import '../Widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: size.width * 0.1,
          top: size.height * 0.05,
          right: size.width * 0.1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomCircleAvatar(),
            SizedBox(
              height: size.height * 0.2,
            ),
            HavanaAirWidget(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AirlinePage())),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            const NoAirline(),
          ],
        ),
      ),
    ));
  }
}

class NoAirline extends StatelessWidget {
  const NoAirline({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomCard(
      height: size.height * 0.12,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color.fromRGBO(130, 130, 130, 1),
        ),
        child: const Center(
            child: Text(
          'Más aerolíneas próximamente',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}

class HavanaAirWidget extends StatelessWidget {
  const HavanaAirWidget({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: CustomCard(
        height: size.height * 0.12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: size.width * 0.25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/logo.jpg',
                    ),
                    fit: BoxFit.fill,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Charter Cuba',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Havana Air',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    this.height,
    required this.child,
  }) : super(key: key);

  final double? height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            offset: Offset(2, 0),
            blurRadius: 5,
            color: Colors.grey,
          ),
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: child,
    );
  }
}
