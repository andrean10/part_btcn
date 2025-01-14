import 'package:part_btcn/app/data/db/discount/discount.dart';

import '../nav_item_admin/part.dart';
import '../voucher/voucher.dart';

class RequestParts {
  final List<Part> parts;
  final Discount discount;
  final Voucher voucher;

  RequestParts({
    required this.parts,
    required this.discount,
    required this.voucher,
  });
}
