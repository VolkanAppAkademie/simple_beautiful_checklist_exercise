import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';

class SharedPreferencesRepository implements DatabaseRepository {
  static const String _key = 'items';

  @override
  Future<int> get itemCount async {
    final prefs = await SharedPreferences.getInstance();
    final items = prefs.getStringList(_key);
    return items?.length ?? 0;
  }

  @override
  Future<List<String>> getItems() async {
    final prefs = await SharedPreferences.getInstance();
    final items = prefs.getStringList(_key);
    return items ?? [];
  }

  @override
  Future<void> addItem(String item) async {
    final prefs = await SharedPreferences.getInstance();
    final items = prefs.getStringList(_key) ?? [];
    items.add(item);
    await prefs.setStringList(_key, items);
  }

  @override
  Future<void> deleteItem(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final items = prefs.getStringList(_key) ?? [];
    if (index >= 0 && index < items.length) {
      items.removeAt(index);
      await prefs.setStringList(_key, items);
    }
  }

  @override
  Future<void> editItem(int index, String newItem) async {
    final prefs = await SharedPreferences.getInstance();
    final items = prefs.getStringList(_key) ?? [];
    if (index >= 0 && index < items.length) {
      items[index] = newItem;
      await prefs.setStringList(_key, items);
    }
  }
}
