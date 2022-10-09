import 'package:flutter/material.dart';
import 'package:fly_cliente/Business_logic/Provaiders/forms_providers/status_provider.dart';
import 'package:fly_cliente/Constants/contants.dart';
import 'package:provider/provider.dart';

class CheckReservationStatus extends StatefulWidget {
  const CheckReservationStatus({Key? key}) : super(key: key);

  @override
  State<CheckReservationStatus> createState() => _CheckReservationStatusState();
}

class _CheckReservationStatusState extends State<CheckReservationStatus> {
  @override
  Widget build(BuildContext context) {
    final statusmentProvider = Provider.of<StatusProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StatusContainer(
                id: 1,
                texto: "ACEPTED",
                icono: Icons.check_circle,
                selectedcolor: statusmentProvider.aceptedValue,
                iconcolor: Colors.green,
              ),
              SizedBox(width: size.height * 0.01),
              StatusContainer(
                id: 2,
                texto: "PENDING",
                selectedcolor: statusmentProvider.pendingValue,
                icono: Icons.pending_actions,
                iconcolor: kprimarycolor,
              ),
              SizedBox(width: size.height * 0.01),
              StatusContainer(
                id: 3,
                texto: "REJECTED",
                icono: Icons.cancel,
                selectedcolor: statusmentProvider.rejectedValue,
                iconcolor: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StatusContainer extends StatelessWidget {
  const StatusContainer({
    Key? key,
    required this.texto,
    required this.icono,
    this.selectedcolor,
    this.iconcolor,
    required this.id,
  }) : super(key: key);

  final int id;
  final String texto;
  final IconData icono;
  final bool? selectedcolor;
  final Color? iconcolor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final statusmentProvider = Provider.of<StatusProvider>(context);

    return GestureDetector(
      onTap: () {
        statusmentProvider.index = id;
        statusmentProvider.changeColorSelectedfild();
      },
      child: Container(
        height: size.height * 0.05,
        width: size.width * 0.3,
        decoration: BoxDecoration(
          color: selectedcolor == true ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(texto),
            Icon(
              icono,
              color: selectedcolor == true ? Colors.white : iconcolor,
            ),
          ],
        ),
      ),
    );
  }
}
