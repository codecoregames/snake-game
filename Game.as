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
		public function Game()
		{
			/*prepareGraphics();
			initialize();*/
			var apple:Apple = new Apple();
			apple.init();
			apple.setPosition(4, 5);
			addChild(apple);
		}
		public function initialize():void
		{
			grid = new Grid();
			grid.initialize(800, 800, Grid.CELL_SIZE);
			addChild(grid.getSprite());
			var apple:SkyClip = new SkyClip();
			apple.setAnimation("apple");
			grid.add(7, 4, apple, Grid.CELL_APPLE);
			
		}
		
		public function prepareGraphics():void
		{
			var debugGrid:Sprite = new Sprite();
			debugGrid.graphics.lineStyle(1, 0xDF0652, 0.5); //задаём отрисовку квадратов линиями(толщина, цвет линии, прозрачность).
			
			var nCells:int = int(800 / Grid.CELL_SIZE); //получаем количество клеток на экране.
			
			for (var i:int = 0; i < nCells; i++) 
			{
				for (var j:int = 0; j < nCells; j++) 
				{
					debugGrid.graphics.drawRect(i * Grid.CELL_SIZE, j * Grid.CELL_SIZE, Grid.CELL_SIZE, Grid.CELL_SIZE);
				}
			}
			var apple:Sprite = new Sprite();
			apple.graphics.beginFill(0x18D187);
			apple.graphics.drawCircle( 0, 0, Grid.HALF_CELL_SIZE);
			SkyAnimationCache.instance.addAnimationFromSprite(debugGrid, "grid");
			SkyAnimationCache.instance.addAnimationFromSprite(apple, "apple");
		}
		public function update():void
		{
			
		}
	}
}