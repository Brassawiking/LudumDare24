package States.Run 
{
	import org.flixel.*;
	public class Run extends FlxState
	{
		
		override public function create():void 
		{ 
			var x = new FlxText(0, 0, 100, "Run");
			add(x);
		}
		
	}

}