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
	
	public class Game extends RenderObject implements IUpdatable
	{
		private var grid:Grid;
		
		public function Game()
		{
			prepareGraphics();
			initialize();
		}
		
		private function initialize():void
		{
			grid = new Grid();
			grid.initialize(800, 800, Grid.CELL_SIZE);
			addChild(grid.getSprite());
			
			var apple:SkyClip = new SkyClip();
			apple.setAnimation("apple");
			grid.add(7, 4, apple, Grid.CELL_APPLE);
			
			//trace(grid.toString());
		}
		
		private function prepareGraphics():void
		{
			var debugGrid:Sprite = new Sprite();
			debugGrid.graphics.lineStyle(1, 0xDF0652, 0.5);
			
			var nCells:int = int(800 / Grid.CELL_SIZE);
			
			for (var i:int = 0; i < nCells; i++) 
			{
				for (var j:int = 0; j < nCells; j++) 
				{
					debugGrid.graphics.drawRect(i * Grid.CELL_SIZE, j * Grid.CELL_SIZE, Grid.CELL_SIZE, Grid.CELL_SIZE);
				}
			}
			
			var apple:Sprite = new Sprite();
			apple.graphics.beginFill(0x18D187);
			apple.graphics.drawCircle(0, 0, Grid.HALF_CELL_SIZE);
			
			SkyAnimationCache.instance.addAnimationFromSprite(apple, "apple");
			SkyAnimationCache.instance.addAnimationFromSprite(debugGrid, "grid");		
		}
		
		public function update(deltaTime:Number):void
		{
			
		}
	}
}