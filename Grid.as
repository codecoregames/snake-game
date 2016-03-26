package 
{
	import mx.collections.errors.ItemPendingError;
	import skysand.animation.SkyClip;
	import skysand.render.RenderObject;
	public class Grid  extends RenderObject
	{
		public static const CELL_FREE:uint = 0;
		public static const CELL_APPLE:uint = 1;
		public static const CELL_SNAKE:uint = 2;
		public static const CELL_SIZE:uint = 20;
		public static const HALF_CELL_SIZE:uint = CELL_SIZE / 2;
		
		private var cells:Vector.<uint>;
		private var nCells:int = 0;
		private var gridWidth:int;
		private var counter:int;
		private var sprite:SkyClip;
		
		public function Grid() 
		{
			
		}
		public function initialize(windowSizeX:int, windowSizeY:int, cellSize:int):void
		{
			gridWidth = windowSizeX / cellSize;
			nCells = (windowSizeX / cellSize) * (windowSizeY / cellSize)
			cells = new Vector.<uint>(nCells, true);
			
			for (var i:int = 0; i < nCells; i++) 
			{
				cells[i] = Grid.CELL_FREE;
			}
			sprite = new SkyClip();
			sprite.setAnimation("grid");
		}
		public function getSprite():SkyClip
		{
			return sprite;
		}
		
		public function add(x:int, y:int, clip:SkyClip, type:uint):void
		{
			clip.x = CELL_SIZE * x -HALF_CELL_SIZE;
			clip.y = CELL_SIZE * y -HALF_CELL_SIZE;
			sprite.addChildAt(clip, 0);
			setCell(x, y, type);
		}
		public function setCell(x:int, y:int, value:uint):void
		{
			if (value > 3 || value < 0) return;
			cells[y * gridWidth + x] = value;
		}
		public function getCell(index:uint):uint
		{
			
			index = index < 0 ? 0: index > nCells - 1 ? nCells - 1:index;
			return index[cells];
		}
		public function toString():String
		{			
			var string:String = "";
			
			for (var i:int = 0; i < nCells; i++) 
			{
				counter ++;
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