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
			apple.init(grid);
			apple.setPos(1, 1);
			addChildAt(apple, 0);
			
			snake = new Snake();
			snake.init(4, 4, grid);
			addChildAt(snake, 1);
		}
		
		public function update(deltaTime:Number):void
		{
			if (SkyKeyboard.instance.isPressed(SkyKey.M))
			{
				grid.visible = !grid.visible;
			}
			
			if (SkyKeyboard.instance.isPressed(SkyKey.N))
			{
				snake.grownUp();
			}
			
			if (SkyKeyboard.instance.isPressed(SkyKey.UP))
			{
				snake.moveUp();
			}
			
			if (SkyKeyboard.instance.isPressed(SkyKey.DOWN))
			{
				snake.moveDown();
			}
			
			if (SkyKeyboard.instance.isPressed(SkyKey.LEFT))
			{
				snake.moveLeft();
			}
			
			if (SkyKeyboard.instance.isPressed(SkyKey.RIGHT))
			{
				snake.moveRight();
			}
			
			counter++;
			
			if (counter >= 10)
			{
				snake.update(deltaTime);
				counter = 0;
				
				var sp:Point = snake.pos;
				var ap:Point = apple.getPos();
				
				if (sp.x == ap.x && sp.y == ap.y)
				{
					apple.setRandomPos();
					snake.grownUp();
				}
			}
		}
		
		private var counter:int = 0;
	}
}