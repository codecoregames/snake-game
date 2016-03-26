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
			prepareGrafics();
			game = new Game();
			addChild(game);
		}
		public function update(deltaTime:Number):void
		{
			
		}
		public function prepareGrafics():void
		{
			createShape (0x00FF80, "rectangle", "snakePart");
			createShape (0xFF8080, "rectangle", "apple");
		}
		public function createShape(color:uint, shape:String, name:String):void
		{
			var sprite:Sprite = new Sprite ;
			sprite.graphics.beginFill(color);
			switch(shape)
			{
				case "rectangle":
				{
					sprite.graphics.drawRect( -Config.HALF_SELL_SIZE, -Config.HALF_SELL_SIZE, Config.SELL_SIZE, Config.SELL_SIZE);
					break;
				}
				case "cirle":
				{
					sprite.graphics.drawCircle(0,0, Config.SELL_SIZE);
					break;
				}
			}
			SkyAnimationCache.instance.addAnimationFromSprite(sprite, name);
			
		}
		
	}

}