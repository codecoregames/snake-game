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
		 * Половина размера клетки.
		 */
		private const HALF_CELL_SIZE:uint = CELL_SIZE / 2;
		
		/**
		 * Число обновлений за 1 секунду логики в игре.
		 */
		private const NUM_OF_UPDATE:uint = 6;
		
		/**
		 * Класс для работы с клавиатурой.
		 */
		private var keyboard:SkyKeyboard;
		
		/**
		 * Скорость по x;
		 */
		private var speedX:int;
		
		/**
		 * Скорость по y;
		 */
		private var speedY:int;
		
		/**
		 * Счётчик для задержки обновления некоторой логики в игре. 
		 */
		private var delayCounter:int;
		
		/**
		 * Клип для отображения яблока.
		 */
		private var apple:SkyClip;
		
		/**
		 * Клип для отображения головы змейки.
		 */
		private var snakeHead:SkyClip;
		
		/**
		 * Массив с клипами(частями змейки).
		 */
		private var body:Vector.<SkyClip>;
		
		private var prev1:Point;
		
		private var prev2:Point;
		
		private var isGameOver:Boolean;
		
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
			keyboard = SkyKeyboard.instance;
			
			apple = new SkyClip();
			apple.setAnimation("apple");
			apple.x = int((Math.random() * 800) / CELL_SIZE) * CELL_SIZE - CELL_SIZE / 2;
			apple.y = int((Math.random() * 800) / CELL_SIZE) * CELL_SIZE - CELL_SIZE / 2;
			addChild(apple);
			
			snakeHead = new SkyClip();
			snakeHead.setAnimation("head");
			snakeHead.x = CELL_SIZE * 0.5 + CELL_SIZE * 10;
			snakeHead.y = CELL_SIZE * 0.5 + CELL_SIZE * 10;
			addChild(snakeHead);
			
			var grid:SkyClip = new SkyClip();
			grid.setAnimation("grid");
			addChild(grid);
			
			body = new Vector.<SkyClip>();
			
			prev1 = new Point();
			prev2 = new Point();
			
			delayCounter = 0;
			speedX = 0;
			speedY = 0;
			isGameOver = false;
		}
		
		/**
		 * Подготовить графику для использования в игре.
		 */
		private function prepareGraphics():void
		{
			var head:Sprite = new Sprite();	//cоздаём спрайт с именем head.
			head.graphics.beginFill(0xC82286); //c помощью методов graphics задаём цвет, вызывая функцию beginFill.
			head.graphics.drawRect( -CELL_SIZE / 2, -CELL_SIZE / 2, CELL_SIZE, CELL_SIZE); //с помощью функции drawRect рисуем квадрат со сторонами CELL_SIZE.
			
			//head.graphics.drawRect(0, 0, CELL_SIZE, CELL_SIZE); если написать так, то центр по умолчанию будет в левом верхнем углу.
			//первым двум координатам мы указываем то, где будет центр у фигуры.
			//(0, 0) - левый верхний
			//(-CELL_SIZE, -CELL_SIZE) - правый нижний.
			//(-CELL_SIZE / 2, -CELL_SIZE / 2) - центр.
			
			var body:Sprite = new Sprite();
			body.graphics.beginFill(0xE0549A);
			body.graphics.drawRect( -CELL_SIZE / 2, -CELL_SIZE / 2, CELL_SIZE, CELL_SIZE);
			
			var apple:Sprite = new Sprite();
			apple.graphics.beginFill(0x18D187);
			apple.graphics.drawRect( -CELL_SIZE / 2, -CELL_SIZE / 2, CELL_SIZE, CELL_SIZE);
			
			var debugGrid:Sprite = new Sprite();
			debugGrid.graphics.lineStyle(1, 0xDF0652, 0.5); //задаём отрисовку квадратов линиями(толщина, цвет линии, прозрачность).
			
			var nCells:int = int(800 / CELL_SIZE); //получаем количество клеток на экране.
			
			for (var i:int = 0; i < nCells; i++) 
			{
				for (var j:int = 0; j < nCells; j++) 
				{
					debugGrid.graphics.drawRect(i * CELL_SIZE, j * CELL_SIZE, CELL_SIZE, CELL_SIZE);
				}
			}
			
			//Добавляем полученные фигуры в хранилище SkyAnimationCache. 1 параметр - что нужно сохранить, 2 параметр - имя сохраняемой картинки\анимации.
			SkyAnimationCache.instance.addAnimationFromSprite(head, "head");
			SkyAnimationCache.instance.addAnimationFromSprite(body, "body");
			SkyAnimationCache.instance.addAnimationFromSprite(apple, "apple");
			SkyAnimationCache.instance.addAnimationFromSprite(debugGrid, "grid");
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
				isGameOver = false;
			}
			
			if (keyboard.isPressed(SkyKey.LEFT))
			{
				if (speedX == 0) speedX = -CELL_SIZE;
				speedY = 0;
			}
			
			if (keyboard.isPressed(SkyKey.RIGHT))
			{
				if (speedX == 0) speedX = CELL_SIZE;
				speedY = 0;
			}
			
			if (keyboard.isPressed(SkyKey.UP))
			{
				if (speedY == 0) speedY = -CELL_SIZE;
				speedX = 0;
			}
			
			if (keyboard.isPressed(SkyKey.DOWN))
			{
				if (speedY == 0) speedY = CELL_SIZE;
				speedX = 0;
			}
			
			delayCounter++;
			
			if (delayCounter >= 60 / NUM_OF_UPDATE)
			{
				prev2.setTo(snakeHead.x, snakeHead.y);
				
				snakeHead.x += speedX;
				snakeHead.y += speedY;
				
				if (!isGameOver) updateBody();
				
				delayCounter = 0;
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
					isGameOver = true;
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