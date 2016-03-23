package 
{
	import flash.display.Sprite;
	import skysand.animation.SkyClip;
	import skysand.render.RenderObject;
	import skysand.animation.SkyAnimationCache;
	
	public class Grid extends RenderObject
	{
		public static const CELL_FREE:uint = 0;
		public static const CELL_APPLE:uint = 1;
		public static const CELL_SNAKE:uint = 2;
		
		/**
		 * Массив с картой.
		 */
		private var cells:Vector.<uint>;
		
		private var nCells:int;
		
		private var gridWidth:int;
		
		private var counter:int;
		
		private var grid:SkyClip;
		
		public function Grid()
		{
			
		}
		
		public function initialize(windowSizeX:int, windowSizeY:int, cellSize:int):void
		{
			gridWidth = windowSizeX / cellSize;
			nCells = (windowSizeX / cellSize) * (windowSizeY / cellSize);
			counter = 0;
			
			cells = new Vector.<uint>(nCells, true);
			
			for (var i:int = 0; i < nCells; i++) 
			{
				cells[i] = CELL_FREE;
			}
			
			var debugGrid:Sprite = new Sprite();
			debugGrid.graphics.lineStyle(1, 0xDF0652);
			
			for (i = 0; i < windowSizeX / cellSize; i++) 
			{
				for (var j:int = 0; j < windowSizeY / cellSize; j++) 
				{
					debugGrid.graphics.drawRect(i * cellSize, j * cellSize, cellSize, cellSize);
				}
			}
			
			SkyAnimationCache.instance.addAnimationFromSprite(debugGrid, "grid");
			
			grid = new SkyClip();
			grid.setAnimation("grid");
			addChild(grid);
		}
		
		/**
		 * Задать значение клетке.
		 * @param	index номер клетки.
		 * @param	value значение.
		 */
		public function setCell(x:int, y:int, value:uint):void
		{
			if (value > 3 || value < 0) return;
			
			cells[(y - 1) * gridWidth + (x - 1)] = value;
		}
		
		/**
		 * Получить значение ячейки.
		 * @param	index номер ячейки.
		 * @return возвращает то, что находиться в данной ячейке.
		 */
		public function getCell(x:int, y:int):uint
		{
			return cells[(y - 1) * gridWidth + (x - 1)];
		}
		
		public function get gwidth():int
		{
			return gridWidth;
		}
		
		public function toString():String
		{
			var string:String = "";
			
			for (var i:int = 0; i < nCells; i++) 
			{
				counter++;
				
				string += cells[i];
				
				if (counter == gridWidth)
				{
					string += "\n";
					counter = 0;
				}
			}
			
			return string;
		}
	}
}