import funkin.backend.system.framerate.Framerate;
import funkin.backend.utils.ShaderResizeFix;
import openfl.system.Capabilities;

function new(){
	Framerate.codenameBuildField.visible = FlxG.stage.window.resizable = false;
	windowShit(1024, 768);
}

function postStateSwitch(){
	windowShit(1024, 768);
	if(Framerate.codenameBuildField.visible == true) Framerate.codenameBuildField.visible = false;
}

function destroy()
	windowShit(1280, 720);

var winWidth = Math.floor(Capabilities.screenResolutionX * (3 / 4)) > Capabilities.screenResolutionY ? Math.floor(Capabilities.screenResolutionY * (4 / 3)) : Capabilitities.screenResolutionX;
var winHeight = Math.floor(Capabilities.screenResolutionX * (3 / 4)) > Capabilities.screenResolutionY ? Capabilities.screenResolutionY : Math.floor(Capabilities.screenResolutionX * (3 / 4));

public static function windowShit(newWidth:Int, newHeight:Int){
 	if(newWidth == 1024 && newHeight == 768)
		FlxG.resizeWindow(winWidth * 0.9, winHeight * 0.9);
	else
		FlxG.resizeWindow(newWidth, newHeight);
	FlxG.resizeGame(newWidth, newHeight);
	FlxG.scaleMode.width = FlxG.width = FlxG.initialWidth = newWidth;
	FlxG.scaleMode.height = FlxG.height = FlxG.initialHeight = newHeight;
	ShaderResizeFix.doResizeFix = true;
	ShaderResizeFix.fixSpritesShadersSizes();
	window.x = Capabilities.screenResolutionX/2 - window.width/2;
	window.y = Capabilities.screenResolutionY/2 - window.height/2;
}