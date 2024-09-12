import openfl.utils.Assets;
import flixel.util.FlxGradient;

//PauseSubState.script = 'data/scripts/pause';
GameOverSubstate.script = 'data/scripts/die';

var songTitle = new FlxSprite(10, 10);
var gradient = new FlxGradient().createGradientFlxSprite(1024, 768/6.75, [dad.iconColor, FlxColor.TRANSPARENT], 1, 0, true);

public var camTXT = new HudCamera();

function postCreate(){
    FlxG.cameras.add(camTXT, false);
    camTXT.bgColor = camHUD.bgColor;
    timerTxt = new FunkinText(5, 0, Std.int(healthBarBG.width - 100), "Time:0:00/" + Std.int(Std.int((inst.length) / 1000) / 60) + ":" + CoolUtil.addZeros(Std.string(Std.int((inst.length) / 1000) % 60), 2), 16);
    for(num => a in [iconP1, iconP2, healthBar, healthBarBG, accuracyTxt, timerTxt, scoreTxt, missesTxt]){
        a.y += 20;
        a.antialiasing = true;
        if(Std.isOfType(a, FlxText)) {
            a.alignment = "left";
            a.size *= 1.5;
            a.setPosition(5, FlxG.height - (a.height * (num-3)) - 5);
            a.camera = camTXT;
        } else {
            if(!camHUD.downscroll) a.x += FlxG.width/7.5;
            a.visible = false;
        }
    }
    add(timerTxt);

    songTitle = new FlxSprite(10, 10);
    songTitle.frames = Paths.getSparrowAtlas("songTitles/" + SONG.meta.name.toLowerCase());
    songTitle.animation.addByPrefix("loop", "loop", 24, true);
    songTitle.animation.play("loop");
    for(a in [gradient, songTitle]){
        add(a);
        a.antialiasing = true;
        a.camera = camTXT;
    }
}

function onStrumCreation(e){
    e.cancelAnimation();
    e.strum.y = 25;
    e.strum.alpha = 0;
}

function postUpdate(elapsed) {
    if(Conductor.songPosition >= 0)
        timerTxt.text = "Time:" + Std.int(Std.int((Conductor.songPosition) / 1000) / 60) + ":" + CoolUtil.addZeros(Std.string(Std.int((Conductor.songPosition) / 1000) % 60), 2) + "/" + Std.int(Std.int((inst.length) / 1000) / 60) + ":" + CoolUtil.addZeros(Std.string(Std.int((inst.length) / 1000) % 60), 2);
}

function stepHit(curStep:Int) {
    if(curStep == 32){
        FlxTween.tween(songTitle, {x: -songTitle.width - songTitle.x}, (Conductor.stepCrochet / 1000) * 32, {onComplete: function(twn) remove(songTitle.destroy()), ease: FlxEase.circInOut});
        FlxTween.tween(gradient, {alpha: 0}, (Conductor.stepCrochet / 1000) * 32, {onComplete: function(twn) remove(gradient.destroy()), ease: FlxEase.circInOut});
    }
}