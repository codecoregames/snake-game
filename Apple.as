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
		
		public function setSnake(snake:Snake):void
		{
			this.snake = snake;
		}
		
		public function setRandomPosition():void
		{
			var nx:int = Math.ceil(Config.NCELLS_X * Math.random());
			var ny:int = Math.ceil(Config.NCELLS_Y * Math.random());
			//trace(isCellFree(nx, ny));
			var isBusy:Boolean = isCellFree(nx, ny);
			
			while (isBusy)
			{
				nx = Math.ceil(Config.NCELLS_X * Math.random());
				ny = Math.ceil(Config.NCELLS_Y * Math.random());
				
				if (isCellFree(nx, ny))
					isBusy = false;
			}
			
			setPosition(nx, ny);
		}
		
		private function isCellFree(nx:int, ny:int):Boolean
		{
			for (var i:int = 0; i < snake.length; i++) 
			{
				var point:Point = snake.getPartPosition(i);
				
				if (point.x != nx && point.y != ny)
				{
					return true;
				}
			}
			
			return false;
		}
		
		override public function destroy():void 
		{
			super.destroy();
			
			snake = null;
		}
		
		override public function init():void
		{
			super.init();
			
			var size:Number = Config.CELL_SIZE;
			
			shape.color = Config.APPLE_COLOR;
			shape.drawRect( -size / 2, -size / 2, size, size);
			addChild(shape);
		}
	}
}