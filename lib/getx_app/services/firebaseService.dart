import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutfire/getx_app/constants/dbCollections.dart';
import 'package:flutfire/getx_app/models/dbUser.dart';

class FirebaseService {
  static FirebaseFirestore _db = FirebaseFirestore.instance;

  // Reference to users collection
  static final usersColsRefs = _db
      .collection(USERSCOLLECTION)
      .withConverter<DbUser>(
          fromFirestore: (doc, _) => DbUser.fromMap(doc.data()!),
          toFirestore: (user, _) => user.toMap());

  // All functionality related to users

  /// Create Dbuser by Dbuser
  /// If the user is new then it is created in database
  /// If it already exists then
  static Future<void> createDbUserById(DbUser dbuser) async {
    var userIfExist =
        await usersColsRefs.where("username", isEqualTo: dbuser.username).get();
    if (userIfExist.docs.isEmpty) {
      print("Creating a new user in db");
      await usersColsRefs.doc(dbuser.username).set(dbuser);
    } else
      print("User already exists");
  }

  /// Get stream of db user by id
  static Stream<DbUser?> streamDbUserById(String id) {
    final refUser = usersColsRefs.doc(id).snapshots();

    return refUser.map((doc) {
      return doc.data()!;
    });
  }

  /// Get db user by id
  static Future<DbUser> getDbUserById(String id) async {
    DocumentSnapshot<DbUser> userSnap = await usersColsRefs.doc(id).get();
    return userSnap.data()!;
  }

  
}