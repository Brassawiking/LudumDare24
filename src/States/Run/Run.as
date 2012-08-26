package States.Run 
{
	import org.flixel.*;
	import Resources.*;
	import States.Survive.Survive;
	public class Run extends FlxState
	{
		
		private var _title:FlxSprite;
		
		private var _bgA:FlxSprite;
		private var _bgB:FlxSprite;
		
		private var _enemy:FlxSprite;
		private var _car:FlxSprite;
		private var _sabina:FlxSprite;
		private var _mainGroup:FlxGroup;
		
		private var _currentAction:Function;
		
		private var _startTitleFade:Boolean = false;
		
		private var _movingVelocity:Number = 0.0;
		private var _diveBoost:Number = 0.0;
		
		private var _distance:Number = 0.0;
		
		override public function create():void 
		{ 
			var _mainGroup:FlxGroup = new FlxGroup();
			
			_bgA = new FlxSprite(0, 0, Images.Run_bg);
			_bgB = new FlxSprite( -960, 0, Images.Run_bg);
			
			_mainGroup.add(_bgA);
			_mainGroup.add(_bgB);
			
			_enemy = new FlxSprite(1000, 0, Images.Run_enemy);
			_car = new FlxSprite(200, 0, Images.Run_car);
			_sabina = new FlxSprite(350, 0, Images.Run_Sabina_standing);
			_mainGroup.add(_enemy);
			_mainGroup.add(_car);
			_mainGroup.add(_sabina);
			
			_title = new FlxSprite(0, 0, Images.Run_title);			
			_title.alpha = 0;
			
			add(_mainGroup);
			add(_title);
			add(new FlxSprite(0, 0, Images.Letterbox));

			FlxG.flash(0xff000000, 1, fadeInComplete);
			_currentAction = Alive;
		}
		
		private var reverseTitleFade:Boolean = false;
		private var duck:Boolean = false;
		private var diving:Boolean = false;
		private var runAlternate:Boolean = false;
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
			var offset = (_bgA.x + _movingVelocity + _diveBoost) % 960;
			_bgA.x = offset;
			_bgB.x = offset - 960;
			
			if (_currentAction != null) {
				_currentAction();
			}

			_movingVelocity = Math.max(_movingVelocity - 0.1, 0);
			_diveBoost = Math.max(_diveBoost - 0.1, 0);
			
			
			_enemy.x -= 10;
			if (_enemy.x < -5000) {
				_enemy.x = 1000;
			}
			
			_car.x += _movingVelocity + _diveBoost;
			if (_car.x > 3000) {
				_car.x = -1000;
			}
			
			_distance += _movingVelocity + _diveBoost;
			if (_distance > 15000) {
				_currentAction = LevelComplete;
			}
			
			
		}

		private function fadeInComplete():void
		{
			_startTitleFade = true;
		}
		
		private function Alive():void
		{
			if (FlxG.keys.DOWN && !diving) {
				_movingVelocity = 0;
				_sabina.loadGraphic(Images.Run_Sabina_duck);
				duck = true;
			}
			else if (!diving){
				duck = false;
			}
			
			if (!duck && !diving) {
				if ((FlxG.keys.C && runAlternate) || (FlxG.keys.X && !runAlternate) ) {
					runAlternate = !runAlternate;
					_movingVelocity = Math.min(_movingVelocity + 3, 8);
				}	
			}
			if (!diving && !duck) {
				if (_movingVelocity > 0) {
					_sabina.loadGraphic(Images.Run_Sabina_running);
				} else {
					_sabina.loadGraphic(Images.Run_Sabina_standing);
				}
			}
			
			if (FlxG.keys.LEFT && !diving) {
				_diveBoost = 7;
				diving = true;
				_sabina.loadGraphic(Images.Run_Sabina_dive);
				_sabina.x = 250;
			}
			
			if (FlxG.keys.UP && diving && _movingVelocity == 0 && _diveBoost == 0) {
				diving = false;
				_sabina.x = 350;
			}
			
			if (_sabina.overlaps(_car)) {
				if (!diving && !duck && _sabina.overlaps(_enemy)) {
					_sabina.loadGraphic(Images.Run_Sabina_dead);
					_currentAction = Dead;
				}
			}
			else if (_sabina.overlaps(_enemy)) {
				_sabina.loadGraphic(Images.Run_Sabina_dead);
				_currentAction = Dead;
			}
			
		}
		
		private function Dead():void
		{
			
			if (_movingVelocity == 0 && _diveBoost == 0) {
				FlxG.fade(0xff000000, 1, function():void {
					FlxG.switchState(new Run);
				});
			}
		}
		
		private function LevelComplete():void
		{
			FlxG.fade(0xff000000, 1, function():void {
				FlxG.switchState(new Survive);
			});
		}
	}

}