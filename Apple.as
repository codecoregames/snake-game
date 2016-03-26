package 
{
	
	public class Apple extends ObjectBase
	{
		private var snake:Snake;
		
		public function Apple() 
		{
			super();
		}
		
		public function setRandomPosition():void
		{
			var nx:int = Math.ceil(Config.WINDOW_WIDTH * Math.random / Config.CELL_SIZE);
			var ny:int = Math.ceil(Config.WINDOW_HEIGHT * Math.random / Config.CELL_SIZE);
		}
		
		public function setCurrentSnake(snake:Snake):void
		{
			this.snake = snake;
		}
		/*
		private function checkFree(x:int, y:int):Boolean
		{
			for (var i:int = 0; i <0 ; i++)
			{
				
			}
		}*/
		
		override public function init():void
		{
			super.init();
			sprite.setAnimation("apple");
		}
	}

}