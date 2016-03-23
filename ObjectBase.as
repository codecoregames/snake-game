package 
{
	import skysand.animation.SkyClip;
	import skysand.render.RenderObject;
	
	public class ObjectBase extends RenderObject
	{
		internal var sprite:SkyClip;
		internal var grid:Grid;
		
		public function ObjectBase() 
		{
			
		}
		
		public function init(grid:Grid):void
		{
			this.grid = grid;
		}
		
		public function checkCollision(object:ObjectBase):uint
		{
			return 0;
		}
		
		public function setPos(x:int, y:int):Boolean
		{
			this.x = Config.HALF_CELL_SIZE + x * Config.CELL_SIZE;
			this.y = Config.HALF_CELL_SIZE + y * Config.CELL_SIZE;
			
			return true;
		}
		
		public function update(deltaTime:Number):void
		{
			
		}
	}
}