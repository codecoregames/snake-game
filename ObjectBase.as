package 
{
	import flash.geom.Point;
	import skysand.animation.SkyClip;
	import skysand.render.RenderObject;
	
	public class ObjectBase extends RenderObject
	{
		protected var _position:Point;
		protected var sprite:SkyClip;
		public function init():void
		{
			_position = new Point();
			sprite = new SkyClip();
			addChild(sprite);
		}
		
		public function ObjectBase() 
		{
			
		}
		public function destroy():void
		{
			removeChild(sprite);
			sprite.free();
			sprite = null;
			_position = null;
			
		}
		public function setPosition(x:int, y:int):void
		{
			_position.setTo(x, y);
			this.x = x * Config.SELL_SIZE - Config.HALF_SELL_SIZE;
			this.y = y * Config.SELL_SIZE - Config.HALF_SELL_SIZE;
		}
		public function get position():Point
		{
			return _position;
		}
	}

}