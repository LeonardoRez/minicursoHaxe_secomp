package;

import flixel.FlxSprite;

class Wall extends FlxSprite{
	
	public function new(X:Float, Y:Float):Void{
		super(X,Y);
		loadGraphic("assets/images/wall_0.png", false, 32, 32);
		immovable = true;
	}
}