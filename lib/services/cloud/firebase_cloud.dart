import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_app/services/cloud/cloud_constant.dart';
import 'package:country_app/services/cloud/cloud_country.dart';

class FirebaseCloudStorage {
  final countries = FirebaseFirestore.instance.collection('countries');

  Stream<Iterable<CloudCountry>> allCountries({required String ownerId}) =>
      countries.snapshots().map((event) => event.docs
          .map((e) => CloudCountry.fromSnapshot(e))
          .where((element) => element.ownerId == ownerId));

  Future<void> removeFav({required String documentId}) async {
    try {
      await countries.doc(documentId).delete();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Iterable<CloudCountry>> getFavCountries(
      {required String ownerId}) async {
    try {
      return await countries.where(userID, isEqualTo: ownerId).get().then(
            (value) => value.docs.map((doc) => CloudCountry.fromSnapshot(doc)),
          );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<CloudCountry> newFavCountry(
      {required String ownerId, required String cioc}) async {
    final document = await countries.add({
      userID: ownerId,
      ciocX: cioc,
    });

    final fetchedCountry = await document.get();
    return CloudCountry(
      documentId: fetchedCountry.id,
      ownerId: ownerId,
      cioc: cioc,
    );
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._shareInstace();
  FirebaseCloudStorage._shareInstace();
  factory FirebaseCloudStorage() => _shared;
}
