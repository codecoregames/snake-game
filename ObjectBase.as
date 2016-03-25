package 
{
	import flash.geom.Point;
	import skysand.animation.SkyClip;
	import skysand.render.RenderObject;
	
	public class ObjectBase extends RenderObject
	{
		internal var sprite:SkyClip;
		
		protected var type:uint;
		protected var position:Point;
		
		public function ObjectBase() 
		{
			sprite = null;
			
			type = 0;
			position = null;
		}
		
		public function init():void
		{
			position = new Point(1, 1);
		}
		
		public function setPos(x:int, y:int):Boolean
		{
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