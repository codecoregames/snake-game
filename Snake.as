package 
{
	import flash.geom.Point;
	import skysand.render.RenderObject;
	
	public class Snake extends RenderObject
	{
		private var body:Vector.<SnakePart>;
		
		public function Snake() 
		{
			
		}
		
		public function init():void
		{
			body = new Vector.<SnakePart>();
			
			
		}
		
		public function grownUp():void
		{
			var part:SnakePart = new SnakePart();
			part.init();
			part.setPosition(1, 1);
			addChild(part);
			body.push(part);
		}
		
		public function getBodyPartPosition(index:int):Point
		{
			return body[index].position;
		}
		
		public function get length():int
		{
			return body.length;
		}
		
		public function update():void
		{
			
		}
	}
}