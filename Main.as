package
{
	import flash.display.Sprite;
	import skysand.animation.SkyClip;
	
	public class Main extends Sprite
	{
		public function Main() 
		{
			//fsasfsafd
			var skysand:SkySand = new SkySand(); //Экзэмпляр класса SkySand
			skysand.initialize(stage, 60, 800, 800); //Инициализация(ссылка на сцену, частота кадров, разрешение окна)
			skysand.mainClass = new App(); //Ссылка на класс
			
			addChild(skysand); //Добавляет на сцену отображаемый объект
		}
	}
}