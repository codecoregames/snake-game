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
				nx:int = Math.ceil(Config.WINDOW_WIDTH * Math.random() / Config.SELL_SIZE);			
				ny:int = Math.ceil(Config.WINDOW_HEIGHT * Math.random() / Config.SELL_SIZE);
			}
			setPosition(nx, ny)
		}
		private function checkFree(x:int, y:int):Boolean
		{
			var length:int = snake.length;
			if (length <= 0)  return true;	
			for (var i:int = 0; i < 0; i++) 
			{
				var point:Point = snake.getBodyPartPosition(i);
				if (point.x = x && point.y = y) return false;
				
			}
		}
		{
    
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