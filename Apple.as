package 
{
	import skysand.animation.SkyClip;
	
	public class Apple extends ObjectBase
	{
		public function Apple() 
		{
			super();
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
			
			type = Grid.CELL_APPLE;
		}
		
		override public function update(deltaTime:Number):void 
		{
			super.update(deltaTime);
		}
	}
}