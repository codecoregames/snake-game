package 
{
	import flash.geom.Point;
	import skysand.animation.SkyClip;
	import skysand.render.RenderObject;
	
	public class ObjectBase extends RenderObject
	{
		protected var sprite:SkyClip;
		protected var _position:Point;
		
		public function ObjectBase() 
		{
			sprite = null;
			_position = null;
		}
		
		public function init():void
		{
			_position = new Point(1, 1);
			sprite = new SkyClip();
			addChild(sprite);
		}
		
		public function setPosition(x:int, y:int):void
		{
			_position.x = x;
			_position.y = y;
			
			this.x = x * Config.CELL_SIZE - Config.HALF_CELL_SIZE;
			this.y = y * Config.CELL_SIZE - Config.HALF_CELL_SIZE;
		}
		
		public function destroy():void
		{
			if (contains(sprite)) removeChild(sprite);
			
			sprite.free();
			sprite = null;
			_position = null;
		}
		
		public function get position():Point
		{
			return _position;
		}
	}
}