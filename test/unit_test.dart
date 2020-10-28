import 'package:flutter_test/flutter_test.dart';
import 'package:prephq_connect/models/roadmap.dart';

void main() {
  test('Completed should be marked true', () {
    final roadMap = RoadMap(isCompleted: false);

    roadMap.complete();

    expect(roadMap.isCompleted, true);
  });
}