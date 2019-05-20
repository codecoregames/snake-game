package
{
	import flash.display.Sprite;
	
	public class Main extends Sprite
	{
		public function Main() 
		{
			var skysand:SkySand = new SkySand(); //Экзэмпляр класса SkySand
			skysand.initialize(stage, Game); //Инициализация(ссылка на сцену, частота кадров, разрешение окна)
			skysand.isDevelopMode = true;
			addChild(skysand); //Добавляет на сцену отображаемый объект
		}
	}
}