package 
{
	import skysand.render.RenderObject;
	
	public class Game extends RenderObject
	{
		private var apple:Apple;
		
		public function Game()
		{
			apple = new Apple();
			apple.init();
			apple.setPosition(4, 5);
			addChild(apple);
		}
		
		public function update():void
		{
			
		}
	}
}