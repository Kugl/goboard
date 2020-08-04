import 'package:go_board/counter.dart';
import 'package:test/test.dart';

void main() {
  group('Game', () {
    test('value should start at 0', () {
      expect(Counter().value, 0);
    });
  });
}
