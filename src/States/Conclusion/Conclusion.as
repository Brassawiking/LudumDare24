package States.Conclusion 
{
	import org.flixel.*;
	import Resources.*;
	import States.Start.Start;
	public class Conclusion extends FlxState
	{
		private var _title:FlxSprite;
		private var _helicopters:FlxSprite;
		private var _sabina:FlxSprite;
		private var _speech:FlxSprite;
		private var _mainGroup:FlxGroup;
		
		private var _currentAction:Function;
		
		private var _startTitleFade:Boolean = false;
		
		override public function create():void 
		{ 
			var _mainGroup:FlxGroup = new FlxGroup();
			
			_mainGroup.add(new FlxSprite(0, 0, Images.Conclusion_bg));
			
			_helicopters = new FlxSprite(0, 0 , Images.Conclusion_helicopters);
			_speech = new FlxSprite(0, 0, Images.Conclusion_Speech_1);
			_speech.visible = false;
			_sabina = new FlxSprite(0, 0, Images.Conclusion_Sabina_1);
			
			_mainGroup.add(_helicopters);
			_mainGroup.add(_speech);
			_mainGroup.add(_sabina);
			
			_title = new FlxSprite(0, 0, Images.Conclusion_title);			
			_title.alpha = 0;
			
			add(_mainGroup);
			add(_title);
			add(new FlxSprite(0, 0, Images.Letterbox));

			FlxG.flash(0xff000000, 1, fadeInComplete);
		}
		
		private var reverseTitleFade:Boolean = false;
		private var frameCounter:int = 0;
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
			
			frameCounter++;
			_helicopters.y = -3 + Math.sin(frameCounter / 30) * 5;

		}
		
		private function fadeInComplete():void
		{
			_currentAction = s0;
			_startTitleFade = true;
		}
		
		private var justPressed:Boolean = false;		
		private function s0():void
		{
			if (FlxG.keys.C) {
				justPressed = true;
				_speech.visible = true;
				_currentAction = s1;
			}
		}
		private function s1():void
		{
			if (FlxG.keys.C && !justPressed) {
				justPressed = true;
				_speech.loadGraphic(Images.Conclusion_Speech_2);
				_currentAction = s2;
			} else if (!FlxG.keys.C) {
				justPressed = false;
			}
		}
		private function s2():void
		{
			if (FlxG.keys.C && !justPressed) {
				justPressed = true;
				_speech.loadGraphic(Images.Conclusion_Speech_3);
				_currentAction = s3;
			} else if (!FlxG.keys.C) {
				justPressed = false;
			}
		}
		private function s3():void
		{
			if (FlxG.keys.C && !justPressed) {
				justPressed = true;
				_speech.loadGraphic(Images.Conclusion_Speech_4);
				_currentAction = s4;
			} else if (!FlxG.keys.C) {
				justPressed = false;
			}
		}
		private function s4():void
		{
			if (FlxG.keys.C && !justPressed) {
				justPressed = true;
				_speech.loadGraphic(Images.Conclusion_Speech_5);
				_currentAction = s5;
			} else if (!FlxG.keys.C) {
				justPressed = false;
			}
		}
		private function s5():void
		{
			if (FlxG.keys.C && !justPressed) {
				justPressed = true;
				_speech.visible = false;
				_speech.loadGraphic(Images.Conclusion_Speech_6);
				_currentAction = s6;
			} else if (!FlxG.keys.C) {
				justPressed = false;
			}
		}
		private function s6():void
		{
			if (FlxG.keys.UP) {
				_sabina.loadGraphic(Images.Conclusion_Sabina_2);
				if (FlxG.keys.C && !justPressed) {
					justPressed = true;
					_speech.visible = true;
					_currentAction = s7;
				} else if (!FlxG.keys.C) {
					justPressed = false;
				}

			}
			else {
				_sabina.loadGraphic(Images.Conclusion_Sabina_1);
			}
		}
		private function s7():void
		{
			if (FlxG.keys.C && !justPressed) {
				justPressed = true;
				FlxG.fade(0xff000000, 3, function():void {
					FlxG.switchState(new Start);
				});
				_currentAction = null;
			} else if (!FlxG.keys.C) {
				justPressed = false;
			}
		}
		
	}

}