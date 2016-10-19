package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.group.FlxGroup;


class Inter{
	
	public var min:Int;
	public var max:Int;

	public function new(m:Int, mx:Int){
		min = m;
		max = mx;
	}
}

class PlayState extends FlxState
{
	var player:Player;
	var w:Int = 32;
	var h:Int = 32;
	var dia:Int = 0;

	var paredes:FlxGroup;

	var saida:FlxSprite;

	var InterInimigos:Inter = new Inter(5,10);
	var InterParedes:Inter = new Inter(5,15);

	override public function create():Void
	{
		super.create();
		player = new Player();
		paredes = new FlxGroup();
		saida = new FlxSprite(FlxG.width -w, FlxG.height -h);
		saida.loadGraphic("assets/images/exit.png");
		saida.immovable = true;

		var wi:Int = Std.int(FlxG.width/w);
		var hi:Int = Std.int(FlxG.height/h);

		for(i in 0...wi){
			for(j in 0...hi){
				var back = new FlxSprite(i * w, j * h);
				var ind:Int = Std.random(5);
				back.loadGraphic("assets/images/back_"+ind+".png", false, 32, 32);
				add(back);
			}
		}
		add(saida);
		add(paredes);
		add(player);
		setupDia();
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.collide(player, paredes);
		FlxG.collide(player, saida, function(p:Player, s:FlxSprite):Void{
			setupDia();
		});
		super.update(elapsed);
	}

	public function setupDia():Void{
		dia +=1;

		player.x =0;
		player.y = 0;

		paredes.forEach(function(p):Void{
			paredes.remove(p);
		});

		var wi:Int = Std.int(FlxG.width/w);
		var hi:Int = Std.int(FlxG.height/h);

		var pontosP:Array<FlxPoint> = new Array<FlxPoint>();
		for(i in 1...wi-1){
			for(j in 1...hi-1){
				pontosP.push(new FlxPoint(i*w, j*h));
			}
		}

		//paredes
		var qt:Int = FlxG.random.int(InterParedes.min, InterParedes.max);
		while(qt>0){
			qt -= 1;
			var index:Int = FlxG.random.int(0,pontosP.length-1);
			var pos = pontosP[index];
			paredes.add(new Wall(pos.x, pos.y));
			pontosP.remove(pos);
		}
		
	}

}
