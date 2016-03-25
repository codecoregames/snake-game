package 
{
	import flash.geom.Point;
	import skysand.animation.SkyClip;
	
	public class Apple extends ObjectBase
	{
		public function Apple() 
		{
			super();
		}
		
		public function setRandomPos(snake:Snake):void
		{
			var nx:int = Math.ceil(Config.WINDOW_SIZE_X / Config.CELL_SIZE * Math.random());
			var ny:int = Math.ceil(Config.WINDOW_SIZE_Y / Config.CELL_SIZE * Math.random());
			
			while (!checkFree(nx, ny, snake))
			{
				nx = Math.ceil(Config.WINDOW_SIZE_X / Config.CELL_SIZE * Math.random());
				ny = Math.ceil(Config.WINDOW_SIZE_Y / Config.CELL_SIZE * Math.random());
			}
			
			setPos(nx, ny);
		}
		
		private function checkFree(nx:int, ny:int, snake:Snake):Boolean
		{
			for (var i:int = 0; i < snake.length; i++) 
			{
				var part:SnakePart = snake.getSnakePart(i);
				var point:Point = part.getPos();
				
				if (point.x == nx && point.y == ny)
				{
					return false;
				}
			}
			
			return true;
		}
		
		override public function init():void
		{
			super.init();
			
			sprite = new SkyClip();
			sprite.setAnimation("apple");
			addChild(sprite);
			
			type = Grid.CELL_APPLE;
		}
		
		override public function update(deltaTime:Number):void 
		{
			super.update(deltaTime);
		}
	}
}