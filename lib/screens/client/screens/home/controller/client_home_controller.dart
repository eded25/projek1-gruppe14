import 'package:barber_select/models/portfolio_model.dart';
import 'package:barber_select/models/service_model.dart';
import 'package:barber_select/models/user_model.dart';
import 'package:barber_select/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientHomeController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // Services bleiben als Mock-Daten (sind ja Service-Kategorien)
  RxList<ServiceModel> services = <ServiceModel>[
    ServiceModel(id: '1', name: 'Side Part', quantity: 2),
    ServiceModel(id: '2', name: 'Pampadour', quantity: 3),
    ServiceModel(id: '3', name: 'Fade Cut', quantity: 5),
    ServiceModel(id: '3', name: 'Fade Cut', quantity: 8),
    ServiceModel(id: '4', name: 'Goatee', quantity: 9),
    ServiceModel(id: '5', name: 'Extended Goatee', quantity: 12),
    ServiceModel(id: '6', name: 'Crew Cut', quantity: 1),
  ].obs;

  // Portfolios bleiben als Mock Daten
  RxList<PortfolioModel> portfolios = <PortfolioModel>[
    PortfolioModel(id: '1', name: 'High and Tight'),
    PortfolioModel(id: '2', name: 'Side Part'),
    PortfolioModel(id: '3', name: 'Faux Hawk'),
    PortfolioModel(id: '4', name: 'Ivy League Cut'),
  ].obs;

  // barber dynamisch aus Datenbank
  RxList<UserModel> barbers = <UserModel>[].obs;
  RxBool isLoadingBarbers = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadBarbersFromDatabase();
  }

  // Lade Barber aus DB via API
  Future<void> loadBarbersFromDatabase() async {
    isLoadingBarbers.value = true;
    print(' Home: Lade Barber aus der Datenbank...');

    try {
      final barberData = await ApiService.listBarbers();
      print(' Home: API Response: ${barberData.length} Barber gefunden');

      if (barberData.isNotEmpty) {
        final loadedBarbers = barberData.map<UserModel>((barber) {
          return UserModel(
            userId: barber['id'].toString(),
            name: barber['name'] ?? 'Barber',
            availableTimes: _getAvailableTimes(barber['id'].toString()),
            rating: _calculateRating(barber['id'].toString()),
            number: barber['phone'] ?? '0123456789',
            birthdayMonth: 'Januar',
            observation: barber['bio'] ?? 'Professional Barber',
            value: _getBasePrice(barber['id'].toString()),
            extraInformation: barber['bio'] ?? '',
            neighborhood: _getNeighborhood(barber['location']),
            city: barber['location'] ?? 'Frankfurt',
            state: 'Deutschland',
          );
        }).toList();

        barbers.assignAll(loadedBarbers);
        print(' Home: ${barbers.length} Barber erfolgreich geladen');
      } else {
        print('⚠️ Home: Keine Barber gefunden, verwende Mock-Daten');
        _loadMockBarbers();
      }
    } catch (e) {
      print(' Home: Fehler beim Laden: $e');
      _loadMockBarbers();
    } finally {
      isLoadingBarbers.value = false;
    }
  }

  // Helper-Methoden
  List<String> _getAvailableTimes(String barberId) {
    switch (barberId) {
      case '1':
        return ['10:00 AM - 6:00 PM'];
      case '2':
        return ['11:00 AM - 7:00 PM'];
      case '3':
        return ['09:00 AM - 5:00 PM'];
      case '4':
        return ['12:00 PM - 8:00 PM'];
      default:
        return ['10:00 AM - 6:00 PM'];
    }
  }

  double _calculateRating(String barberId) {
    switch (barberId) {
      case '1':
        return 4.5;
      case '2':
        return 4.2;
      case '3':
        return 4.8;
      case '4':
        return 4.6;
      default:
        return 4.0;
    }
  }

  double _getBasePrice(String barberId) {
    switch (barberId) {
      case '1':
        return 25.0;
      case '2':
        return 22.0;
      case '3':
        return 30.0;
      case '4':
        return 28.0;
      default:
        return 25.0;
    }
  }

  String _getNeighborhood(String? location) {
    if (location == null) return 'Innenstadt';
    switch (location) {
      case 'Frankfurt':
        return 'Downtown';
      case 'Madrid':
        return 'Salamanca';
      default:
        return location;
    }
  }

  // Fallback Mock Daten falls API nicht erreichbar
  void _loadMockBarbers() {
    barbers.assignAll([
      UserModel(
        userId: '1',
        name: 'Demo Barber 1',
        availableTimes: ['10:00 AM - 6:00 PM'],
        rating: 4.5,
        number: '923191-98867',
        birthdayMonth: 'January',
        observation: 'Demo Barber',
        value: 25.0,
        extraInformation: 'Demo Daten',
        neighborhood: 'Downtown',
        city: 'Frankfurt',
        state: 'Deutschland',
      ),
    ]);
  }
}
