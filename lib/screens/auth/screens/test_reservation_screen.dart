import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:barber_select/services/api_service.dart';

class TestReservationController extends GetxController {
  final tecUserId = TextEditingController(text: '1');
  final tecSlotId = TextEditingController(text: '1');
  final tecReservationId = TextEditingController(); // wird nach Create gefüllt
  final tecStatusFilter = TextEditingController(text: ''); // z.B. approved

  RxBool loading = false.obs;
  RxList<Map<String, dynamic>> items = <Map<String, dynamic>>[].obs;
  RxString lastResponse = ''.obs;

  Future<void> create() async {
    loading.value = true;
    lastResponse.value = '';
    try {
      final userId = int.parse(tecUserId.text.trim());
      final slotId = int.parse(tecSlotId.text.trim());

      final res = await ApiService.createReservation(
        userId: userId,
        slotId: slotId,
        paymentMethod: 'cash',
      );
      lastResponse.value = res.toString();

      if (res['status'] == 'success') {
        tecReservationId.text = '${res['reservation_id']}';
        Get.snackbar(
            'OK', 'Reservation #${tecReservationId.text} angelegt (pending)');
      } else {
        Get.snackbar('Fehler', '${res['message']}');
      }
    } catch (e) {
      Get.snackbar('Exception', e.toString());
    } finally {
      loading.value = false;
    }
  }

  Future<void> approve() async {
    if (tecReservationId.text.isEmpty) {
      Get.snackbar('Hinweis', 'Reservation ID zuerst anlegen/eintragen');
      return;
    }
    loading.value = true;
    try {
      final id = int.parse(tecReservationId.text.trim());
      final res = await ApiService.approveReservation(
        id: id,
        action: 'approve',
        approvedBy: 'admin@test.de',
      );
      lastResponse.value = res.toString();
      Get.snackbar('Approve', res.toString());
    } catch (e) {
      Get.snackbar('Exception', e.toString());
    } finally {
      loading.value = false;
    }
  }

  Future<void> cancel() async {
    if (tecReservationId.text.isEmpty) {
      Get.snackbar('Hinweis', 'Reservation ID zuerst anlegen/eintragen');
      return;
    }
    loading.value = true;
    try {
      final id = int.parse(tecReservationId.text.trim());
      final res = await ApiService.cancelReservation(id);
      lastResponse.value = res.toString();
      Get.snackbar('Cancel', res.toString());
    } catch (e) {
      Get.snackbar('Exception', e.toString());
    } finally {
      loading.value = false;
    }
  }

  Future<void> loadMyList() async {
    loading.value = true;
    items.clear();
    try {
      final userId = int.parse(tecUserId.text.trim());
      final status = tecStatusFilter.text.trim().isEmpty
          ? null
          : tecStatusFilter.text.trim();
      final list = await ApiService.listReservationsForUser(
        userId: userId,
        status: status,
      );
      // in Map casten für einfache Anzeige
      items.assignAll(list.cast<Map<String, dynamic>>());
    } catch (e) {
      Get.snackbar('Exception', e.toString());
    } finally {
      loading.value = false;
    }
  }
}

class TestReservationScreen extends StatelessWidget {
  const TestReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(TestReservationController());
    return Scaffold(
      appBar: AppBar(title: const Text('Reservation Test')),
      body: Obx(() => AbsorbPointer(
            absorbing: c.loading.value,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(children: [
                    Expanded(
                      child: TextField(
                        controller: c.tecUserId,
                        decoration: const InputDecoration(
                          labelText: 'user_id',
                          hintText: 'z.B. 1',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: c.tecSlotId,
                        decoration: const InputDecoration(
                          labelText: 'slot_id',
                          hintText: 'z.B. 1',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ]),
                  const SizedBox(height: 12),
                  Row(children: [
                    Expanded(
                      child: TextField(
                        controller: c.tecReservationId,
                        decoration: const InputDecoration(
                          labelText: 'reservation_id (nach Create)',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: c.tecStatusFilter,
                        decoration: const InputDecoration(
                          labelText: 'Filter status (optional)',
                          hintText: 'pending/approved/cancelled',
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ElevatedButton(
                        onPressed: c.create,
                        child: const Text('Create'),
                      ),
                      ElevatedButton(
                        onPressed: c.approve,
                        child: const Text('Approve'),
                      ),
                      ElevatedButton(
                        onPressed: c.cancel,
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: c.loadMyList,
                        child: const Text('Load My List'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (c.loading.value) const LinearProgressIndicator(),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Last response: ${c.lastResponse}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                  const Divider(height: 24),
                  Expanded(
                    child: ListView.separated(
                      itemCount: c.items.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (_, i) {
                        final m = c.items[i];
                        return ListTile(
                          title: Text(
                              'Res #${m['reservation_id']} • ${m['status']}'),
                          subtitle: Text(
                              'slot_id=${m['slot_id']} • ${m['date_time']} • dur=${m['duration_min']}m'),
                          trailing: Text('${m['customer_name'] ?? ''}'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
