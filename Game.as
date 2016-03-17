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
			var grid:SkyClip = new SkyClip();
			grid.setAnimation("grid");
			addChild(grid);
			
			Console.instance.registerCommand("add", add, []);
			add(10, 10, Config.CELL_APPLE);
			add(11, 1, Config.CELL_SNAKE);
		}
		
		public function update(deltaTime:Number):void
		{
			
		}
	}
}