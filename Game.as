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
		private var grid:Grid;
		private var apple:Apple;
		private var snake:Snake;
		private var isPressed:Boolean;
		private var counter:int = 0;
		private var gameover:Boolean;
		private var scoreField:SkyTextField;
		private var bestScoreField:SkyTextField;
		private var score:int;
		private var data:SaveLoadData;
		
		public function Game()
		{
			initialize();
		}
		
		private function initialize():void
		{
			grid = new Grid();
			grid.initialize(800, 800, Config.CELL_SIZE);
			addChild(grid);
			
			apple = new Apple();
			apple.init();
			apple.setPos(1, 1);
			addChildAt(apple, 0);
			
			snake = new Snake();
			snake.init(4, 4, 1);
			addChildAt(snake, 1);
			
			data = SaveLoadData.instance;
			
			bestScoreField = new SkyTextField();
			bestScoreField.height = 40;
			bestScoreField.width = 300;
			bestScoreField.embedFonts = true;
			bestScoreField.font = "flash";
			bestScoreField.size = 20;
			bestScoreField.textColor = 0xFFFFFF;
			bestScoreField.text = "BEST SCORE: " + String(data.loadData("best"));
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
			
			isPressed = false;
			gameover = false;
			score = 0;
		}
		
		public function update(deltaTime:Number):void
		{
			if (SkyKeyboard.instance.isPressed(SkyKey.M))
			{
				grid.visible = !grid.visible;
			}
			
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
				if (snake.isAteThemself)
				{
					if (score > data.loadData("best"))
					{
						bestScoreField.text = "BEST SCORE: " + String(score);
						data.saveData("best", score);
					}
					
					gameover = true;
				}
				
				if (!gameover)
				{
					snake.update(deltaTime);
					counter = 0;
					isPressed = false;
					
					var sp:Point = snake.pos;
					var ap:Point = apple.getPos();
					
					if (sp.x == ap.x && sp.y == ap.y)
					{
						apple.setRandomPos(snake);
						snake.grownUp();
						score += 100;
					}
					
					scoreField.text = "SCORE: " + String(score);
				}
			}
		}
	}
}