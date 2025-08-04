import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/location.dart';
import '../repositories/location_repository.dart';

final locationViewModelProvider =
    StateNotifierProvider<LocationViewModel, List<Location>>((ref) {
      return LocationViewModel();
    });

class LocationViewModel extends StateNotifier<List<Location>> {
  LocationViewModel() : super([]);

  final _repository = LocationRepository();

  Future<void> search(String keyword) async {
    final results = await _repository.search(keyword);
    state = results;
  }
}
