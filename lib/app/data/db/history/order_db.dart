import '../../../../shared/shared_enum.dart';
import '../model/model_db.dart';

class OrderDB {
  final String id;
  final TypeGoods type;
  final StatusApproval statusApproval;
  final MethodPayment? methodPayment;
  final StatusPayment? statusPayment;
  final List<ModelDB> models;
  final DateTime createdAt;

  OrderDB({
    required this.id,
    required this.type,
    required this.statusApproval,
    this.statusPayment,
    this.methodPayment,
    required this.models,
    required this.createdAt,
  });
}
