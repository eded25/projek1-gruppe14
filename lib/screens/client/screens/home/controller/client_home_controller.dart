import 'package:barber_select/models/portfolio_model.dart';
import 'package:barber_select/models/service_model.dart';
import 'package:barber_select/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientHomeController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  RxList<ServiceModel> services =
      <ServiceModel>[
        ServiceModel(id: '1', name: 'Side Part', quantity: 2),
        ServiceModel(id: '2', name: 'Pampadour', quantity: 3),
        ServiceModel(id: '3', name: 'Fade Cut', quantity: 5),
        ServiceModel(id: '3', name: 'Fade Cut', quantity: 8),
        ServiceModel(id: '4', name: 'Gaotee', quantity: 9),
        ServiceModel(id: '5', name: 'Extended Goatee', quantity: 12),
        ServiceModel(id: '6', name: 'Crew Cut', quantity: 1),
      ].obs;

  RxList<PortfolioModel> portfolios =
      <PortfolioModel>[
        PortfolioModel(id: '1', name: 'High and Tight'),
        PortfolioModel(id: '2', name: 'Side Part'),
        PortfolioModel(id: '3', name: 'Faux Hawk'),
        PortfolioModel(id: '4', name: 'Ivy League Cut'),
      ].obs;

  RxList<UserModel> barbers =
      <UserModel>[
        UserModel(
          userId: '1',
          name: 'Adam',
          availableTimes: ['10:00 AM - 6:00 PM'],
          rating: 4.5,
          number: '923191-98867',
          birthdayMonth: 'January',
          observation: 'Very skilled with fades',
          value: 25.0,
          extraInformation: 'Available on weekends too',
          neighborhood: 'Malasaña',
          city: 'Madrid',
          state: 'Community of Madrid',
        ),
        UserModel(
          userId: '2',
          name: 'Sid',
          availableTimes: ['11:00 AM - 7:00 PM'],
          rating: 4.2,
          number: '923191-98867',
          birthdayMonth: 'February',
          observation: 'Prefers short appointments',
          value: 22.0,
          extraInformation: 'Specializes in beard grooming',
          neighborhood: 'Chamberí',
          city: 'Madrid',
          state: 'Community of Madrid',
        ),
        UserModel(
          userId: '3',
          name: 'Parker',
          availableTimes: ['09:00 AM - 5:00 PM'],
          rating: 4.8,
          number: '923191-98867',
          birthdayMonth: 'March',
          observation: 'Great with kids haircuts',
          value: 27.0,
          extraInformation: 'Offers custom styles',
          neighborhood: 'Lavapiés',
          city: 'Madrid',
          state: 'Community of Madrid',
        ),
        UserModel(
          userId: '4',
          name: 'Arther M.',
          availableTimes: ['12:00 PM - 8:00 PM'],
          rating: 4.6,
          number: '923191-98867',
          birthdayMonth: 'April',
          observation: 'Talkative and friendly',
          value: 23.0,
          extraInformation: 'Always on time',
          neighborhood: 'Salamanca',
          city: 'Madrid',
          state: 'Community of Madrid',
        ),
      ].obs;
}
