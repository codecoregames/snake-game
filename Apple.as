package 
{
	import adobe.utils.CustomActions;
	import flash.geom.Point;
	public class Apple extends ObjectBase
	{
		private var snake:Snake;
		public function Apple() 
		{
			super();
		}
		public function setRandomPosition():void
		{
			var nx:int = Math.ceil(Config.WINDOW_WIDTH * Math.random() / Config.SELL_SIZE);
			var ny:int = Math.ceil(Config.WINDOW_HEIGHT * Math.random() / Config.SELL_SIZE);
			while (!checkFree(nx, ny))
			{
				nx = Math.ceil(Config.WINDOW_WIDTH * Math.random() / Config.SELL_SIZE);			
				ny = Math.ceil(Config.WINDOW_HEIGHT * Math.random() / Config.SELL_SIZE);
			}
			setPosition(nx, ny);
		}
		private function checkFree(x:int, y:int):Boolean
		{
			if (snake == null) return true;
			var length:int = snake.length;
			if (length <= 0)  return true;	
			for (var i:int = 0; i < length; i++) 
			{
				var point:Point = snake.getBodyPartPosition(i);
				if (point.x == x && point.y == y) return false;
				
			}
			return true;
		}
		
    
		public function setCurrentSnake(snake:Snake):void
		{
			this.snake = snake
		}
		override public function init():void 
		{
			super.init();
			sprite.setAnimation ("apple");
		}
	}
}