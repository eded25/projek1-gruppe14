import 'package:barber_select/models/service_model.dart';
import 'package:get/get.dart';

class BarberSettingsController extends GetxController {
  RxList<ServiceModel> services =
      <ServiceModel>[
        ServiceModel(id: '1', name: 'Goatee', quantity: 12),
        ServiceModel(id: '2', name: 'Circle Beard',   quantity: 3),
        ServiceModel(id: '3', name: 'Fade cut', quantity: 4),
        ServiceModel(id: '3', name: 'Fade Cut' , quantity: 2),
      ].obs;
}
