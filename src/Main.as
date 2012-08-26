package {
	import org.flixel.*;
	import States.Start.Start;
	import States.Run.Run;
	import States.Survive.Survive;
	import States.Escape.Escape;
	import States.Conclusion.Conclusion;
	[SWF(width = "960", height = "540", backgroundColor = "#000000")]
	[Frame(factoryClass="Preloader")]	
	
	public class Main extends FlxGame
	{
		public function Main()
		{
			super(960,540,Survive,1);
		}
	}
}