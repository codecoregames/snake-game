package 
{
	import flash.geom.Point;
	import skysand.render.RenderObject;
	
	public class Snake extends RenderObject
	{
		private var body:Vector.<SnakePart>;
		private var speedX:int;
		private var speedY:int;
		private var position:Point;
		private var head:SnakePart;
		
		public function Snake() 
		{
			
		}
		
		public function init():void
		{
			body = new Vector.<SnakePart>();
			position = new Point();
			
			head = new SnakePart();
			head.init();
			head.setPosition(6, 6);
			addChild(head);
		}
		
		public function grownUp():void
		{
			var part:SnakePart = new SnakePart();
			part.init();
			part.setPosition(1, 1);
			addChild(part);
			body.push(part);
		}
		
		public function moveUp():void
		{
			if (speedX == 0)
			{
				speedY = -1;
				speedX = 0;
			}
		}
		
		public function moveDown():void
		{
			if (speedX == 0)
			{
				speedY = 1;
				speedX = 0;
			}
		}
		
		public function moveLeft():void
		{
			if (speedY == 0)
			{
				speedX = -1;
				speedY = 0;
			}
		}
		
		public function moveRight():void
		{
			if (speedY == 0)
			{
				speedX = 1;
				speedY = 0;
			}
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
			position.x += speedX;
			position.y += speedY;
		}
	}
}