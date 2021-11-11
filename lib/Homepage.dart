import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Homepage extends FlameGame {
  late TiledComponent tiledMap;

  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad

    final tiledMap = await TiledComponent.load('beach.tmx', Vector2.all(16));
    add(tiledMap);
    return super.onLoad();
  }
}
