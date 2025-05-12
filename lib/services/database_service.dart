import 'package:my_productive_rewards/models/models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  late Database _database;
  Database get database => _database;

  Future<void> createDatabase() async {
    final databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, 'productivity.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, description TEXT, points INTEGER)',
        );
        await db.execute(
          'CREATE TABLE TaskLog (id INTEGER PRIMARY KEY, task TEXT, points INTEGER, date TEXT)',
        );
        await db.execute(
          'CREATE TABLE Rewards (id INTEGER PRIMARY KEY, description TEXT, value INTEGER, link TEXT)',
        );
      },
    );
  }

  // TASKS //
  Future<void> addTask(Task task) async {
    await database.transaction((txn) async {
      await txn.rawInsert(
        'INSERT INTO Tasks (description, points) VALUES("${task.description}", "${task.points}")',
      );
    });
  }

  Future<void> updateTask(Task task) async {
    await database.transaction((txn) async {
      await txn.rawUpdate(
        'UPDATE Tasks SET description = ?, points = ? WHERE id = ?',
        [
          task.description,
          task.points,
          '${task.taskId}',
        ],
      );
    });
  }

  Future<List<Task>> getTasks() async {
    final List<Map> tasks = await database.rawQuery('SELECT * FROM Tasks');
    final List<Task> results = [];
    for (final task in tasks) {
      results.add(
        Task(
          taskId: task['id'] as int,
          description: task['description'] as String,
          points: task['points'] as int,
        ),
      );
    }
    return results;
  }

  Future<void> deleteTask(int key) async {
    await database.rawDelete('DELETE FROM Tasks WHERE id = ?', [key]);
  }

  Future<void> deleteAllTasks() async {
    await database.rawDelete('DELETE FROM Tasks');
  }

  // TASK LOG //
  Future<void> addCompletedTask(CompletedTask task) async {
    await database.transaction((txn) async {
      await txn.rawInsert(
        'INSERT INTO TaskLog (task, points, date) VALUES("${task.description}", "${task.points}", "${task.date}")',
      );
    });
  }

  Future<List<CompletedTask>?> getCompletedTasks() async {
    try {
      final List<Map> tasks = await database.rawQuery('SELECT * FROM TaskLog');
      final List<CompletedTask> results = [];
      for (final task in tasks) {
        results.add(
          CompletedTask(
            taskId: task['id'] as int,
            description: task['task'] as String,
            points: task['points'] as int,
            date: task['date'] as String,
          ),
        );
      }
      return results;
    } catch (_) {
      return null;
    }
  }

  Future<void> deleteAllCompletedTasks() async {
    await database.rawDelete('DELETE FROM TaskLog');
  }

  // REWARDS //
  Future<void> addReward(Reward reward) async {
    await database.transaction((txn) async {
      await txn.rawInsert(
        'INSERT INTO Rewards (description, value, link, isGoal) VALUES("${reward.description}", "${reward.value}", "${reward.link}", "${reward.isGoal}")',
      );
    });
  }

  Future<void> updateReward(Reward reward) async {
    await database.transaction((txn) async {
      await txn.rawUpdate(
        'UPDATE Rewards SET description = ?, value = ?, link = ?, isGoal = ? WHERE id = ?',
        [
          reward.description,
          reward.value,
          reward.link,
          reward.isGoal,
          '${reward.rewardId}',
        ],
      );
    });
  }

  Future<List<Reward>?> getRewards() async {
    try {
      final List<Map> rewards =
          await database.rawQuery('SELECT * FROM Rewards');
      final List<Reward> results = [];
      for (final reward in rewards) {
        results.add(
          Reward(
            rewardId: reward['id'] as int,
            description: reward['description'] as String,
            value: reward['value'] as int,
            link: reward['link'] as String,
            isGoal: reward['isGoal'] as int,
          ),
        );
      }
      return results;
    } catch (_) {
      return null;
    }
  }

  Future<void> deleteReward(int key) async {
    await database.rawDelete('DELETE FROM Rewards WHERE id = ?', [key]);
  }

  Future<void> deleteAllRewards() async {
    await database.rawDelete('DELETE FROM Rewards');
  }

  // PURCHASED REWARDS //
  Future<void> addPurchasedReward(PurchasedReward reward) async {
    await database.transaction((txn) async {
      await txn.rawInsert(
        'INSERT INTO PurchasedRewards (description, value, link, date) VALUES("${reward.description}", "${reward.value}", "${reward.link}", "${reward.date}")',
      );
    });
  }

  Future<List<PurchasedReward>?> getPurchasedRewards() async {
    try {
      final List<Map> rewards =
          await database.rawQuery('SELECT * FROM PurchasedRewards');
      final List<PurchasedReward> results = [];
      for (final reward in rewards) {
        results.add(
          PurchasedReward(
            rewardId: reward['id'] as int,
            description: reward['description'] as String,
            value: reward['value'] as int,
            link: reward['link'] as String,
            date: reward['date'] as String,
          ),
        );
      }
      return results;
    } catch (_) {
      return null;
    }
  }

  Future<void> deleteAllPurchasedRewards() async {
    await database.rawDelete('DELETE FROM PurchasedRewards');
  }
}
