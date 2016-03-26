package
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import skysand.animation.SkyAnimationCache;
	import skysand.animation.SkyClip;
	import skysand.console.Console;
	import skysand.featherData.SaveLoadData;
	import skysand.interfaces.IUpdatable;
	import skysand.keyboard.SkyKey;
	import skysand.keyboard.SkyKeyboard;
	import skysand.render.RenderObject;
	import skysand.text.SkyTextField;
	import skysand.utils.SkyMath;
	import skysand.utils.SkyVector2D;
	
	public class Game extends RenderObject
	{
		private var apple:Apple;
		private var snake:Snake;
		private var isPressed:Boolean;
		private var counter:int = 0;
		public var gameover:Boolean;
		private var scoreField:SkyTextField;
		private var bestScoreField:SkyTextField;
		private var score:int;
		private var data:SaveLoadData;
		private var plusScoreField:SkyTextField;
		
		public function Game()
		{
			gameover = true;
		}
		
		public function initialize():void
		{
			snake = new Snake();
			snake.init(4, 4, 1);
			addChildAt(snake, 1);
			
			apple = new Apple();
			apple.init();
			apple.setCurrentSnake(snake);
			apple.setRandomPosition();
			addChildAt(apple, 0);
			
			data = SaveLoadData.instance;
			
			bestScoreField = new SkyTextField();
			bestScoreField.height = 40;
			bestScoreField.width = 300;
			bestScoreField.embedFonts = true;
			bestScoreField.font = "flash";
			bestScoreField.size = 20;
			bestScoreField.textColor = 0xFFFFFF;
			bestScoreField.text = "HIGH SCORE: " + String(data.loadData("best") ? data.loadData("best") : 0);
			addChild(bestScoreField);
			
			scoreField = new SkyTextField();
			scoreField.height = 40;
			scoreField.width = 300;
			scoreField.y = 30;
			scoreField.embedFonts = true;
			scoreField.font = "flash";
			scoreField.size = 20;
			scoreField.textColor = 0xFFFFFF;
			addChild(scoreField);
			
			plusScoreField = new SkyTextField();
			plusScoreField.height = 40;
			plusScoreField.width = 100;
			plusScoreField.embedFonts = true;
			plusScoreField.font = "flash";
			plusScoreField.size = 20;
			plusScoreField.textColor = 0xFFFFFF;
			plusScoreField.text = "+100";
			plusScoreField.visible = false;
			addChild(plusScoreField);
			
			isPressed = false;
			gameover = false;
			score = 0;
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
			
			data = null;
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
						if (score > data.loadData("best"))
						{
							bestScoreField.text = "HIGH SCORE: " + String(score);
							data.saveData("best", score);
						}
						
						gameover = true;
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