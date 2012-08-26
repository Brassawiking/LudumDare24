package States.Prelude 
{
	import org.flixel.*;
	import Resources.*;
	import States.Run.Run;
	public class Prelude extends FlxState
	{
		private var _title:FlxSprite;
		private var _sabina:FlxSprite;
		private var _backpack:FlxSprite;
		private var _nearCrowd:FlxSprite;
		private var _farCrowd:FlxSprite;
		private var _explosion:FlxSprite;
		
		private var _mainGroup:FlxGroup;
		
		private var _currentAction:Function;
		
		private var _startTitleFade:Boolean = false;
		
		override public function create():void 
		{ 
			var _mainGroup:FlxGroup = new FlxGroup();
			
			_mainGroup.add(new FlxSprite(0, 0, Images.Prelude_bg));

			_explosion = new FlxSprite(0, 0, Images.Prelude_explosion);
			_explosion.visible = false;
			_farCrowd = new FlxSprite(0, 0, Images.Prelude_crowdFar)
			_nearCrowd = new FlxSprite(0, 0, Images.Prelude_crowdNear)
			
			_mainGroup.add(_explosion);
			_mainGroup.add(_farCrowd);
			_mainGroup.add(_nearCrowd);
			
			_sabina = new FlxSprite(0, 0, Images.Prelude_Sabina_1);
			_mainGroup.add(_sabina);
			_backpack = new FlxSprite(0, 0, Images.Prelude_Backpack_1);
			_backpack.visible = false;
			_mainGroup.add(_backpack);
			
			_title = new FlxSprite(0, 0, Images.Prelude_title);			
			_title.alpha = 0;
			
			add(_mainGroup);
			add(_title);
			add(new FlxSprite(0, 0, Images.Letterbox));

			FlxG.flash(0xff000000, 1, fadeInComplete);
		}
		
		private var frameCounter:int = 0;
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
			
			frameCounter++;
			_farCrowd.y = Math.sin(frameCounter / 20) * 5;
			_nearCrowd.y = 5 + Math.sin(frameCounter / 15) * 5;

		}
		
		private function fadeInComplete():void
		{
			_currentAction = RaiseSign;
			_startTitleFade = true;
		}
				
		private var raisedCount:int = 0;
		private var isRaised:Boolean = false;
		private function RaiseSign():void
		{
			if (FlxG.keys.UP)
			{
				if (!isRaised) {
					isRaised = true;
					raisedCount++;
				}
				_sabina.loadGraphic(Images.Prelude_Sabina_2);
			}
			else 
			{
				isRaised = false;
				_sabina.loadGraphic(Images.Prelude_Sabina_1);
			}
			
			if (raisedCount > 3) {
				_sabina.loadGraphic(Images.Prelude_Sabina_1);
				_currentAction = PutDownSign;
			}
		}
		
		private function PutDownSign():void
		{
			if (FlxG.keys.DOWN)
			{
				_sabina.loadGraphic(Images.Prelude_Sabina_3);
				_currentAction = SearchBag;
			}
		}
		
		private var gotCamera:Boolean = false;
		private var bagOpen:Boolean = false;
		private function SearchBag():void
		{
			if (FlxG.keys.X)
			{
				_sabina.loadGraphic(Images.Prelude_Sabina_4);
				_backpack.visible = true;
				
				if (bagOpen)
				{
					if (FlxG.keys.DOWN)
					{
						_backpack.loadGraphic(Images.Prelude_Backpack_3);
						if (FlxG.keys.C)
						{
							gotCamera = true;
						}
					}
					else if (gotCamera)
					{
						_backpack.loadGraphic(Images.Prelude_Backpack_4);
					}
					else 
					{
						_backpack.loadGraphic(Images.Prelude_Backpack_2);
					}
				}
				else 
				{
					_backpack.loadGraphic(Images.Prelude_Backpack_1);
					if (FlxG.keys.UP) 
					{
						bagOpen = true;
					}
				}				
			}
			else if (gotCamera) {
				_sabina.loadGraphic(Images.Prelude_Sabina_5);
				_backpack.visible = false;
				_currentAction = TakePicture;
			}
			else
			{
				_sabina.loadGraphic(Images.Prelude_Sabina_3);
				_backpack.visible = false;
			}
		}

		private function TakePicture():void
		{
			if (FlxG.keys.UP)
			{4
				_sabina.loadGraphic(Images.Prelude_Sabina_6);
				if (FlxG.keys.C) {
					FlxG.play(Sound.click);
					FlxG.flash(0xffffffff, 1, EndPreludeScene);
					_currentAction = null;
				}
			}
			else 
			{
				_sabina.loadGraphic(Images.Prelude_Sabina_5);	
			}			
		}
		
		private function EndPreludeScene():void
		{
			FlxG.flash(0x99ff0000)
			FlxG.play(Sound.bigexplosion);
			_explosion.visible = true;
			FlxG.shake(0.05, 2, FinalFadeOut, true, 2);
		}
		
		private function FinalFadeOut():void
		{
			FlxG.fade(0xff000000, 1, LoadNextState);
		}
		
		private function LoadNextState():void
		{
			FlxG.switchState(new Run);
		}
	}
}