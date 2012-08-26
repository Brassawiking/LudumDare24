package States.Help 
{
	import org.flixel.*;
	import Resources.*;
	import States.Prelude.Prelude;
	public class Help extends FlxState
	{
		private var _isActive:Boolean; 
		
		override public function create():void 
		{ 
			add(new FlxSprite(0, 0, Images.HelpScreen));
			
			_isActive = true;
			FlxG.flash(0xff000000, 1, fadeInComplete);
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
			FlxG.switchState(new Prelude);
		}
		
	}

}