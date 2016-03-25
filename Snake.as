package
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import mx.controls.RichTextEditor__embed_mxml_assets_icon_style_bold_png_1028202784;
	import skysand.animation.SkyAnimationCache;
	import skysand.animation.SkyClip;
	import skysand.interfaces.IUpdatable;
	import skysand.keyboard.SkyKey;
	import skysand.keyboard.SkyKeyboard;
	import skysand.render.RenderObject;
	import skysand.utils.SkyMath;
	
	public class Snake extends RenderObject
	{
		/**
		 * Скорость по x;
		 */
		private var speedX:int;
		
		/**
		 * Скорость по y;
		 */
		private var speedY:int;
		
		/**
		 * Клип для отображения головы змейки.
		 */
		private var head:SnakePart;
		
		/**
		 * Массив с клипами(частями змейки).
		 */
		private var body:Vector.<SnakePart>;
		
		private var prev1:Point;
		
		private var prev2:Point;
		
		private var position:Point;
		
		private var speed:int;
		
		public function Snake() 
		{
			
		}
		
		/**
		 * Функция инициализации игры.
		 */
		public function init(x:int, y:int, speed:int):void
		{
			this.speed = speed;
			
			body = new Vector.<SnakePart>();
			
			head = new SnakePart();
			head.init();
			head.setPos(x, y);
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
			var p:Point = body.length < 1 ? head.getPos() : body[body.length - 1].getPos();
			
			var bodyPart:SnakePart = new SnakePart();
			bodyPart.init();
			bodyPart.setPos(p.x, p.y);
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
			
			prev1.copyFrom(body[0].getPos());
			body[0].setPos(prev2.x, prev2.y);
			
			for (var i:int = 1; i < length; i++) 
			{
				if (i % 2 == 1)
				{
					prev2.copyFrom(body[i].getPos());
					body[i].setPos(prev1.x, prev1.y);
				}
				else
				{
					prev1.copyFrom(body[i].getPos());
					body[i].setPos(prev2.x, prev2.y);
				}
			}
		}
		
		public function get isAteThemself():Boolean
		{
			var length:int = body.length;
			
			for (var i:int = 2; i < length; i++) 
			{
				if (position.x == body[i].x && position.y == body[i].y)
				{
					trace("omnom");
					return true;
				}
			}
			
			return false;
		}
		
		public function get pos():Point
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
				prev2.setTo(position.x, position.y);
				
				position.x += speedX;
				position.y += speedY;
				
				warp();
				
				head.setPos(position.x, position.y);
				
				updateBody();
			}
		}
		
		public function getSnakePart(index:int):SnakePart
		{
			return body[index];
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
			var w:int = Config.WINDOW_SIZE_X / Config.CELL_SIZE;
			
			if (position.x > w)
			{
				position.x = 1;
			}
			
			if (position.x < 1)
			{
				position.x = w;
			}
			
			if (position.y > w)
			{
				position.y = 1;
			}
			
			if (position.y < 1)
			{
				position.y = w;
			}
		}
	}
}