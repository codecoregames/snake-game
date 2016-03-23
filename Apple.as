package 
{
	import skysand.animation.SkyClip;
	
	public class Apple extends ObjectBase
	{
		
		public function Apple() 
		{
			
		}
		
		override public function init(grid:Grid):void
		{
			super.init(grid);
			
			sprite = new SkyClip();
			sprite.setAnimation("apple");
			addChild(sprite);
		}
		
		override public function setPos(x:int, y:int):Boolean
		{
			if (grid.getCell(x, y) != Grid.CELL_FREE) return false;
			
			grid.setCell(this.x, this.y, Grid.CELL_FREE);
			grid.setCell(x, y, Grid.CELL_APPLE);
			
			super.setPos(x, y);
			
			return true
		}
		
		override public function update(deltaTime:Number):void 
		{
			super.update(deltaTime);
		}
	}
}