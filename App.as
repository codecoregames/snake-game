package 
{
	import flash.display.Sprite;
	import skysand.animation.SkyAnimationCache;
	import skysand.interfaces.IUpdatable;
	import skysand.render.RenderObject;
	
	public class App extends RenderObject implements IUpdatable
	{
		private var game:Game;
		
		public function App() 
		{
			prepareGraphics();
			
			game = new Game();
			addChild(game);
		}
		
		private function prepareGraphics():void
		{
			var head:Sprite = new Sprite();
			head.graphics.beginFill(0xC82286);
			head.graphics.drawRect( -Config.HALF_CELL_SIZE, -Config.HALF_CELL_SIZE, Config.CELL_SIZE, Config.CELL_SIZE);
			
			var body:Sprite = new Sprite();
			body.graphics.beginFill(0xE0549A);
			body.graphics.drawRect( -Config.HALF_CELL_SIZE, -Config.HALF_CELL_SIZE, Config.CELL_SIZE, Config.CELL_SIZE);
			
			var apple:Sprite = new Sprite();
			apple.graphics.beginFill(0x18D187);
			apple.graphics.drawRect( -Config.HALF_CELL_SIZE, -Config.HALF_CELL_SIZE, Config.CELL_SIZE, Config.CELL_SIZE);
			
			var debugGrid:Sprite = new Sprite();
			debugGrid.graphics.lineStyle(1, 0xDF0652, 0.5);
			
			var nCells:int = int(Config.WINDOW_SIZE_X / Config.CELL_SIZE);
			
			for (var i:int = 0; i < nCells; i++) 
			{
				for (var j:int = 0; j < nCells; j++) 
				{
					debugGrid.graphics.drawRect(i * Config.CELL_SIZE, j * Config.CELL_SIZE, Config.CELL_SIZE, Config.CELL_SIZE);
				}
			}
			
			SkyAnimationCache.instance.addAnimationFromSprite(head, "head");
			SkyAnimationCache.instance.addAnimationFromSprite(body, "body");
			SkyAnimationCache.instance.addAnimationFromSprite(apple, "apple");
			SkyAnimationCache.instance.addAnimationFromSprite(debugGrid, "grid");
		}
		
		public function update(deltaTime:Number):void
		{
			game.update(deltaTime);
		}
	}
}