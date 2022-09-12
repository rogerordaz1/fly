import 'package:flutter/material.dart';
import 'package:fly_cliente/Business_logic/Provaiders/book_flight_provider.dart';
import 'package:provider/provider.dart';
import '../../../Business_logic/Provaiders/flight_provider.dart';
import '../../../Constants/contants.dart';
import '../CustomWidget/custom_dropdown.dart';
import '../imputField.dart';
import '../weeked_day.dart';

class SearchFilters extends StatefulWidget {
  const SearchFilters({
    Key? key,
    required this.onPreesedFuntionButton,
  }) : super(key: key);

  final VoidCallback onPreesedFuntionButton;

  @override
  State<SearchFilters> createState() => _SearchFiltersState();
}

class _SearchFiltersState extends State<SearchFilters> {
  @override
  Widget build(BuildContext context) {
    final flightProvaider = Provider.of<FlightProvider>(context);
    final bookFlightProvider = Provider.of<BookFlightProvider>(context);
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.75,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 0.1,
        ),
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.all(Radius.circular(size.height * 0.01)),
      ),
      padding: EdgeInsets.only(
          left: size.width * 0.060,
          right: size.width * 0.040,
          top: size.width * 0.03),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            const TextSearch(texto: 'Flight Number'),
            SizedBox(
              width: size.width * 0.12,
            ),
          ],
        ),
        //Segunda Row
        Padding(
          padding: EdgeInsets.only(top: size.height * 0.01),
          child: Row(
            children: [
              SizedBox(
                  width: size.width * 0.76,
                  child: CustomDropDown(
                    hintext: 'Flight Number',
                    items: bookFlightProvider.flightNumber,
                    onChanged: (value) =>
                        flightProvaider.flightNumber = value.toString(),
                    onSaved: (value) =>
                        flightProvaider.flightNumber = value.toString(),
                  )),
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        const TextSearch(texto: 'Charter'),
        SizedBox(
          height: size.height * 0.01,
        ),
        SizedBox(
          width: size.width * 0.76,

          //TODO: Hacer el DropDownMeny de aqui.
          child: CustomDropDown(
            hintext: "All",
            items: bookFlightProvider.charter,
            onChanged: (value) {
              flightProvaider.selectedCharter = value.toString();
            },
            onSaved: (value) {
              flightProvaider.selectedCharter = value.toString();
            },
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        const ColumnaStatus2(),
        //separador
        SizedBox(
          height: size.height * 0.01,
        ),
        const TextSearch(texto: 'Date from:/To:'),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.01),
              child: SizedBox(
                width: size.width * 0.318,
                child: Imputfield(
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    DateTime? piked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2027));

                    if (piked != null) {
                      flightProvaider.dateFrom =
                          "${piked.year}/${piked.month <= 9 ? 0.toString() + piked.month.toString() : piked.month}/${piked.day <= 9 ? 0.toString() + piked.day.toString() : piked.day}";
                    }
                  },

                  hintext: flightProvaider.dateFrom == ''
                      ? "From"
                      : flightProvaider.dateFrom,
                  //Aqui va el action del calendar
                  prefixIcon: flightProvaider.dateFrom == ''
                      ? Icon(
                          Icons.calendar_month,
                          color: kprimarycolor,
                        )
                      : null,
                ),
              ),
            ),
            //separador
            SizedBox(
              width: size.width * 0.12,
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.01),
              child: SizedBox(
                width: size.width * 0.318,
                child: Imputfield(
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    DateTime? piked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2027));

                    if (piked != null) {
                      flightProvaider.dateTo =
                          "${piked.year}/${piked.month <= 9 ? 0.toString() + piked.month.toString() : piked.month}/${piked.day <= 9 ? 0.toString() + piked.day.toString() : piked.day}";
                    }
                  },
                  hintext: flightProvaider.dateTo == ''
                      ? "To"
                      : flightProvaider.dateTo,
                  prefixIcon: flightProvaider.dateTo == ''
                      ? Icon(
                          Icons.calendar_month,
                          color: kprimarycolor,
                        )
                      : null,
                ),
              ),
            ),
          ],
        ),
        //separador height
        SizedBox(
          height: size.height * 0.01,
        ),
        const TextSearch(texto: 'Route'),
        //ROw
        Padding(
          padding: EdgeInsets.only(top: size.height * 0.01),
          child: Row(
            children: [
              SizedBox(
                width: size.width * 0.318,
                child: CustomDropDown(
                  hintext: 'From',
                  items: bookFlightProvider.destination,
                  onChanged: (value) =>
                      flightProvaider.selectedRouteFrom = value.toString(),
                  onSaved: (value) =>
                      flightProvaider.selectedRouteFrom = value.toString(),
                ),
              ),
              //separador width
              SizedBox(
                width: size.width * 0.11,
              ),
              SizedBox(
                width: size.width * 0.318,
                child: CustomDropDown(
                  hintext: 'To',
                  items: bookFlightProvider.destination,
                  onChanged: (value) =>
                      flightProvaider.selectedRouteTo = value.toString(),
                  onSaved: (value) =>
                      flightProvaider.selectedRouteTo = value.toString(),
                ),
              ),
            ],
          ),
        ),
        //separador height
        SizedBox(
          height: size.height * 0.01,
        ),
        const TextSearch(texto: 'Weekdays'),

        SizedBox(
          height: size.height * 0.01,
        ),
        const WeekDays(),
        // SizedBox(
        //   height: size.height * 0.035,
        // ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //const ColumnaStatus2(),
            SizedBox(
              width: size.width * 0.08,
            ),
            // const ColumnStatus1(),
          ],
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.18),
          child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: widget.onPreesedFuntionButton,
            height: size.height * 0.063,
            minWidth: size.width * 0.01,
            color: const Color.fromRGBO(1, 63, 148, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 28,
                ),
                SizedBox(
                  width: size.width * 0.02,
                ),
                const Text("Search",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
          ),
        )
      ]),
    );
  }
}

class WeekDays extends StatelessWidget {
  const WeekDays({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flightProvaider = Provider.of<FlightProvider>(context);
    List<Widget> list = [
      WeekedDay(
          texto: "Su", isSelected: flightProvaider.dayInWeekList[0].isSelected),
      const CustomSpacer(),
      WeekedDay(
          texto: "M", isSelected: flightProvaider.dayInWeekList[1].isSelected),
      const CustomSpacer(),
      WeekedDay(
          texto: "Tu", isSelected: flightProvaider.dayInWeekList[2].isSelected),
      const CustomSpacer(),
      WeekedDay(
          texto: "W", isSelected: flightProvaider.dayInWeekList[3].isSelected),
      const CustomSpacer(),
      WeekedDay(
          texto: "T", isSelected: flightProvaider.dayInWeekList[4].isSelected),
      const CustomSpacer(),
      WeekedDay(
          texto: "F", isSelected: flightProvaider.dayInWeekList[5].isSelected),
      const CustomSpacer(),
      WeekedDay(
          texto: "S", isSelected: flightProvaider.dayInWeekList[6].isSelected),
    ];

    return Row(children: list);
  }
}

class ColumnStatus1 extends StatefulWidget {
  const ColumnStatus1({
    Key? key,
  }) : super(key: key);

  @override
  State<ColumnStatus1> createState() => _ColumnStatus1State();
}

class _ColumnStatus1State extends State<ColumnStatus1> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final flightProvaider = Provider.of<FlightProvider>(context);
    return SizedBox(
      height: size.height * 0.11,
      width: size.width * 0.32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextSearch(texto: "Status"),
          SizedBox(
            height: size.height * 0.004,
          ),
          flightProvaider.selectedStatus == true
              ? Row(
                  children: [
                    CheckStatus(size: size),
                    SizedBox(
                      width: size.width * 0.015,
                    ),
                    Column(
                      children: const [
                        TextSearch(
                          texto: "Open",
                        ),
                        Icon(
                          Icons.check_circle,
                          size: 25,
                          color: Colors.green,
                        )
                      ],
                    ),
                  ],
                )
              : Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height * 0.004,
                        ),
                        Row(
                          children: [
                            CheckStatus(size: size),
                            SizedBox(
                              width: size.width * 0.015,
                            ),
                            Column(
                              children: const [
                                TextSearch(texto: "Closed"),
                                Icon(
                                  Icons.cancel,
                                  size: 25,
                                  color: Colors.red,
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class CheckStatus extends StatefulWidget {
  const CheckStatus({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<CheckStatus> createState() => _CheckStatusState();
}

class _CheckStatusState extends State<CheckStatus> {
  @override
  Widget build(BuildContext context) {
    final flightProvaider = Provider.of<FlightProvider>(context);
    return SizedBox(
      height: widget.size.height * 0.045,
      width: widget.size.width * 0.07,
      child: Transform.scale(
        scale: 1.8,
        child: Checkbox(
          value: flightProvaider.selectedStatus,
          onChanged: (value) {
            if (value == true) {
              flightProvaider.changeValorselectedStatus(true);
            }
            if (value == false) {
              flightProvaider.changeValorselectedStatus(false);
            }

            // valor = value!;
          },
        ),
      ),
    );
  }
}

class CustomSpacer extends StatelessWidget {
  const CustomSpacer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.018,
    );
  }
}

class TextSearch extends StatelessWidget {
  const TextSearch({
    Key? key,
    required this.texto,
  }) : super(key: key);

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: const TextStyle(fontSize: 18),
    );
  }
}

class ColumnaStatus2 extends StatelessWidget {
  const ColumnaStatus2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flightProvaider = Provider.of<FlightProvider>(context);
    final bookFlightProvider = Provider.of<BookFlightProvider>(context);
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextSearch(texto: 'Gate'),
        SizedBox(
          height: size.height * 0.01,
        ),
        SizedBox(
          width: size.width * 0.75,
          child: CustomDropDown(
            hintext: 'Gate Number',
            items: bookFlightProvider.gate,
            onChanged: (value) =>
                flightProvaider.selectedGate = value.toString(),
            onSaved: (value) => flightProvaider.selectedGate = value.toString(),
          ),
        ),
      ],
    );
  }
}
