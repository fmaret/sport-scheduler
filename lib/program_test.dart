import 'package:sport_scheduler/program.dart';
import 'package:sport_scheduler/task.dart';

Program programTest = Program(
    {
      DateTime.now(): Task("5 abdos", "Faites 5 abdos"),
      DateTime.now().add(const Duration(seconds:10)): Task("10 abdos", "Faites 10 abdos"),
    }
);