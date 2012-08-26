package States.Escape 
{
	import org.flixel.*;
	public class Escape extends FlxState
	{
		
		override public function create():void 
		{ 
			var x:FlxText = new FlxText(0, 0, 100, "Escape");
			add(x);
		}
		
	}

}