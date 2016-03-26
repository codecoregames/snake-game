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
			createShape(0xD7289A, "rectangle", "snakePart");
			createShape(0x2DCE75, "rectangle", "apple");
		}
		
		private function createShape(color:uint, shape:String, name:String):void
		{
			var sprite:Sprite = new Sprite();
			sprite.graphics.beginFill(color);
			
			switch(shape)
			{
				case "rectangle":
					{
						sprite.graphics.drawRect( -Config.HALF_CELL_SIZE, -Config.HALF_CELL_SIZE, Config.CELL_SIZE, Config.CELL_SIZE);
						break;
					}
				case "circle":
					{
						sprite.graphics.drawCircle(0, 0, Config.HALF_CELL_SIZE);
						break;
					}
			}
			
			SkyAnimationCache.instance.addAnimationFromSprite(sprite, name);
		}
		
		public function update(deltaTime:Number):void
		{
			game.update();
		}
	}
}