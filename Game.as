package
{
	import flash.display.Sprite;
	import skysand.animation.SkyAnimationCache;
	import skysand.animation.SkyClip;
	import skysand.console.Console;
	import skysand.interfaces.IUpdatable;
	import skysand.keyboard.SkyKey;
	import skysand.keyboard.SkyKeyboard;
	import skysand.render.RenderObject;
	import skysand.utils.SkyVector2D;
	
	public class Game extends RenderObject
	{
		private const CELL_SIZE:uint = 50;
		private const MAX_SPEED:uint = 50;
		
		private var speed:SkyVector2D;
		private var grid:SkyClip;
		private var snakeHead:SkyClip;
		private var keyboard:SkyKeyboard;
		private var delay:int = 0;
		private var snakeBody:Vector.<SkyClip>;
		private var prev:SkyVector2D = new SkyVector2D();
		//private var body:BodyPartData;
		private var apple:SkyClip;
		private var nParts:int = 0;
		
		private var apple:Apple;
		private var snake:Snake;
		
		public function Game()
		{
			//initialize();
			snake = new Snake();
			snake.init();
			addChild(snake);
			apple= new Apple();
			apple.init();
			apple.setPosition(4, 5);
			
			addChild(apple);
			
		}
		
		private function initialize():void
		{
			prepareGraphics();
			
			keyboard = SkyKeyboard.instance;
			
			Console.instance.registerCommand("debug", debug, []);
			
			apple = new SkyClip();
			apple.setAnimation("apple");
			apple.x = int(int(Math.random() * 800) / CELL_SIZE) * CELL_SIZE + CELL_SIZE * 0.5;
			apple.y = int(int(Math.random() * 800) / CELL_SIZE) * CELL_SIZE + CELL_SIZE * 0.5;
			addChild(apple);
			
			snakeHead = new SkyClip();
			snakeHead.setAnimation("rectangle");
			snakeHead.x = CELL_SIZE * 0.5 + CELL_SIZE * 10;
			snakeHead.y = CELL_SIZE * 0.5 + CELL_SIZE * 10;
			addChild(snakeHead);
			
			snakeBody = new Vector.<SkyClip>();
			//body = new BodyPartData();
			
			for (var i:int = 0; i < 10; i++) 
			{
				var bodyPart:SkyClip = new SkyClip();
				bodyPart.setAnimation("rectangle");
				bodyPart.x = snakeHead.x + snakeHead.width * i;
				bodyPart.y = snakeHead.y;
				//bodyPart.visible = false;
				addChild(bodyPart);
				snakeBody.push(bodyPart);
			}
			
			grid = new SkyClip();
			grid.setAnimation("grid");
			addChild(grid);
			
			speed = new SkyVector2D();
		}
		
		private function prepareGraphics():void
		{
			var gridSprite:Sprite = new Sprite();
			gridSprite.graphics.lineStyle(1, 0x1BA5E0);
			
			var count:int = 800 / CELL_SIZE;
			
			for (var i:int = 0; i < count; i++) 
			{
				for (var j:int = 0; j < count; j++) 
				{
					gridSprite.graphics.drawRect(CELL_SIZE * i, CELL_SIZE * j, CELL_SIZE, CELL_SIZE);
				}
			}
			
			var rect:Sprite = new Sprite();
			rect.graphics.beginFill(0xAF0A82);
			rect.graphics.drawRect( -CELL_SIZE / 2, -CELL_SIZE / 2, CELL_SIZE, CELL_SIZE);
			
			var apple:Sprite = new Sprite();
			apple.graphics.beginFill(0x3FCF7C);
			apple.graphics.drawRect( -CELL_SIZE / 2, -CELL_SIZE / 2, CELL_SIZE, CELL_SIZE);
			
			SkyAnimationCache.instance.addAnimationFromSprite(gridSprite, "grid");
			SkyAnimationCache.instance.addAnimationFromSprite(rect, "rectangle");
			SkyAnimationCache.instance.addAnimationFromSprite(apple, "apple");
		}
		
		private function debug(value:String):void
		{
			if (value == "on")
			{
				grid.visible = true;
			}
			else
			{
				grid.visible = false;
			}
		}
		
		private var p:SkyVector2D = new SkyVector2D();
		
		private function updateSnakeBody():void
		{
			p.x = snakeBody[0].x;
			p.y = snakeBody[0].y;
			
			snakeBody[0].x = prev.x;
			snakeBody[0].y = prev.y;
			
			var length:int = snakeBody.length;
			
			for (var i:int = 1; i < length; i++) 
			{
				if (i % 2 == 1)
				{
					prev.x = snakeBody[i].x;
					prev.y = snakeBody[i].y;
					snakeBody[i].x = p.x;
					snakeBody[i].y = p.y;
				}
				else
				{
					p.x = snakeBody[i].x;
					p.y = snakeBody[i].y;
					snakeBody[i].x = prev.x;
					snakeBody[i].y = prev.y;
				}
			}
		}
		
		public function update():void
		{
			delay++;
			
			if (delay == 10)
			{
				prev.setTo(snakeHead.x, snakeHead.y);
				
				snakeHead.x += speed.x;
				snakeHead.y += speed.y;
				
				updateSnakeBody();
				
				delay = 0;
			}
			
			if (apple.hitTestObject(snakeHead))
			{
				apple.x = int(int(Math.random() * 800) / CELL_SIZE) * CELL_SIZE + CELL_SIZE * 0.5;
				apple.y = int(int(Math.random() * 800) / CELL_SIZE) * CELL_SIZE + CELL_SIZE * 0.5;
				
				var bodyPart:SkyClip = new SkyClip();
				bodyPart.setAnimation("rectangle");
				//bodyPart.x = snakeHead.x + snakeHead.width;
				//bodyPart.y = snakeHead.y;
				addChildAt(bodyPart, 0);
				snakeBody.push(bodyPart);
			}
			
			if (keyboard.isPressed(SkyKey.LEFT))
			{
				if (speed.x == 0) speed.setTo( -MAX_SPEED, 0);
			}
			
			if (keyboard.isPressed(SkyKey.RIGHT))
			{
				if (speed.x == 0) speed.setTo(MAX_SPEED, 0);
			}
			
			if (keyboard.isPressed(SkyKey.UP))
			{
				if (speed.y == 0) speed.setTo(0, -MAX_SPEED);
			}
			
			if (keyboard.isPressed(SkyKey.DOWN))
			{
				if (speed.y == 0) speed.setTo(0, MAX_SPEED);
			}
		}
	}
}