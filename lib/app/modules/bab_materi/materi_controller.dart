import 'package:eng_app/app/data/models/materi_model.dart';
import 'package:eng_app/app/data/services/materi_service.dart';
import 'package:get/get.dart';

class MateriController extends GetxController {
  var materiList = <MateriModel>[].obs;
  var isLoading = true.obs;

  final MateriService _service = Get.put(MateriService());

  @override
  void onInit() {
    super.onInit();
  }

  void fetchMateri() async {
    try {
      isLoading(true);
      final result = await _service.fetchMateri();
      materiList.assignAll(result);
    } catch (e) {
      print('Gagal mengambil data: $e');
    } finally {
      isLoading(false);
    }
  }
}
