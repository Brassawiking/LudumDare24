package {
	import org.flixel.*;
	import States.Start.Start;
	import States.Run.Run;
	import States.Survive.Survive;
	[SWF(width = "960", height = "540", backgroundColor = "#000000")]
	[Frame(factoryClass="Preloader")]	
	
	public class Main extends FlxGame
	{
		public function Main()
		{
			super(960,540,Start,1);
		}
	}
}