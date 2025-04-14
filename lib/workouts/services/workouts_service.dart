import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:level_up_shared/level_up_shared.dart';

class WorkoutsService {
  WorkoutsService({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  Future<List<Exercise>> retrieveExercises(String workoutId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firestore
            .collection('workouts')
            .doc(workoutId)
            .collection('exercises')
            .get();

    List<Exercise> exercises = [];
    for (final docSnapshot in querySnapshot.docs) {
      exercises.add(
        Exercise.fromJsonWithId(docSnapshot.id, docSnapshot.data()),
      );
    }

    return exercises;
  }

  Stream<List<Exercise>> streamOfExercises(String workoutId) {
    Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshotStream =
        _firestore
            .collection('workouts')
            .doc(workoutId)
            .collection('exercises')
            .snapshots();

    return querySnapshotStream.map<List<Exercise>>((querySnapshot) {
      return querySnapshot.docs.map<Exercise>((docSnapshot) {
        return Exercise.fromJsonWithId(docSnapshot.id, docSnapshot.data());
      }).toList();
    });
  }

  Stream<List<Workout>> streamOfWorkouts() {
    Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshotStream =
        _firestore
            .collection('workouts')
            .orderBy('createdAt', descending: true)
            .snapshots();

    return querySnapshotStream.map<List<Workout>>((querySnapshot) {
      return querySnapshot.docs.map((docSnapshot) {
        return Workout.fromJsonWthId(docSnapshot.id, docSnapshot.data());
      }).toList();
    });
  }

  Future<void> createWorkout(Workout workout) {
    return _firestore.collection('workouts').add(workout.toJson());
  }

  Future<void> createExercise(Exercise exercise, String workoutId) async {
    final docRef = await _firestore
        .collection('exercises')
        .add(exercise.toJson());

    return _firestore.collection('workouts').doc(workoutId).set({
      'exerciseIds': FieldValue.arrayUnion([docRef.id]),
    });
  }
}
