import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wego_clone/app_colors.dart';
import 'package:wego_clone/components/default_button.dart';
import 'package:wego_clone/components/flight/flight_item.dart';
import 'package:wego_clone/screens/flight/arrival/arrival_screen.dart';
import 'package:wego_clone/screens/flight/departure/departure_screen.dart';
import 'package:wego_clone/screens/flight/flight_search/flight_search_screen.dart';
import 'package:wego_clone/screens/flight/passengers/passengers_screen.dart';
import 'package:wego_clone/screens/flight/payments/payments_screen.dart';
import 'package:wego_clone/state-management/provider.dart';
import 'package:wego_clone/translations/locale_keys.g.dart';

class OneWayScreen extends StatefulWidget {
  OneWayScreen({Key? key}) : super(key: key);

  @override
  State<OneWayScreen> createState() => _OneWayScreenState();
}

class _OneWayScreenState extends State<OneWayScreen> {
  List<Widget> classesList = [
    Center(
      child: Text(
        'Economy',
        style: TextStyle(color: AppColors.defaultGreyColor, fontSize: 16.0),
      ),
    ),
    Center(
      child: Text(
        'Premium Economy',
        style: TextStyle(color: AppColors.defaultGreyColor, fontSize: 16.0),
      ),
    ),
    Center(
      child: Text(
        'Business Class',
        style: TextStyle(color: AppColors.defaultGreyColor, fontSize: 16.0),
      ),
    ),
    Center(
      child: Text(
        'First Class',
        style: TextStyle(color: AppColors.defaultGreyColor, fontSize: 16.0),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    String departureDate = context.watch<FlightProvider>().date == 'Select'
        ? LocaleKeys.select.tr()
        : context.watch<FlightProvider>().date;
    int adultNumber = context.watch<FlightProvider>().adultNumber;
    int childNumber = context.watch<FlightProvider>().childNumber;
    int infantNumber = context.watch<FlightProvider>().infantNumber;
    bool isVisaChoosed = context.watch<FlightProvider>().isVisaChoosed;
    bool isMasterCardChoosed =
        context.watch<FlightProvider>().isMasterCardChoosed;
    int _currentIndex = context.watch<FlightProvider>().choosedFlightClassIndex;
    String departurePlace =
        context.watch<FlightProvider>().departurePlace == 'Choose Departure'
            ? LocaleKeys.chooseDeparture.tr()
            : context.watch<FlightProvider>().departurePlace;
    String departurePlaceCode =
        context.watch<FlightProvider>().departurePlaceCode;
    String arrivalPlace =
        context.watch<FlightProvider>().arrivalPlace == 'Choose Arrival'
            ? LocaleKeys.chooseArrival.tr()
            : context.watch<FlightProvider>().arrivalPlace;
    String arrivalPlaceCode = context.watch<FlightProvider>().arrivalPlaceCode;
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          FlightItem(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DepartureScreen(),
                ),
              );
            },
            icon: Icons.flight_takeoff_outlined,
            content: Text(
              '$departurePlace ${departurePlaceCode == '' ? '' : '($departurePlaceCode)'}',
              style:
                  TextStyle(color: AppColors.defaultGreyColor, fontSize: 16.0),
            ),
          ),
          FlightItem(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ArrivalScreen(),
                ),
              );
            },
            icon: Icons.flight_land_outlined,
            content: Text(
              '$arrivalPlace ${arrivalPlaceCode == '' ? '' : '($arrivalPlaceCode)'}',
              style:
                  TextStyle(color: AppColors.defaultGreyColor, fontSize: 16.0),
            ),
          ),
          FlightItem(
            onPressed: () async {
              context.read<FlightProvider>().setDepartureDate(context);
            },
            icon: Icons.calendar_month_rounded,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.departureDate.tr(),
                  style: TextStyle(
                    color: AppColors.defaultShadowedGreyColor,
                    fontSize: 13.0,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  departureDate,
                  style: TextStyle(
                    color: AppColors.defaultGreyColor,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
          FlightItem(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PassengersScreen(),
                ),
              );
            },
            icon: Icons.people,
            content: Text(
              '$adultNumber ${LocaleKeys.adult.tr()}${childNumber > 0 ? ', $childNumber ${LocaleKeys.child.tr()}' : ''}${infantNumber > 0 ? ', $infantNumber ${LocaleKeys.infant.tr()}' : ''}',
              style:
                  TextStyle(color: AppColors.defaultGreyColor, fontSize: 16.0),
            ),
          ),
          FlightItem(
            onPressed: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return CupertinoActionSheet(
                    actions: [
                      SizedBox(
                        height: 300.0,
                        child: CupertinoPicker(
                          itemExtent: 64.0,
                          diameterRatio: 1,
                          onSelectedItemChanged: (index) {
                            context
                                .read<FlightProvider>()
                                .setFlightClass(index);
                          },
                          children: classesList,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icons.shopping_bag_rounded,
            content: classesList[_currentIndex],
          ),
          FlightItem(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentsScreen(),
                ),
              );
            },
            icon: Icons.credit_card_rounded,
            content: Text(
              '${isVisaChoosed == false && isMasterCardChoosed == false ? LocaleKeys.choose.tr() : (isVisaChoosed ? 'Visa Debit' : '')}${isMasterCardChoosed ? (isVisaChoosed ? ', MasterCard Debit' : 'MasterCard Debit') : ''}',
              style:
                  TextStyle(color: AppColors.defaultGreyColor, fontSize: 16.0),
            ),
          ),
          const Spacer(),
          DefaultButton(
            text: LocaleKeys.searchFlight.tr(),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FlightSearchScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
