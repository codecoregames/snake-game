package 
{
	import skysand.animation.SkyClip;
	
	public class Apple extends ObjectBase
	{
		public function Apple() 
		{
			sprite = null;
			grid = null;
			prev = null;
			type = 0;
		}
		
		public function setRandomPos():void
		{
			var nx:int = Math.ceil(grid.gwidth * Math.random());
			var ny:int = Math.ceil(grid.gwidth * Math.random());
			
			var inPos:Boolean = setPos(nx, ny);
			
			while (!inPos)
			{
				nx = int(grid.gwidth * Math.random());
				ny = int(grid.gwidth * Math.random());
				
				inPos = setPos(nx, ny);
			}
		}
		
		override public function init(grid:Grid):void
		{
			super.init(grid);
			
			sprite = new SkyClip();
			sprite.setAnimation("apple");
			addChild(sprite);
			
			type = APPLE;
		}
		
		override public function update(deltaTime:Number):void 
		{
			super.update(deltaTime);
		}
	}
}