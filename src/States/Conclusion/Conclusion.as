package States.Conclusion 
{
	import org.flixel.*;
	public class Conclusion extends FlxState
	{
		
		override public function create():void 
		{ 
			var x = new FlxText(0, 0, 100, "Conclusion");
			add(x);
		}
		
	}

}