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
			
			SkyAnimationCache.instance.addAnimationFromSprite(head, "head");
			SkyAnimationCache.instance.addAnimationFromSprite(body, "body");
			SkyAnimationCache.instance.addAnimationFromSprite(apple, "apple");
		}
		
		public function update(deltaTime:Number):void
		{
			game.update(deltaTime);
		}
	}
}