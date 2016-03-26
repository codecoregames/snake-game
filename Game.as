package 
{
	import skysand.render.RenderObject;
	
	public class Game extends RenderObject
	{
		private var apple:Apple;
		private var snake:Snake;
		
		public function Game()
		{
			snake = new Snake();
			snake.init();
			addChild(snake);
			
			apple = new Apple();
			apple.init();
			apple.setPosition(4, 5);
			apple.setCurrentSnake(snake);
			addChild(apple);
		}
		
		public function update():void
		{
			apple.setRandomPosition();
			
			/*
			*/
		}
	}
}