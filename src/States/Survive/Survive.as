package States.Survive 
{
	import org.flixel.*;
	import Resources.*;
	import States.Escape.Escape;
	public class Survive extends FlxState
	{
		
		private var _title:FlxSprite;
		private var _sabina:FlxSprite;
		private var _toolbox:FlxSprite;
		private var _enemy:FlxSprite;
		private var _mainGroup:FlxGroup;
		
		private var _currentAction:Function;
		
		private var _startTitleFade:Boolean = false;
		
		override public function create():void 
		{ 
			var _mainGroup:FlxGroup = new FlxGroup();
			
			_mainGroup.add(new FlxSprite(0, 0, Images.Survive_bg));
			
			_enemy = new FlxSprite(0, 0, Images.Survive_Enemy_1)
			_sabina = new FlxSprite(0, 0, Images.Survive_Sabina_1);
			_toolbox = new FlxSprite(0, 0, Images.Survive_Toolbox_1);
			_toolbox.visible = false;
			
			_mainGroup.add(_enemy);
			_mainGroup.add(_sabina);
			_mainGroup.add(_toolbox);
			
			_title = new FlxSprite(0, 0, Images.Survive_title);			
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
			_currentAction = Alive;
			_startTitleFade = true;
		}
		
		private var gotScrewdriver:Boolean = false;
		private var boxOpen:Boolean = false;
		private function Alive():void
		{
			if (FlxG.keys.LEFT && !FlxG.keys.X) {
				if (gotScrewdriver) {
					_currentAction = Survived;
				} else {
					_currentAction = Dead;	
				}				
			}
			if (FlxG.keys.X) {
				_sabina.loadGraphic(Images.Survive_Sabina_2);
				_toolbox.visible = true;
				
				if (FlxG.keys.UP && !boxOpen) {
					boxOpen = true;
				} else if (FlxG.keys.DOWN && boxOpen) {
					_toolbox.loadGraphic(Images.Survive_Toolbox_3);
					if (FlxG.keys.C) {
						gotScrewdriver = true;
					}
				} else if (gotScrewdriver) {
					_toolbox.loadGraphic(Images.Survive_Toolbox_4);
				} else if (boxOpen) {
					_toolbox.loadGraphic(Images.Survive_Toolbox_2)
				}
			} else {
				if (gotScrewdriver) {
					_sabina.loadGraphic(Images.Survive_Sabina_5);
				} else {
					_sabina.loadGraphic(Images.Survive_Sabina_1);
				}				
				_toolbox.visible = false;
			}
			
		}
		
		private function Dead():void
		{
			_toolbox.visible = false;
			_enemy.loadGraphic(Images.Survive_Enemy_2);
			_sabina.loadGraphic(Images.Survive_Sabina_4);
			
			_currentAction = null;
			FlxG.play(Sound.machinegun);
			FlxG.fade(0xff000000, 1, function():void {
				FlxG.switchState(new Survive);
			});
		}
		
		private function Survived():void
		{
			_toolbox.visible = false;
			_enemy.loadGraphic(Images.Survive_Enemy_3);
			_sabina.loadGraphic(Images.Survive_Sabina_3);
			
			_currentAction = null;
			FlxG.play(Sound.machinegun);
			FlxG.fade(0xff000000, 1, function():void {
				FlxG.switchState(new Escape);
			});
		}

	}

}