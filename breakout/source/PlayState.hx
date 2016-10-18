package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.group.FlxGroup;

class PlayState extends FlxState
{
	var player: FlxSprite;
	var ball: FlxSprite;
	var blocos: FlxGroup;
	override public function create():Void
	{
		super.create();
		player = new FlxSprite();
		player.makeGraphic(60,10,FlxColor.BLUE); //dimensoes
		player.x = (FlxG.width/2) - (player.width/2);
		player.y = (FlxG.height) - (player.height);
		add(player);
		player.immovable = true;

		//bola		
		ball = new FlxSprite(0,0);
		ball.makeGraphic(8,8,FlxColor.RED);
		ball.x = (FlxG.width/2)- (ball.width/2);
		ball.y = FlxG.height/2;
		add(ball);
		ball.velocity.y = 200;

		//blocos
		blocos = new FlxGroup();
		add(blocos);

		for(i in 0...10){
			for(j in 0...3){
				var b = new FlxSprite(i* (60 +15), j * (10 +10));
				b.makeGraphic(60,10,FlxColor.WHITE);
				blocos.add(b);
			}
		}
	}

	override public function update(elapsed:Float):Void
	{
		//colisao player com bola
		FlxG.collide(player,ball,function(p:FlxSprite, b:FlxSprite):Void{
			var dx:Float = ball.getMidpoint().x - player.getMidpoint().x;
			var dy:Float = ball.getMidpoint().y - player.getMidpoint().y;
			var h:Float = Math.sqrt(dx*dx + dy*dy);
			b.velocity.set(200* (dx/h), 200* (dy/h));

			//b.velocity.y = -1 * 200;


		});

		//colisao bola com bloco
		FlxG.collide(ball,blocos,function(b:FlxSprite, blo:FlxSprite):Void{
			b.velocity.y = 200;
			blo.kill();


		});
		if(ball.x <=0 || ball.x >=FlxG.width){
			ball.velocity.x *= -1;
		}

		if(ball.y <=0){
			ball.velocity.y *= -1;
		}

		if(FlxG.keys.anyPressed(["LEFT", "A"])){
			//player.velociry.set(100,0); //duas formas de fazer
			player.x += -100 * elapsed;

		}else if(FlxG.keys.anyPressed(["RIGHT", "D"])){
			player.x += 100*elapsed;
		}
		super.update(elapsed);
	}
}
