package 
{
	import skysand.ui.SkyColor;
	
	public class Config 
	{
		public static const WINDOW_WIDTH:uint = SkySand.SCREEN_WIDTH;
		public static const WINDOW_HEIGHT:uint = SkySand.SCREEN_HEIGHT;
		public static const CELL_SIZE:uint = 50;
		public static const HALF_CELL_SIZE:Number = CELL_SIZE / 2;
		public static const NCELLS_X:uint = WINDOW_WIDTH / CELL_SIZE;
		public static const NCELLS_Y:uint = WINDOW_HEIGHT / CELL_SIZE;
		
		public static const SNAKE_COLOR:uint = SkyColor.GREEN_SEA;
		public static const APPLE_COLOR:uint = SkyColor.RED_PURPLE;
	}
}