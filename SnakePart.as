package 
{
	
	public class SnakePart extends ObjectBase
	{
		
		public function SnakePart() 
		{
			
		}
		
		override public function init():void{
			super.init();
			sprite.setAnimation("body");
		}
	}

}