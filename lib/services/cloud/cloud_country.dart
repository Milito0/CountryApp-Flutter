import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_app/services/cloud/cloud_constant.dart';

class CloudCountry {
  final String documentId;
  final String ownerId;
  final String cioc;

  const CloudCountry({
    required this.documentId,
    required this.ownerId,
    required this.cioc,
  });

  CloudCountry.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerId = snapshot.data()[userID],
        cioc = snapshot.data()[ciocX] as String;
}
