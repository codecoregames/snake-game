package
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import skysand.animation.SkyAnimationCache;
	import skysand.animation.SkyClip;
	import skysand.console.Console;
	import skysand.interfaces.IUpdatable;
	import skysand.keyboard.SkyKey;
	import skysand.keyboard.SkyKeyboard;
	import skysand.render.RenderObject;
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
			
			isPressed = false;
			gameover = false;
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
					}
				}
				
				if (snake.isAteThemself)
				{
					gameover = true;
				}
			}
		}
	}
}