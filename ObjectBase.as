package 
{
	import flash.geom.Point;
	import skysand.animation.SkyClip;
	import skysand.render.RenderObject;
	
	public class ObjectBase extends RenderObject
	{
		internal var sprite:SkyClip;
		internal var grid:Grid;
		
		protected var prev:Point;
		protected var type:uint;
		protected var position:Point;
		
		public function ObjectBase() 
		{
			sprite = null;
			grid = null;
			prev = null;
			type = 0;
			position = null;
		}
		
		public function init(grid:Grid):void
		{
			prev = new Point(1, 1);
			position = new Point(1, 1);
			
			this.grid = grid;
		}
		
		public function setPos(x:int, y:int):Boolean
		{
			if (x == 0) x = 1;
			if (y == 0) y = 1;
			
			if (grid.getCell(x, y) != Grid.CELL_FREE) return false;
			
			grid.setCell(prev.x, prev.y, Grid.CELL_FREE);
			grid.setCell(x, y, Grid.CELL_APPLE);
			
			prev.x = x;
			prev.y = y;
			position.x = x;
			position.y = y;
			
			this.x = x * Config.CELL_SIZE - Config.HALF_CELL_SIZE;
			this.y = y * Config.CELL_SIZE - Config.HALF_CELL_SIZE;
			
			return true;
		}
		
		public function getPos():Point
		{
			return position;
		}
		
		public function update(deltaTime:Number):void
		{
			
		}
	}
}