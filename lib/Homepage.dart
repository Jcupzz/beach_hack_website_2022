import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

// enum PlayerState {
//   idleLeft,
//   idleRight,
//   swimmingLeft,
//   swimmingRight,
// }
enum MarioState {
  idleLeft,
  idleRight,
  runningLeft,
  runningRight,
  jumpLeft,
  jumpRight,
}

class Homepage extends FlameGame with KeyboardEvents {
  late TiledComponent tiledMap;
  late SpriteAnimationComponent animationComponent;
  late SpriteAnimationGroupComponent<MarioState> marioAnimationGroupComponent;
  // late SpriteAnimationGroupComponent<PlayerState> playerGroup;
  late double marioEndPosX;
  late double marioEndPosY;
  late MarioState currentStateOfMario;
  bool isRight = false;
  bool isLeft = false;

  @override
  void onGameResize(Vector2 canvasSize) {
    // TODO: implement onGameResize

    super.onGameResize(canvasSize);
    print("ttsts");

    // camera.setRelativeOffset(Anchor.topLeft);
    // camera.viewport = FixedResolutionViewport(Vector2(size.x, 1072));
    // camera.gameSize.y = 1072;
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
    print(WidgetsBinding.instance?.window.physicalSize.toString());
    print(camera.viewport.effectiveSize.x.toString() +
        " " +
        camera.viewport.effectiveSize.y.toString());

    final tiledMap = await TiledComponent.load('beach4.tmx', Vector2.all(64));

    add(tiledMap);
    currentStateOfMario = MarioState.idleRight;

    //Start and end position of mario
    final startAndEnd = tiledMap.tileMap.getObjectGroupFromLayer("events");
    double marioStartPosX = startAndEnd.objects[0].x;
    double marioStartPosY = startAndEnd.objects[0].y;
    marioEndPosX = startAndEnd.objects[1].x;
    marioEndPosY = startAndEnd.objects[1].y;

    camera.worldBounds = Rect.fromLTWH(0, 0, 2304, 896);
    // camera.snapTo(Vector2(marioStartPosX / 2, marioStartPosY / 2));
    print(marioStartPosX.toString() + " ## " + marioStartPosY.toString());

    //Mario
    final marioSpriteImage = await Flame.images.load('marioSpriteSheet.png');

    final marioSpriteSheet = SpriteSheet(
      image: marioSpriteImage,
      srcSize: Vector2(
          marioSpriteImage.width / 14, marioSpriteImage.height.toDouble()),
    );

    final runLeftSpriteAnimation = marioSpriteSheet.createAnimation(
        row: 0, stepTime: 0.15, from: 4, to: 6);
    final runRightSpriteAnimation = marioSpriteSheet.createAnimation(
        row: 0, stepTime: 0.15, from: 8, to: 10);

    final idleRightSpriteAnimation =
        marioSpriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 7, to: 8);

    final idleLeftSpriteAnimation =
        marioSpriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 6, to: 7);

    final jumpRightSpriteAnimation = marioSpriteSheet.createAnimation(
        row: 0, stepTime: 0.1, from: 12, to: 13);

    final jumpLeftSpriteAnimation =
        marioSpriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 1, to: 2);

    marioAnimationGroupComponent = SpriteAnimationGroupComponent(
      animations: {
        MarioState.runningLeft: runLeftSpriteAnimation,
        MarioState.runningRight: runRightSpriteAnimation,
        MarioState.idleLeft: idleLeftSpriteAnimation,
        MarioState.idleRight: idleRightSpriteAnimation,
        MarioState.jumpRight: jumpRightSpriteAnimation,
        MarioState.jumpLeft: jumpLeftSpriteAnimation
      },
      current: currentStateOfMario,
      position: Vector2(marioStartPosX, marioStartPosY),
      size: Vector2(27, 34.25),
    );

    add(marioAnimationGroupComponent);

    // final IdleGuyImage = await Flame.images.load('idle_guy_1.png');

    // final IdleGuySpriteSheet = SpriteSheet(
    //   image: IdleGuyImage,
    //   srcSize: Vector2(IdleGuyImage.width / 5, IdleGuyImage.height.toDouble()),
    // );

    // final IdleRightSpriteAnimation = IdleGuySpriteSheet.createAnimation(
    //     row: 0, stepTime: 0.15, from: 0, to: 6);

    // playerGroup = SpriteAnimationGroupComponent(
    //   animations: {
    //     PlayerState.idleRight: IdleRightSpriteAnimation,
    //   },
    //   current: PlayerState.idleRight,
    //   position: Vector2(size.x / 2, size.y / 2),
    //   size: Vector2(84.4, 158),
    // );

    // // add(playerGroup);
    // print("Size of world is: " + size.x.toString());

    // camera.followComponent(playerGroup);

    // camera.worldBounds = Rect.fromLTRB(0, 0, 1920, 1072);

    return super.onLoad();
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;

    isRight = keysPressed.contains(LogicalKeyboardKey.arrowRight);
    isLeft = keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    if (isKeyDown) {
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);

    if (isRight) {
      marioAnimationGroupComponent.x =
          marioAnimationGroupComponent.x + 200 * dt;
      currentStateOfMario = MarioState.runningRight;
      marioAnimationGroupComponent.current = MarioState.runningRight;
    } else {
      isRight = false;
    }

    if (isLeft) {
      marioAnimationGroupComponent.x =
          marioAnimationGroupComponent.x - 200 * dt;
      currentStateOfMario = MarioState.runningLeft;
      marioAnimationGroupComponent.current = MarioState.runningLeft;
    } else {
      isLeft = false;
    }

    camera.followVector2(Vector2(
        marioAnimationGroupComponent.x, marioAnimationGroupComponent.y));

    // camera.setRelativeOffset(Anchor.center);
    // camera.translateBy(Vector2(1, 0));
  }
}
