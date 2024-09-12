import flixel.addons.display.FlxBackdrop;

var osaker:FlxBackdrop = new FlxBackdrop();
var osak:FlxSprite = new FlxSprite();

var zoomAmt = 0;
var bop:Bool = false;

function postCreate() {
    window.title = "Timeless Daydream (by sopas) Friday night funkij modification for the Nintendo switch (by sopas) I did code and chart (by sopas) for the Nintendo switch (by care) Tl;dr: Osakar";
    camGame.addShader(carp = new CustomShader("fisheye"));
    carp.MAX_POWER = 0.15;

    healthBar.createFilledBar(0xffd58390, 0xffd58390);
    healthBar.percent = health;

    for(a in 0...2)
        [iconP2, iconP1][a].setIcon("osaka" + (a + 1));
    iconP1.flipX = camZooming = true;

    for(a in [osaker, osak]){
		a.frames = Paths.getSparrowAtlas("stages/osaker");
		insert(0, a);
	}
    osak.animation.addByPrefix("idle", "idle0", 24, true);
    osak.animation.play("idle", true);
    osaker.velocity.y = 120;

    camGame.fade(FlxColor.BLACK, 0);
}

function postUpdate() {
    for(a in 0...2)
        [iconP2, iconP1][a].x += (a * 52) - 75/2;

    defaultCamZoom = zoomAmt + (strumLines.members[0].characters[0].getAnimName() == "idle" ? 0.95 : 1);

    camFollow.x = strumLines.members[0].characters[0].getMidpoint().x;
    camFollow.y = strumLines.members[0].characters[0].getMidpoint().y;
}

function update() {
    osaker.animation.addByPrefix("b", osak.animation.frameName, 24, true);
    osaker.animation.play("b", true);
    osaker.x += Math.sin(Conductor.songPosition / 1000);
}

function stepHit(curStep:Int) {
    switch(curStep) {
        case 0:
            camGame.fade(FlxColor.BLACK, (Conductor.stepCrochet / 1000) * 248, true);
        case 248:
            FlxTween.tween(strumLines.members[0].members[1], {alpha: 1}, (Conductor.stepCrochet / 1000) * 8, {onComplete:
                function(twn) FlxTween.tween(strumLines.members[0].members[3], {alpha: 1}, (Conductor.stepCrochet / 1000) * 8, {onComplete:
                    function(twn) FlxTween.tween(strumLines.members[0].members[2], {alpha: 1}, (Conductor.stepCrochet / 1000) * 8, {onComplete:
                        function(twn) FlxTween.tween(strumLines.members[0].members[0], {alpha: 1}, (Conductor.stepCrochet / 1000) * 8)
                    })
                })
            }); 
        case 512:
            camZoomingInterval = 1;
            iconP1.visible = iconP2.visible = healthBar.visible = healthBarBG.visible = bop = true;
        case 1024:
            bop = false;
            camZoomingInterval = 16;
            FlxTween.tween(camHUD, {alpha: 0}, (Conductor.stepCrochet / 1000) * (1296 - 1024));
            FlxTween.num(0, -0.5, (Conductor.stepCrochet / 1000) * (1296 - 1024), {}, function(num) zoomAmt = num);
        case 1296 | 1297 | 1299 | 1300 | 1302 | 1303:
            camGame.zoom += 0.05;
        case 1304:
            bop = true;
            zoomAmt = 0;
            camHUD.alpha = camZoomingInterval = 1;
        case 1816:
            FlxTween.tween(camHUD, {alpha: 0}, (Conductor.stepCrochet / 1000) * 16);
        case 1822:
            FlxTween.tween(strumLines.members[0].characters[0], {alpha: 0}, (Conductor.stepCrochet / 1000) * ((2155 - 1822) / 1.5));
            camGame.fade(FlxColor.BLACK, (Conductor.stepCrochet / 1000) * (2155 - 1822));
    }
}

function beatHit(curBeat:Int){
	if(bop){
		for(a in [iconP2, iconP1]){
			a.angle = curBeat % 2 == 0 ? 5 : -5;
			FlxTween.cancelTweensOf(a);
			FlxTween.tween(a, {angle: 0}, 0.5, {ease: FlxEase.circOut});
		}
		for(a in strumLines.members[0]){
			a.angle = curBeat % 2 == 0 ? (a.strumID % 2 == 0 ? 5 : -5) : (a.strumID % 2 == 0 ? -5 : 5);
			FlxTween.cancelTweensOf(a);
			FlxTween.tween(a, {angle: 0}, 0.5, {ease: FlxEase.circOut});
		}
	}
}