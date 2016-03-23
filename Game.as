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
		public static const CELL_SIZE:uint = 20;
		public static const HALF_CELL_SIZE:uint = CELL_SIZE / 2;
		
		private var grid:Grid;
		private var apple:Apple;
		
		public function Game()
		{
			initialize();
		}
		
		private function add(x:int, y:int, type:uint):void
		{
			var clip:SkyClip;
			
			switch(type)
			{
				case Config.CELL_APPLE:
					{
						clip = new SkyClip();
						clip.setAnimation("apple");
						clip.x = x * Config.CELL_SIZE - Config.HALF_CELL_SIZE;
						clip.y = y * Config.CELL_SIZE - Config.HALF_CELL_SIZE;
						addChildAt(clip, 0);
						
						break;
					}
					
				case Config.CELL_SNAKE:
					{
						clip = new SkyClip();
						clip.setAnimation("body");
						clip.x = x * Config.CELL_SIZE - Config.HALF_CELL_SIZE;
						clip.y = y * Config.CELL_SIZE - Config.HALF_CELL_SIZE;
						addChildAt(clip, 0);
						
						break;
					}
			}
		}
		
		private function initialize():void
		{
			/*var grid:SkyClip = new SkyClip();
			grid.setAnimation("grid");
			addChild(grid);*/
			
			Console.instance.registerCommand("add", add, []);
			
			grid = new Grid();
			grid.initialize(800, 800, Config.CELL_SIZE);
			addChild(grid);
			
			apple = new Apple();
			apple.init(grid);
			apple.setPos(1, 1);
			addChildAt(apple, 0);
		}
		
		public function update(deltaTime:Number):void
		{
			if (SkyKeyboard.instance.isPressed(SkyKey.M))
			{
				grid.visible = !grid.visible;
			}
			
			if (SkyKeyboard.instance.isPressed(SkyKey.N))
			{
				apple.setRandomPos();
				
				trace(grid.toString());
			}
		}
	}
}