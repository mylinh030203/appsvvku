import '../../data/local/mark.local.dart';

abstract class MarkRepository {
  Future<MarkLocal> fetchMarkUser(String token);
}
