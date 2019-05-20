package 
{
	import flash.geom.Point;
	import skysand.display.SkyRenderObjectContainer;
	import skysand.display.SkyShape;
	
	public class ObjectBase extends SkyRenderObjectContainer
	{
		protected var shape:SkyShape;
		protected var mPosition:Point;
		
		public function ObjectBase() 
		{
			mPosition = new Point(1, 1);
			shape = new SkyShape();
		}
		
		public function setPosition(x:int, y:int):void
		{
			mPosition.x = x;
			mPosition.y = y;
			
			this.x = x * Config.CELL_SIZE - Config.HALF_CELL_SIZE;
			this.y = y * Config.CELL_SIZE - Config.HALF_CELL_SIZE;
		}
		
		public function destroy():void
		{
			removeChild(shape);
			shape.free();
			shape = null;
			mPosition = null;
		}
		
		public function get position():Point
		{
			return mPosition;
		}
	}
}