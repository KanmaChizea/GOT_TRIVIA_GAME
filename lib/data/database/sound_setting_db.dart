import 'package:hive/hive.dart';
part 'sound_setting_db.g.dart';

@HiveType(typeId: 0)
class Audio {
  @HiveField(0)
  bool music = true;
  @HiveField(1)
  bool sound = true;
}
