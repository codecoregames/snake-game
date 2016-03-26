package 
{
	import flash.display.Sprite;
	import skysand.animation.SkyAnimationCache;
	import skysand.components.SkyButton;
	import skysand.interfaces.IUpdatable;
	import skysand.render.RenderObject;
	
	public class App extends RenderObject implements IUpdatable
	{
		private var game:Game;
		private var button:SkyButton;
		private var isInit:Boolean = false;
		
		public function App() 
		{
			prepareGraphics();
			
			game = new Game();
			addChild(game);
			
			button = new SkyButton();
			button.createSimpleButton(0x2F84D0, 100, 40, play, 1, "play");
			button.x = Config.WINDOW_SIZE_X * 0.5 - button.width / 2;
			button.y = Config.WINDOW_SIZE_Y * 0.5 - button.height / 2;
			addChild(button);
		}
		
		private function play():void
		{
			game.initialize();
			isInit = true;
			
			button.visible = false;
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
			
			if (game.gameover && isInit)
			{
				game.destroy();
				button.visible = true;
				isInit = false;
			}
		}
	}
}