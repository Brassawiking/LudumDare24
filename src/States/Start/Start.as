package States.Start 
{
	import org.flixel.*;
	import Resources.*;
	import States.Help.Help;
	public class Start extends FlxState
	{
		private var _isActive:Boolean; 
		
		override public function create():void 
		{ 
			add(new FlxSprite(0, 0, Images.StartScreen));
			
			_isActive = true;
			FlxG.flash(0xff000000, 1, fadeInComplete);
			FlxG.playMusic(Music.intro);
		}
		
		override public function update():void
		{
			if (_isActive && FlxG.keys.any())
			{
				_isActive = false;
				FlxG.fade(0xff000000, 1, fadeOutComplete);
			}				
		}
		
		private function fadeInComplete():void
		{
			_isActive = true;
		}
		
		private function fadeOutComplete():void
		{
				FlxG.switchState(new Help);
		}		
	}

}