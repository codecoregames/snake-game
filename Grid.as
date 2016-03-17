package 
{
	import skysand.render.RenderObject;
	
	public class Grid extends RenderObject
	{
		/**
		 * Ячейка пуста.
		 */
		public static const CELL_FREE:uint = 0;
		
		/**
		 * В ячейке яблоко.
		 */
		public static const CELL_APPLE:uint = 1;
		
		/**
		 * В ячейке змейка.
		 */
		public static const CELL_SNAKE:uint = 2;
		
		/**
		 * Массив с картой.
		 */
		private var cells:Vector.<uint>;
		
		private var nCells:int;
		
		public function Grid()
		{
			
		}
		
		//000000000000
		//000022200000
		//000020200000
		//001020222000
		//000020002222
		//000022220000
		
		public function initialize():void
		{
			cells = new Vector.<uint>();
			
			nCells = 0;
		}
		
		/**
		 * Задать значение клетке.
		 * @param	index номер клетки.
		 * @param	value значение.
		 */
		public function setCell(index:int, value:uint):void
		{
			if (value > 3 || value < 0) return;
			
			index = index < 0 ? 0 : index > nCells - 1 ? nCells - 1 : index;
			
			cells[index] = value;
		}
		
		/**
		 * Получить значение ячейки.
		 * @param	index номер ячейки.
		 * @return возвращает то, что находиться в данной ячейке.
		 */
		public function getCell(index:int):uint
		{
			index = index < 0 ? 0 : index > nCells - 1 ? nCells - 1 : index;
			
			return cells[index];
		}
	}
}