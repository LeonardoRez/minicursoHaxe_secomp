package;

//documentação: haxeflixel.com



import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxObject;

class Player extends FlxSprite{
	var tween:FlxTween;
	public function new():Void{

		super(0,0);
		loadGraphic("assets/images/player.png", true, 32, 32); //o true é para "é animado?"
		setFacingFlip(FlxObject.RIGHT, false, false); // lado, x, y
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.UP, false, true);
		setFacingFlip(FlxObject.DOWN, false, false);
		animation.add("parado", [0,1,2,3,4,5], 6, true); //6 quadros por segundo e " (true) em loop"
		animation.add("atacar", [8,9], 10, false);
		animation.add("morrer", [6,7], 6, false);
		animation.play("parado");
	}
	override public function update(elapsed:Float):Void{

		if(FlxG.keys.anyJustReleased(["LEFT", "A"])){
			FlxTween.tween(this, {x: this.x - 32}, 0.005);
			facing = FlxObject.LEFT;

		}else if(FlxG.keys.anyJustReleased(["RIGHT", "D"])){
			FlxTween.tween(this, {x: this.x + 32}, 0.005);
			facing = FlxObject.RIGHT;

		}else if(FlxG.keys.anyPressed(["SPACE"])){
			animation.play("atacar");
		}else if(FlxG.keys.anyJustReleased(["UP", "W"])){
			if(this.y <= 0){
				facing = FlxObject.UP;
			}else
			FlxTween.tween(this, {y: this.y - 32}, 0.005);
		}else if(FlxG.keys.anyJustReleased(["DOWN", "S"])){
			FlxTween.tween(this, {y: this.y + 32}, 0.005);
			facing = FlxObject.DOWN;
		}
		if(animation.finished){
			animation.play("parado");
		}

		super.update(elapsed);

	}


}