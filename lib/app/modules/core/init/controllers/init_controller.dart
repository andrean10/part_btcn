import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../../../../shared/shared_enum.dart';
import '../../../../../utils/constants_keys.dart';
import '../../../../data/db/history/order_db.dart';
import '../../../../data/db/model/model_db.dart';
import '../../../../data/db/model/part/part_db.dart';
import '../../../../routes/app_pages.dart';

class InitController extends GetxController {
  late final FirebaseAuth _auth;
  late final FirebaseFirestore _firestore;
  late final GetStorage _storage;

  FirebaseAuth get auth => _auth;
  FirebaseFirestore get firestore => _firestore;
  GetStorage get localStorage => _storage;

  late final Logger logger;

  late final types.User user;
  late final types.User user2;
  late final types.User user3;

  final dummyHistory = [
    OrderDB(
      id: 'DO/BTCN/2024/0001',
      type: TypeGoods.req,
      statusApproval: StatusApproval.pending,
      statusPayment: StatusPayment.credit,
      methodPayment: MethodPayment.cash,
      createdAt: DateTime.now(),
      models: [
        ModelDB(
          id: 'CLG906F',
          parts: [
            PartDB(
              id: '40C0441P01',
              description: 'ENGINE OIL FILTER ELEMENT 机油滤芯',
              price: 236600,
              quantity: 2,
              images: '',
            ),
            PartDB(
              id: '40C0440P01',
              description: '40C0440P01 fuel filter；129907-55800;ASSY',
              price: 458550,
              quantity: 1,
              images: '',
            ),
          ],
        ),
        ModelDB(
          id: 'CLG906E',
          parts: [
            PartDB(
              id: 'SP238868',
              description: 'COOLANT 20 L',
              price: 41460,
              quantity: 2,
              images: '',
            ),
          ],
        ),
      ],
    ),
    OrderDB(
      id: 'DO/BTCN/2024/0002',
      type: TypeGoods.req,
      statusApproval: StatusApproval.rejected,
      createdAt: DateTime.now(),
      models: [
        ModelDB(
          id: 'CLG906F',
          parts: [
            PartDB(
              id: '40C9921',
              description: '40C9921 FUEL FILTER ELEMENT;ASSY',
              price: 297100,
              quantity: 1,
              images: '',
            ),
          ],
        ),
      ],
    ),
    OrderDB(
      id: 'DO/BTCN/2024/0003',
      type: TypeGoods.req,
      statusApproval: StatusApproval.approved,
      statusPayment: StatusPayment.paid,
      methodPayment: MethodPayment.qris,
      createdAt: DateTime.now(),
      models: [
        ModelDB(
          id: 'CLG906F',
          parts: [
            PartDB(
              id: '53C0837',
              description: '53C0837 FILTER ELEMENT;ASSY',
              price: 174400,
              quantity: 3,
              images: '',
            ),
          ],
        ),
        ModelDB(
          id: 'CLG915E',
          parts: [
            PartDB(
              id: '53C0250',
              description: 'PILOT FILTER ELEMENT；SE-014G10B;ASSY',
              price: 326100,
              quantity: 1,
              images: '',
            ),
          ],
        ),
      ],
    ),
    OrderDB(
      id: 'DO/BTCN/2024/0004',
      type: TypeGoods.req,
      statusApproval: StatusApproval.approved,
      statusPayment: StatusPayment.credit,
      methodPayment: MethodPayment.qris,
      createdAt: DateTime.now().subtract(1.days),
      models: [
        ModelDB(
          id: 'CLG906F',
          parts: [
            PartDB(
              id: '53C0055P01',
              description: '53C0055P01 FILTER',
              price: 1356866,
              quantity: 1,
              images: '',
            ),
          ],
        ),
        ModelDB(
          id: 'CLG835H',
          parts: [
            PartDB(
              id: 'SP177033',
              description: 'ENGINE OIL FILTER ELEMENT 机油滤芯',
              price: 220700,
              quantity: 1,
              images: '',
            ),
          ],
        ),
      ],
    ),
    OrderDB(
      id: 'DO/BTCN/2024/0005',
      type: TypeGoods.req,
      statusApproval: StatusApproval.approved,
      statusPayment: StatusPayment.credit,
      methodPayment: MethodPayment.transfer,
      createdAt: DateTime.now().subtract(1.days),
      models: [
        ModelDB(
          id: 'CLG906F',
          parts: [
            PartDB(
              id: '53C0055P01',
              description: '53C0055P01 FILTER',
              price: 1356866,
              quantity: 1,
              images: '',
            ),
          ],
        ),
        ModelDB(
          id: 'CLG835H',
          parts: [
            PartDB(
              id: 'SP177033',
              description: 'ENGINE OIL FILTER ELEMENT 机油滤芯',
              price: 220700,
              quantity: 1,
              images: '',
            ),
          ],
        ),
      ],
    ),
    OrderDB(
      id: 'DO/BTCN/2024/0006',
      type: TypeGoods.req,
      statusApproval: StatusApproval.approved,
      statusPayment: StatusPayment.credit,
      methodPayment: MethodPayment.cash,
      createdAt: DateTime.now().subtract(1.days),
      models: [
        ModelDB(
          id: 'CLG906F',
          parts: [
            PartDB(
              id: '53C0055P01',
              description: '53C0055P01 FILTER',
              price: 1356866,
              quantity: 1,
              images: '',
            ),
          ],
        ),
        ModelDB(
          id: 'CLG835H',
          parts: [
            PartDB(
              id: 'SP177033',
              description: 'ENGINE OIL FILTER ELEMENT 机油滤芯',
              price: 220700,
              quantity: 1,
              images: '',
            ),
          ],
        ),
      ],
    ),
    OrderDB(
      id: 'RT/BTCN/2024/0001',
      type: TypeGoods.ret,
      statusApproval: StatusApproval.pending,
      methodPayment: MethodPayment.cash,
      statusPayment: StatusPayment.paid,
      createdAt: DateTime.now(),
      models: [
        ModelDB(
          id: 'CLG906F',
          parts: [
            PartDB(
              id: '40C0441P01',
              description: 'ENGINE OIL FILTER ELEMENT 机油滤芯',
              price: 236600,
              quantity: 2,
              images: '',
            ),
            PartDB(
              id: '40C0440P01',
              description: '40C0440P01 fuel filter；129907-55800;ASSY',
              price: 458550,
              quantity: 1,
              images: '',
            ),
          ],
        ),
        ModelDB(
          id: 'CLG906E',
          parts: [
            PartDB(
              id: 'SP238868',
              description: 'COOLANT 20 L',
              price: 41460,
              quantity: 2,
              images: '',
            ),
          ],
        ),
      ],
    ),
    OrderDB(
      id: 'RT/BTCN/2024/0002',
      type: TypeGoods.ret,
      statusApproval: StatusApproval.rejected,
      methodPayment: MethodPayment.qris,
      statusPayment: StatusPayment.paid,
      createdAt: DateTime.now(),
      models: [
        ModelDB(
          id: 'CLG906F',
          parts: [
            PartDB(
              id: '40C9921',
              description: '40C9921 FUEL FILTER ELEMENT;ASSY',
              price: 297100,
              quantity: 1,
              images: '',
            ),
          ],
        ),
      ],
    ),
    OrderDB(
      id: 'RT/BTCN/2024/0003',
      type: TypeGoods.ret,
      statusApproval: StatusApproval.approved,
      methodPayment: MethodPayment.cash,
      statusPayment: StatusPayment.paid,
      createdAt: DateTime.now(),
      models: [
        ModelDB(
          id: 'CLG906F',
          parts: [
            PartDB(
              id: '40C9921',
              description: '40C9921 FUEL FILTER ELEMENT;ASSY',
              price: 297100,
              quantity: 1,
              images: '',
            ),
          ],
        ),
      ],
    ),
  ];

  @override
  void onInit() {
    super.onInit();

    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
    _storage = GetStorage();

    logger = Logger(
      printer: PrettyPrinter(
        dateTimeFormat: DateTimeFormat.onlyTime,
      ),
    );

    user = types.User(
      id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
      firstName: 'Andrean',
      lastName: 'Ramadhan',
      lastSeen: DateTime.now().millisecondsSinceEpoch,
      role: types.Role.admin,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTv9s-TnnmztbpvePvZEtJoMwEpy-wUVqu7ow&s',
    );
    user2 = const types.User(
      id: '82091008-a484-4a89-ae75-a22bf8d6f3ad',
      firstName: 'PT Angkasa',
      lastName: 'Pura',
      role: types.Role.user,
    );
    user3 = const types.User(
      id: '82091008-a484-4a89-ae75-a22bf8d6f3ae',
      firstName: 'PT Gudang Garam',
      role: types.Role.user,
    );
  }

  Future<void> logout() async {
    try {
      await _storage.erase();
      await _auth.signOut();
      Get.offAllNamed(Routes.LOGIN);
    } on FirebaseAuthException catch (e) {
      logger.e('Error: $e');
    }
  }

  void _clearDataProfile() {
    localStorage.erase();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
