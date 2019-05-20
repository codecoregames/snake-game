package
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import skysand.input.SkyKey;
	import skysand.input.SkyKeyboard;
	import skysand.input.SkyMouse;
	import skysand.text.SkyFont;
	import skysand.ui.SkyButton;
	import skysand.ui.SkyColor;
	import skysand.ui.SkyUI;
	//import skysand.animation.SkyAnimationCache;
	//import skysand.animation.SkyClip;
	//import skysand.console.Console;
	import skysand.display.SkyRenderObjectContainer;
	//import skysand.featherData.SaveLoadData;
	import skysand.interfaces.IUpdatable;
	import skysand.text.SkyTextField;
	import skysand.utils.SkyMath;
	import skysand.utils.SkyVector2D;
	
	public class Game extends SkyRenderObjectContainer implements IUpdatable
	{
		private var apple:Apple;
		private var snake:Snake;
		private var isPressed:Boolean;
		private var counter:int = 0;
		public var gameover:Boolean;
		private var scoreField:SkyTextField;
		private var bestScoreField:SkyTextField;
		private var score:int;
		private var bestScore:int = 0;
		//private var data:SaveLoadData;
		private var plusScoreField:SkyTextField;
		private var playButton:SkyButton;
		
		public function Game()
		{
			SkyMouse.instance.calculateClosestObjectOnClick(true);
			gameover = false;
			initialize();
		}
		
		public function initialize():void
		{
			snake = new Snake();
			snake.initialize(4, 4, 1);
			snake.visible = false;
			addChild(snake);
			
			apple = new Apple();
			apple.init();
			apple.setSnake(snake);
			apple.setRandomPosition();
			apple.visible = false;
			addChildAt(apple, 0);
			/*
			data = SaveLoadData.instance;
			*/
			bestScoreField = new SkyTextField();
			bestScoreField.height = 40;
			bestScoreField.width = 300;
			bestScoreField.embedFonts = true;
			bestScoreField.font = SkyFont.I_FLASH;
			bestScoreField.size = 20;
			bestScoreField.textColor = 0xFFFFFF;
			bestScoreField.text = "HIGH SCORE: 0"// + String(data.loadData("best") ? data.loadData("best") : 0);
			bestScoreField.visible = false;
			addChild(bestScoreField);
			
			scoreField = new SkyTextField();
			scoreField.height = 40;
			scoreField.width = 300;
			scoreField.y = 30;
			scoreField.embedFonts = true;
			scoreField.font = SkyFont.I_FLASH;
			scoreField.size = 20;
			scoreField.textColor = 0xFFFFFF;
			scoreField.visible = false;
			addChild(scoreField);
			
			plusScoreField = new SkyTextField();
			plusScoreField.height = 40;
			plusScoreField.width = 100;
			plusScoreField.embedFonts = true;
			plusScoreField.font = SkyFont.I_FLASH;
			plusScoreField.size = 20;
			plusScoreField.textColor = 0xFFFFFF;
			plusScoreField.text = "+100";
			plusScoreField.visible = false;
			addChild(plusScoreField);
			
			playButton = new SkyButton();
			playButton.create(SkyUI.RECTANGLE, 100, 40, SkyColor.SAPPHIRE_BLUE, newGame);
			playButton.addText("Start", SkyFont.I_FLASH, 0xFFFFFF);
			playButton.x = (Config.WINDOW_WIDTH - playButton.width) / 2;
			playButton.y = (Config.WINDOW_HEIGHT - playButton.height) / 2;
			addChild(playButton);
			
			isPressed = false;
			gameover = false;
			score = 0;
		}
		
		private function newGame():void
		{
			playButton.visible = false;
			plusScoreField.visible = true;
			scoreField.visible = true;
			bestScoreField.visible = true;
			apple.visible = true;
			snake.visible = true;
		}
		
		private function gameOver():void
		{
			playButton.visible = true;
			plusScoreField.visible = false;
			scoreField.visible = false;
			bestScoreField.text = "BEST SCORE: " + String(score < bestScore ? bestScore : score);
			bestScoreField.visible = false;
			apple.visible = false;
			snake.visible = false;
			
			score = 0;
			/*if (score > data.loadData("best"))
			{
				//bestScoreField.text = "HIGH SCORE: " + String(score);
				//data.saveData("best", score);
			}*/
		}
		
		public function destroy():void
		{
			removeChild(apple);
			apple.destroy();
			apple = null;
			
			removeChild(snake);
			snake.destroy();
			snake = null;
			
			removeChild(scoreField);
			scoreField.free();
			scoreField = null;
			
			removeChild(bestScoreField);
			bestScoreField.free();
			bestScoreField = null;
			
			removeChild(plusScoreField);
			plusScoreField.free();
			plusScoreField = null;
			
			//data = null;
		}
		
		public function update(deltaTime:Number):void
		{
			if (!gameover)
			{
				if (SkyKeyboard.instance.isPressed(SkyKey.UP) && !isPressed)
				{
					snake.moveUp();
					isPressed = true;
				}
				
				if (SkyKeyboard.instance.isPressed(SkyKey.DOWN) && !isPressed)
				{
					snake.moveDown();
					isPressed = true;
				}
				
				if (SkyKeyboard.instance.isPressed(SkyKey.LEFT) && !isPressed)
				{
					snake.moveLeft();
					isPressed = true;
				}
				
				if (SkyKeyboard.instance.isPressed(SkyKey.RIGHT) && !isPressed)
				{
					snake.moveRight();
					isPressed = true;
				}
				
				counter++;
				
				if (counter >= 10)
				{
					if (snake.isAteItself)
					{
						gameOver();
					}
					
					snake.update(deltaTime);
					isPressed = false;
					
					var sp:Point = snake.headPosition;
					var ap:Point = apple.position;
					
					if (sp.x == ap.x && sp.y == ap.y)
					{
						plusScoreField.x = apple.x;
						plusScoreField.y = apple.y;
						plusScoreField.scaleX = 1;
						plusScoreField.scaleY = 1;
						plusScoreField.visible = true;
						
						apple.setRandomPosition();
						snake.grownUp();
						
						score += 100;
					}
					
					scoreField.text = "SCORE: " + String(score);
					
					counter = 0;
				}
				
				if (plusScoreField.scaleX >= 0.4)
				{
					plusScoreField.y -= 3;
					//plusScoreField.x -= width * 0.01;
					plusScoreField.scaleX -= 0.01;
					plusScoreField.scaleY -= 0.01;
				}
				else
				{
					plusScoreField.visible = false;
					plusScoreField.scaleX = 1;
					plusScoreField.scaleY = 1;
				}
			}
		}
	}
}