import 'package:beach_hack_website_2022/Player.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/particles.dart';
import 'package:flame/sprite.dart';
import 'package:flame_tiled/flame_tiled.dart';

enum PlayerState {
  idleLeft,
  idleRight,
  swimmingLeft,
  swimmingRight,
}

class Homepage extends FlameGame {
  late TiledComponent tiledMap;
  late SpriteAnimationGroupComponent<PlayerState> playerGroup;

  @override
  void onGameResize(Vector2 canvasSize) {
    // TODO: implement onGameResize
    super.onGameResize(canvasSize);

    camera.setRelativeOffset(Anchor.topLeft);
    // camera.viewport = FixedResolutionViewport(Vector2(size.x, 1072));
    camera.gameSize.y = 1072;
  }

  @override
  void onAttach() {
    // TODO: implement onAttach
    super.onAttach();
  }

  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    print(size.toString());

    final tiledMap = await TiledComponent.load('beach.tmx', Vector2.all(16));

    add(tiledMap);

    final IdleGuyImage = await Flame.images.load('idle_guy_1.png');

    final IdleGuySpriteSheet = SpriteSheet(
      image: IdleGuyImage,
      srcSize: Vector2(IdleGuyImage.width / 5, IdleGuyImage.height.toDouble()),
    );

    final IdleRightSpriteAnimation = IdleGuySpriteSheet.createAnimation(
        row: 0, stepTime: 0.15, from: 0, to: 6);

    playerGroup = SpriteAnimationGroupComponent(
      animations: {
        PlayerState.idleRight: IdleRightSpriteAnimation,
      },
      current: PlayerState.idleRight,
      position: Vector2(200, 200),
      size: Vector2(84.4, 158),
    );

    add(playerGroup);

    camera.followComponent(playerGroup);

    return super.onLoad();
  }
}
