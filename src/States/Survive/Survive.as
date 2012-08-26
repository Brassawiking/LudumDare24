package States.Survive 
{
	import org.flixel.*;
	public class Survive extends FlxState
	{
		
		override public function create():void 
		{ 
			var x = new FlxText(0, 0, 100, "Survive");
			add(x);
		}
		
	}

}