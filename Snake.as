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
	
	public class Snake extends RenderObject
	{
		private var body:Vector.<SnakePart>;
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
		 * 1 точка для расчёта позиции предыдущей части змейки.
		 */
		private var prev1:Point;
		
		/**
		 * 2 точка для расчёта позиции предыдущей части змейки.
		 */
		private var prev2:Point;
		
		/**
		 * Проверка на проигрыш.
		 */
		private var isGameOver:Boolean;
		private var position:Point;
		private var head:SnakePart;
		
		/**
		 * Конструктор класса(вызывается при создании класса).
		 */
		public function Snake() 
		{			
			
		}
		
		/**
		 * Функция инициализации игры.
		 */
		public function init():void
		{
			body = new Vector.<SnakePart>();
			position = new Point;
			
			head = new SnakePart();
			head.init();
			head.setPosition(6, 6);
			addChild(head);
			
			/*keyboard = SkyKeyboard.instance;
			
			apple = new SkyClip(); //Создаём клип для отображения яблока.
			apple.setAnimation("apple"); //Даём ему картину, которую он будет отображать.
			apple.x = int((Math.random() * 800) / CELL_SIZE) * CELL_SIZE - CELL_SIZE / 2; //
			apple.y = int((Math.random() * 800) / CELL_SIZE) * CELL_SIZE - CELL_SIZE / 2; //
			addChild(apple); //добавляем на сцену.
			
			snakeHead = new SkyClip();
			snakeHead.setAnimation("head");
			snakeHead.x = HALF_CELL_SIZE + CELL_SIZE * 10;
			snakeHead.y = HALF_CELL_SIZE + CELL_SIZE * 10;
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
			*/
		}
		/**
		 * Фунцкия для обновления тела змейки(расчитывает положение каждой части тела змейки).
		 */
		public function get length():int
		{
			return body.length;
		}
		private function updateBody():void
		{
			var length:int = body.length; //записываем длину массива или количество блоков змейки.
			
			if (length == 0) return; //если длина 0 то ничего не делаем.
			
			prev1.x = body[0].x; //присваиваем 1 точке значение координаты х первого элемента хвоста.
			prev1.y = body[0].y; //присваиваем 1 точке значение координаты у первого элемента хвоста.
			
			body[0].x = prev2.x; //после, предыдущее положение головы по x, присваиваем положению первого элемента хвоста.
			body[0].y = prev2.y; //после, предыдущее положение головы по у, присваиваем положению первого элемента хвоста.
			
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
		public function grownUp():void
		{
			var part: SnakePart = new SnakePart();
			part.init();
			part.setPosition(1, 1);
			addChild(part);
			body.push(part);
		}
		public function getBodyPartPosition(index:int):Point
		{
			return body[index].position;
		}
		/**
		 * Функция для обновления приложения.
		 * @param	deltaTime промежуток времени прошедший с момента обновления кадра.
		 */
		public function moveUp():void 
		{
			if (speedY == 0)
			{
				speedY = -1;
				speedX = 0;
			}
		}
		public function moveDown():void 
		{
			if (speedY == 0)
			{
				speedY = 1;
				speedX = 0;
			}
		}
		public function moveRight():void 
		{
			if (speedX == 0)
			{
				speedY = 0;
				speedX = 1;
			}
		}
		public function moveLeft():void 
		{
			if (speedX == 0)
			{
				speedY = 0;
				speedX = -1;
			}
		}
		public function update():void
		{
			
		}
		
		/**
		 * Функция телепортации змейки.
		 */
		/*private function warp():void
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
		}*/
	}
}