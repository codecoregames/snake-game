package
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import skysand.animation.SkyAnimationCache;
	import skysand.animation.SkyClip;
	import skysand.interfaces.IUpdatable;
	import skysand.keyboard.SkyKey;
	import skysand.keyboard.SkyKeyboard;
	import skysand.render.RenderObject;
	
	public class Snake extends RenderObject implements IUpdatable
	{
		/**
		 * Размер клетки.
		 */
		private const CELL_SIZE:uint = 50;
		
		/**
		 * Голова змеи(экземпляр класса).
		 */
		private var snakeHead:SkyClip;
		
		/**
		 * Класс для работы с клавиатурой.
		 */
		private var keyboard:SkyKeyboard;
		
		/**
		 * Скорость змейки = количеству клеток за кадр.
		 */
		private const SPEED:uint = 1;
		
		/**
		 * Скорость по x;
		 */
		private var speedX:int;
		
		/**
		 * Скорость по y;
		 */
		private var speedY:int;
		
		/**
		 * Счётчик для задержки расчёта смещения змейки. 
		 */
		private var delayCount:int;
		
		private var apple:SkyClip;
		
		private var body:Vector.<SkyClip>;
		
		private var prev1:Point;
		private var prev2:Point;
		private var isHit:Boolean = false;
		
		/**
		 * Конструктор класса(вызывается при создании класса).
		 */
		public function Snake() 
		{
			prepareGraphics();
			
			init();
		}
		
		/**
		 * Функция инициализации игры.
		 */
		private function init():void
		{
			speedX = 0;
			speedY = 0;
			delayCount = 0;
			
			keyboard = SkyKeyboard.instance;
			
			apple = new SkyClip();
			apple.setAnimation("apple");
			apple.x = int((Math.random() * 800 - CELL_SIZE) / CELL_SIZE) * CELL_SIZE - CELL_SIZE / 2;
			apple.y = int((Math.random() * 800 - CELL_SIZE) / CELL_SIZE) * CELL_SIZE - CELL_SIZE / 2;
			addChild(apple);
			
			snakeHead = new SkyClip();
			snakeHead.setAnimation("head");
			snakeHead.x = CELL_SIZE * 0.5 + CELL_SIZE * 10;
			snakeHead.y = CELL_SIZE * 0.5 + CELL_SIZE * 10;
			addChild(snakeHead);
			
			body = new Vector.<SkyClip>();
			
			prev1 = new Point();
			prev2 = new Point();
		}
		
		/**
		 * Подготовить графику.
		 */
		private function prepareGraphics():void
		{
			var head:Sprite = new Sprite();
			head.graphics.beginFill(0xC82286);
			head.graphics.drawRect( -CELL_SIZE / 2, -CELL_SIZE / 2, CELL_SIZE, CELL_SIZE);
			
			SkyAnimationCache.instance.addAnimationFromSprite(head, "head");
			
			var body:Sprite = new Sprite();
			body.graphics.beginFill(0xE0549A);
			body.graphics.drawRect( -CELL_SIZE / 2, -CELL_SIZE / 2, CELL_SIZE, CELL_SIZE);
			
			SkyAnimationCache.instance.addAnimationFromSprite(body, "body");
			
			var apple:Sprite = new Sprite();
			apple.graphics.beginFill(0x18D187);
			apple.graphics.drawRect( -CELL_SIZE / 2, -CELL_SIZE / 2, CELL_SIZE, CELL_SIZE);
			
			SkyAnimationCache.instance.addAnimationFromSprite(apple, "apple");
		}
		
		/**
		 * Фунцкия для обновления тела змейки.
		 */
		private function updateBody():void
		{
			var length:int = body.length;
			
			if (length == 0) return;
			
			prev1.x = body[0].x;
			prev1.y = body[0].y;
			
			body[0].x = prev2.x;
			body[0].y = prev2.y;
			
			for (var i:int = 1; i < length; i++) 
			{
				if (i % 2 == 1)
				{
					prev2.x = body[i].x;
					prev2.y = body[i].y;
					body[i].x = prev1.x;
					body[i].y = prev1.y;
				}
				else
				{
					prev1.x = body[i].x;
					prev1.y = body[i].y;
					body[i].x = prev2.x;
					body[i].y = prev2.y;
				}
			}
		}
		
		/**
		 * Функция для обновления приложения.
		 * @param	deltaTime промежуток времени прошедший с момента обновления кадра.
		 */
		public function update(deltaTime:Number):void
		{
			if (keyboard.anyKeyDown)
			{
				isHit = false;
			}
			
			if (keyboard.isPressed(SkyKey.LEFT))
			{
				if (speedX == 0) speedX = -SPEED * CELL_SIZE;
				speedY = 0;
			}
			
			if (keyboard.isPressed(SkyKey.RIGHT))
			{
				if (speedX == 0) speedX = SPEED * CELL_SIZE;
				speedY = 0;
			}
			
			if (keyboard.isPressed(SkyKey.UP))
			{
				if (speedY == 0) speedY = -SPEED * CELL_SIZE;
				speedX = 0;
			}
			
			if (keyboard.isPressed(SkyKey.DOWN))
			{
				if (speedY == 0) speedY = SPEED * CELL_SIZE;
				speedX = 0;
			}
			
			delayCount++;
			
			if (delayCount >= 10)
			{
				prev2.setTo(snakeHead.x, snakeHead.y);
				
				snakeHead.x += speedX;
				snakeHead.y += speedY;
				
				if(!isHit) updateBody();
				
				delayCount = 0;
			}
			
			if (apple.hitTestObject(snakeHead))
			{
				apple.x = int((Math.random() * 800) / CELL_SIZE) * CELL_SIZE - CELL_SIZE / 2;
				apple.y = int((Math.random() * 800) / CELL_SIZE) * CELL_SIZE - CELL_SIZE / 2;
				
				var bodyPart:SkyClip = new SkyClip();
				bodyPart.setAnimation("body");
				bodyPart.x = body.length - 1 > 0 ? body[body.length - 1].x : prev2.x;
				bodyPart.y = body.length - 1 > 0 ? body[body.length - 1].y : prev2.y;
				addChild(bodyPart);
				body.push(bodyPart);
			}
			
			for (var i:int = 0; i < body.length; i++) 
			{
				if (body[i].hitTestObject(snakeHead))
				{
					speedX = 0;
					speedY = 0;
					isHit = true;
				}
			}
			
			warp();
		}
		
		/**
		 * Функция телепортации змейки.
		 */
		private function warp():void
		{
			if (snakeHead.x > 800 - CELL_SIZE / 2)
			{
				snakeHead.x = CELL_SIZE / 2;
			}
			
			if (snakeHead.x < -CELL_SIZE / 2)
			{
				snakeHead.x = 800 - CELL_SIZE / 2;
			}
			
			if (snakeHead.y > 800 - CELL_SIZE / 2)
			{
				snakeHead.y = CELL_SIZE / 2;
			}
			
			if (snakeHead.y < -CELL_SIZE / 2)
			{
				snakeHead.y = 800 - CELL_SIZE / 2;
			}
		}
	}
}