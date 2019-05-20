package 
{
	public class SnakePart extends ObjectBase
	{
		public function SnakePart() 
		{
			var size:int = Config.CELL_SIZE;
			
			shape.color = Config.SNAKE_COLOR;
			shape.drawRect( -size / 2, -size / 2, size, size);
			addChild(shape);
		}
	}
}