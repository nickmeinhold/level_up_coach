import 'package:flutter/material.dart';
import 'package:level_up_coach/utils/locator.dart';
import 'package:level_up_coach/workouts/services/workouts_service.dart';
import 'package:level_up_shared/level_up_shared.dart';

class WorkoutDetailScreen extends StatelessWidget {
  final Workout workout;

  const WorkoutDetailScreen({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(workout.description)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(workout.description),
            ),
            Text(
              'Exercises (${workout.exerciseIds.length})',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: FutureBuilder<List<Exercise>>(
                future: locate<WorkoutsService>().retrieveExercises(workout.id),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  List<Exercise> exercises = snapshot.data!;
                  return ListView.builder(
                    itemCount: workout.exerciseIds.length,
                    itemBuilder: (context, index) {
                      Exercise exercise = exercises[index];
                      return switch (exercise) {
                        TimedExercise() => TimedExerciseWidget(
                          exercise: exercise,
                        ),
                        RepsExerciseWithWeights() =>
                          RepsExerciseWithWeightWidget(exercise: exercise),
                        RepsExercise() => RepsExerciseWidget(
                          exercise: exercise,
                        ),
                      };
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimedExerciseWidget extends StatelessWidget {
  const TimedExerciseWidget({super.key, required this.exercise});

  final TimedExercise exercise;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exercise.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text('Sets: ${exercise.sets}'),
            Text('Time: ${exercise.time}'),
          ],
        ),
      ),
    );
  }
}

class RepsExerciseWidget extends StatelessWidget {
  const RepsExerciseWidget({super.key, required this.exercise});

  final RepsExercise exercise;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exercise.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text('Sets: ${exercise.sets}'),
            Text('Reps: ${exercise.reps}'),
          ],
        ),
      ),
    );
  }
}

class RepsExerciseWithWeightWidget extends StatelessWidget {
  const RepsExerciseWithWeightWidget({super.key, required this.exercise});

  final RepsExerciseWithWeights exercise;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exercise.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text('Sets: ${exercise.sets}'),
            Text('Reps: ${exercise.reps}'),
            Text('Weight: ${exercise.weight} kg'),
          ],
        ),
      ),
    );
  }
}
