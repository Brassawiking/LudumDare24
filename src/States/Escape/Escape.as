package States.Escape 
{
	import org.flixel.*;
	import Resources.*;
	import States.Conclusion.Conclusion;
	public class Escape extends FlxState
	{
		
		private var _title:FlxSprite;
		private var _sabina:FlxSprite;
		private var _gun:FlxSprite;
		private var _crosshair:FlxSprite;
		private var _holdon:FlxSprite;
		private var _lookout:FlxSprite;
		private var _ejected:FlxSprite;
		private var _mainGroup:FlxGroup;
		
		private var _jeepNear:FlxSprite;
		private var _jeepFar:FlxSprite;
		private var _helicopter:FlxSprite;

		private var _jeepNearHP:int = 10;
		private var _jeepFarHP:int = 10;
		private var _helicopterHP:int = 15;

		
		private var _currentAction:Function;
		
		private var _startTitleFade:Boolean = false;
		
		override public function create():void 
		{ 
			var _mainGroup:FlxGroup = new FlxGroup();
			
			_mainGroup.add(new FlxSprite(0, 0, Images.Escape_bg));
		
			_sabina = new FlxSprite(0, 0, Images.Escape_Sabina_1);
			_gun = new FlxSprite(0, 0, Images.Escape_Gun_1);
			_gun.visible = false;
			_holdon = new FlxSprite(0, 0, Images.Escape_holdon);
			_holdon.visible = false;
			_lookout = new FlxSprite(0, 0, Images.Escape_lookout);
			_lookout.visible = false;	
			_ejected = new FlxSprite(0, 0, Images.Escape_Sabina_ejected);
			_ejected.visible = false;
			_crosshair = new FlxSprite(750, 150, Images.Escape_crosshair);
			_crosshair.visible = false;
			
			_helicopter = new FlxSprite(800, 60, Images.Escape_Helicopter_1);
			_jeepFar = new FlxSprite(700, 120, Images.Escape_JeepFar_1);
			_jeepNear = new FlxSprite(850, 150, Images.Escape_JeepNear_1);
			
			_mainGroup.add(_helicopter);
			_mainGroup.add(_jeepFar);
			_mainGroup.add(_jeepNear);
			
			_mainGroup.add(_sabina);
			_mainGroup.add(_gun);
			_mainGroup.add(_holdon);
			_mainGroup.add(_lookout);
			_mainGroup.add(_ejected);
			_mainGroup.add(_crosshair);
			
			_title = new FlxSprite(0, 0, Images.Escape_title);			
			_title.alpha = 0;
			
			add(_mainGroup);
			add(_title);
			add(new FlxSprite(0, 0, Images.Letterbox));

			FlxG.flash(0xff000000, 1, fadeInComplete);
		}
		
		private var bumpTimer:int = 300;
		private var attackTimer:int = 500;
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
			
			bumpTimer--;
			attackTimer--;
			
			if (bumpTimer < 45) {
				_holdon.visible = true;
			}
			if (attackTimer < 45) {
				_lookout.visible = true;
			}			
			if (bumpTimer < 0) {
				_holdon.visible = false;
				FlxG.shake(0.05, 0.5, null, true, 2);
				bumpTimer = 200 + Math.random() * 500;
				
				if (_crosshair.visible) {
					_crosshair.visible = false;
					_currentAction = Ejected;
					_sabina.loadGraphic(Images.Escape_Sabina_4);
					_ejected.visible = true;					
				}
			}
			if (attackTimer < 0) {
				_lookout.visible = false;
				FlxG.flash(0xffffffff, 0.1);
				FlxG.play(Sound.machinegun);
				attackTimer = 200 + Math.random() * 500;
				
				if (_crosshair.visible) {
					_crosshair.visible = false;
					_currentAction = null;
					_sabina.loadGraphic(Images.Escape_Sabina_3);
					FlxG.fade(0xff000000, 1, function():void {
						FlxG.switchState(new Escape);
					});
				}
			}

			frameCounter++;
			if (_jeepNearHP > 0) {
				_jeepNear.x = 850 + (Math.sin(frameCounter / 35) * 2 - 1) * 35;
			} else if (_jeepNearHP == 0) {
				_jeepNearHP--;
				FlxG.play(Sound.explosion);
			} else {
				_jeepNear.loadGraphic(Images.Escape_JeepNear_2);
				_jeepNear.x += 10;
			}
			
			if (_jeepFarHP > 0) {
				_jeepFar.x = 700 + (Math.sin(frameCounter / 60)*2 - 1) * 20;
			} else if (_jeepFarHP == 0) {
				_jeepFarHP--;
				FlxG.play(Sound.explosion);
			} else {
				_jeepFar.loadGraphic(Images.Escape_JeepFar_2);
				_jeepFar.x += 10;
			}
			
			if (_helicopterHP > 0) {
				_helicopter.y = 60 + (Math.sin(frameCounter / 50)*2 - 1) * 10;
			} 
			else if (_helicopterHP == 0) {
				_helicopterHP--;
				FlxG.play(Sound.explosion);
			} else {
				_helicopter.loadGraphic(Images.Escape_Helicopter_2);
				_helicopter.x += 10;
			}
						
		}
		
		private function fadeInComplete():void
		{
			_currentAction = GetGun;
			_startTitleFade = true;
		}
		
		private var gotGun:Boolean = false;
		private function GetGun():void
		{
			if (FlxG.keys.C) {
				_gun.visible = true;
				
				if (FlxG.keys.UP) {
					gotGun = true;
					_gun.loadGraphic(Images.Escape_Gun_2);
				}
				
			} else if (gotGun) {
				_gun.visible = false;
				_gun.loadGraphic(Images.Escape_Gun_3);
				_currentAction = ShootOut;
			} else {
				_gun.visible = false;
			}
		}
		private var crosshairSpeed:int = 3;
		private var ammo:int = 7;
		private var gotMag:Boolean = false;
		private var gunReady:Boolean = false;
		private var justFired:Boolean = false;
		private var gunCocked:Boolean = false;
		private function ShootOut():void
		{
			if (FlxG.keys.X) {
				_sabina.loadGraphic(Images.Escape_Sabina_2);
				_crosshair.visible = true;
				_gun.visible = false;
				
				
				if (FlxG.keys.UP) {
					_crosshair.y -= crosshairSpeed; 
				}
				if (FlxG.keys.DOWN) {
					_crosshair.y += crosshairSpeed; 
				}
				if (FlxG.keys.LEFT) {
					_crosshair.x -= crosshairSpeed; 
				}
				if (FlxG.keys.RIGHT) {
					_crosshair.x += crosshairSpeed; 
				}
				
				
				if (FlxG.keys.C) {
					if (ammo > 0 && !justFired) {
						justFired = true;
						FlxG.flash(0x99ffffff, 0.1);
						FlxG.play(Sound.gun);
						ammo--;
						checkDamage();
						if (ammo == 0) {
							gunReady = false;
							gotMag = false;
						}
					} else if (!justFired) {
						justFired = true;
						FlxG.play(Sound.click);
					}
				} else {
					justFired = false;
				}
				
			} 
			else if (FlxG.keys.C && ammo == 0) {
				_gun.visible = true;
				if (FlxG.keys.UP && !gotMag) {
					_gun.loadGraphic(Images.Escape_Gun_4);
					gotMag = true;
				} else if (FlxG.keys.RIGHT && gotMag) {
					if (!gunReady) {
						gunReady = true;
					}
					if (!gunCocked) {
						FlxG.play(Sound.click2);
						gunCocked = true;
					}
					_gun.loadGraphic(Images.Escape_Gun_5);
				} else if (gotMag) {
					if (gunCocked) {
						FlxG.play(Sound.click);
						gunCocked = false;
					}
					_gun.loadGraphic(Images.Escape_Gun_4);
				} else {
					_gun.loadGraphic(Images.Escape_Gun_3);
				}				
			}		
			else {
				if (gunReady) {
					ammo = 7;
				}
				
				_sabina.loadGraphic(Images.Escape_Sabina_1);
				_crosshair.visible = false;
				_gun.visible = false;
			}

			
		}
		
		private function checkDamage():void {
			if (_crosshair.overlaps(_jeepNear)) {
				_jeepNearHP--;
			} else if (_crosshair.overlaps(_jeepFar)) {
				_jeepFarHP--;
			} else if (_crosshair.overlaps(_helicopter)) {
				_helicopterHP--;
			}
			
			if (_jeepNearHP <= 0 && _jeepFarHP <= 0 && _helicopterHP <= 0) {
				FlxG.fade(0xff000000, 1, function():void {
					FlxG.switchState(new Conclusion);
				});
			}
		}
		
		private var fadeStarted:Boolean = false;
		private function Ejected():void {
			if (!fadeStarted) {
				fadeStarted = true;
				FlxG.fade(0xff000000, 1, function():void {
					FlxG.switchState(new Escape);
				});
			}
			_ejected.x += 10;
			_ejected.y += 5;
		}

	}

}