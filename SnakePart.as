package 
{
	import skysand.animation.SkyClip;
	
	public class SnakePart extends ObjectBase
	{
		public function SnakePart() 
		{
			super();
		}
		
		override public function init():void 
		{
			super.init();
			
			sprite = new SkyClip();
			sprite.setAnimation("body");
			addChild(sprite);
			
			type = Grid.CELL_SNAKE;
		}
		
		override public function update(deltaTime:Number):void 
		{
			super.update(deltaTime);
		}
	}
}