package 
{
	import skysand.render.RenderObject;
	
	public class Game extends RenderObject
	{
		public function Game()
		{
			var apple:Apple = new Apple();
			apple.init();
			apple.setPosition(4, 5);
			addChild(apple);
		}
		
		public function update():void
		{
			
		}
	}
}