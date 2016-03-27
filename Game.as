package
{
	import flash.display.Sprite;
	import skysand.animation.SkyAnimationCache;
	import skysand.animation.SkyClip;
	import skysand.console.Console;
	import skysand.interfaces.IUpdatable;
	import skysand.keyboard.SkyKey;
	import skysand.keyboard.SkyKeyboard;
	import skysand.render.RenderObject;
	import skysand.utils.SkyVector2D;
	
	public class Game extends RenderObject
	{		
		private var grid:Grid;
		private var apple:Apple;
		private var snake:Snake;
		
		public function Game()
		{
			snake = new Snake();
			snake.init();
			addChild(snake);
			
			apple = new Apple();
			apple.init();
			apple.setPosition(4, 5);
			apple.setCurrentSnake(snake);
			addChild(apple);
			
		}
		
		public function update():void
		{
			apple.setRandomPosition();
		}
	}
}