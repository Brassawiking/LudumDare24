package States.Conclusion 
{
	import org.flixel.*;
	import Resources.*;
	public class Conclusion extends FlxState
	{
		private var _title:FlxSprite;
		private var _sabina:FlxSprite;
		private var _mainGroup:FlxGroup;
		
		private var _currentAction:Function;
		
		private var _startTitleFade:Boolean = false;
		
		override public function create():void 
		{ 
			var _mainGroup:FlxGroup = new FlxGroup();
			
			_mainGroup.add(new FlxSprite(0, 0, Images.Prelude_bg));
			
			_sabina = new FlxSprite(0, 0, Images.Prelude_Sabina_1);
			_mainGroup.add(_sabina);
			
			_title = new FlxSprite(0, 0, Images.Conclusion_title);			
			_title.alpha = 0;
			
			add(_mainGroup);
			add(_title);
			add(new FlxSprite(0, 0, Images.Letterbox));

			FlxG.flash(0xff000000, 1, fadeInComplete);
		}
		
		private var reverseTitleFade:Boolean = false;
		override public function update():void
		{
			if (_startTitleFade)
			{
				if ( (_title.alpha > 0.9) ) {
					reverseTitleFade = true;
				}
				if (reverseTitleFade) {
					_title.alpha -= 0.01;
				}
				else 
				{
					_title.alpha += (1.0 - _title.alpha) * 0.01;					
				}
				

			}
			if (_currentAction != null) {
				_currentAction();
			}

		}
		
		private function fadeInComplete():void
		{
			//_currentAction = RaiseSign;
			_startTitleFade = true;
		}

		
	}

}