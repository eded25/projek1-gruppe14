import 'package:barber_select/models/service_model.dart';
import 'package:get/get.dart';

class RevenueController extends GetxController {
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
}