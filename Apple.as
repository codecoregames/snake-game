package 
{
	import flash.geom.Point;
	
	public class Apple extends ObjectBase
	{
		private var snake:Snake;
		
		public function Apple() 
		{
			super();
		}
		
		public function setCurrentSnake(snake:Snake):void
		{
			this.snake = snake;
			
			trace(snake==null);
		}
		
		public function setRandomPosition():void
		{
			var nx:int = Math.ceil(Config.NCELLS_X * Math.random());
			var ny:int = Math.ceil(Config.NCELLS_Y * Math.random());
			
			while (!checkFree(nx, ny))
			{
				nx = Math.ceil(Config.NCELLS_X * Math.random());
				ny = Math.ceil(Config.NCELLS_Y * Math.random());
			}
			
			setPosition(nx, ny);
		}
		
		private function checkFree(nx:int, ny:int):Boolean
		{
			if (snake == null) return false;
			
			for (var i:int = 0; i < snake.length; i++) 
			{
				var point:Point = snake.getPartPosition(i);
				
				if (point.x == nx && point.y == ny)
				{
					return false;
				}
			}
			
			return true;
		}
		
		override public function destroy():void 
		{
			super.destroy();
			
			snake = null;
		}
		
		override public function init():void
		{
			super.init();
			
			sprite.setAnimation("apple");
		}
	}
}