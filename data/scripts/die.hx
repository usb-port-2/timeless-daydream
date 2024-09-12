import hxvlc.flixel.FlxVideoSprite;

function create(e) {
    e.cancel();

    camera = dieCam = new FlxCamera();
    dieCam.bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.add(dieCam, false);


    add(vid = new FlxVideoSprite());
    vid.load(Assets.getPath(Paths.file('videos/die.webm')));
    vid.bitmap.onEndReached.add(function() FlxG.switchState(new PlayState()));
    vid.play();
    vid.x += 270;
    //vid.y += 250;
}