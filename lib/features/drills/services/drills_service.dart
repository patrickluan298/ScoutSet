import '../../../data/local/database/app_services.dart';
import '../models/drill.dart';

class DrillsService {
  DrillsService._();

  static final DrillsService instance = DrillsService._();

  Future<void> initialize() async {
    await AppServices.initialize();
  }

  Future<List<Drill>> listDrills() async {
    await initialize();
    return AppServices.drillsRepository.listDrills();
  }

  Future<Drill?> getById(String id) async {
    await initialize();
    return AppServices.drillsRepository.getDrillById(id);
  }
}
