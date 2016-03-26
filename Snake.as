package
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import skysand.animation.SkyClip;
	import skysand.render.RenderObject;
	
	public class Snake extends RenderObject
	{
		private var speedX:int;
		private var speedY:int;
		private var head:SnakePart;
		private var body:Vector.<SnakePart>;
		private var prev1:Point;
		private var prev2:Point;
		private var position:Point;
		public var speed:int;
		
		public function Snake() 
		{
			
		}
		
		public function destroy():void
		{
			removeChild(head);
			head.destroy();
			head = null;
			
			for (var i:int = 0; i < body.length; i++) 
			{
				removeChild(body[i]);
				body[i].destroy();
				body[i] = null;
			}
			
			body.length = 0;
			
			prev1 = null;
			prev2 = null;
			position = null;
		}
		
		/**
		 * Функция инициализации игры.
		 */
		public function init(x:int, y:int, speed:int = 1):void
		{
			this.speed = speed;
			
			body = new Vector.<SnakePart>();
			
			head = new SnakePart();
			head.init();
			head.setPosition(x, y);
			addChild(head);
			
			prev1 = new Point();
			prev2 = new Point();
			
			speedX = 0;
			speedY = 0;
			
			position = new Point(x, y);
		}
		
		public function moveLeft():void
		{
			if (speedX == 0)
			{	
				speedX = -speed;
				speedY = 0;
			}
		}
		
		public function moveRight():void
		{
			if (speedX == 0)
			{	
				speedX = speed;
				speedY = 0;
			}
		}
		
		public function moveUp():void
		{
			if (speedY == 0)
			{
				speedY = -speed;
				speedX = 0;
			}
		}
		
		public function moveDown():void
		{
			if (speedY == 0)
			{
				speedY = speed;
				speedX = 0;
			}
		}
		
		public function grownUp():void
		{
			var p:Point = body.length < 1 ? head.position : body[body.length - 1].position;
			
			var bodyPart:SnakePart = new SnakePart();
			bodyPart.init();
			bodyPart.setPosition(p.x, p.y);
			addChild(bodyPart);
			body.push(bodyPart);
		}
		
		/**
		 * Фунцкия для обновления тела змейки.
		 */
		private function updateBody():void
		{
			var length:int = body.length;
			
			if (length == 0) return;
			
			for (var i:int = 0; i < length; i++) 
			{
				if (i % 2 == 0)
				{
					prev2.copyFrom(body[i].position);
					body[i].setPosition(prev1.x, prev1.y);
				}
				else
				{
					prev1.copyFrom(body[i].position);
					body[i].setPosition(prev2.x, prev2.y);
				}
			}
		}
		
		public function get isAteItself():Boolean
		{
			var length:int = body.length;
			
			for (var i:int = 2; i < length; i++) 
			{
				var point:Point = body[i].position;
				
				if (position.x == point.x && position.y == point.y)
				{
					return true;
				}
			}
			
			return false;
		}
		
		public function get headPosition():Point
		{
			return position;
		}
		
		/**
		 * Функция для обновления приложения.
		 * @param	deltaTime промежуток времени прошедший с момента обновления кадра.
		 */
		public function update(deltaTime:Number):void
		{
			if (speedX != 0 || speedY != 0)
			{
				prev1.setTo(position.x, position.y);
				
				position.x += speedX;
				position.y += speedY;
				
				warp();
				
				head.setPosition(position.x, position.y);
				
				updateBody();
			}
		}
		
		public function getPartPosition(index:int):Point
		{
			return body[index].position;
		}
		
		public function get length():int
		{
			return body.length;
		}
		
		/**
		 * Функция телепортации змейки.
		 */
		private function warp():void
		{
			if (position.x > Config.NCELLS_X)
			{
				position.x = 1;
			}
			
			if (position.x < 1)
			{
				position.x = Config.NCELLS_X;
			}
			
			if (position.y > Config.NCELLS_Y)
			{
				position.y = 1;
			}
			
			if (position.y < 1)
			{
				position.y = Config.NCELLS_Y;
			}
		}
	}
}