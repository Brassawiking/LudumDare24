package States.Credits 
{
	import org.flixel.*;
	import Resources.*;
	import States.Start.Start;
	public class Credits extends FlxState
	{
		private var _isActive:Boolean; 
		private var _stillHolding:Boolean;
		override public function create():void 
		{ 
			add(new FlxSprite(0, 0, Images.Credits_credits));
			
			_stillHolding = FlxG.keys.any();
			_isActive = true;
			FlxG.flash(0xff000000, 1, fadeInComplete);
		}
		
		override public function update():void
		{
			if (_isActive && FlxG.keys.any() && !_stillHolding)
			{
				_isActive = false;
				FlxG.fade(0xff000000, 1, fadeOutComplete);
			} else {
				_stillHolding = false;
			}
		}
		
		private function fadeInComplete():void
		{
			_isActive = true;
		}
		
		private function fadeOutComplete():void
		{
			FlxG.switchState(new States.Start.Start);
		}
		
	}

}