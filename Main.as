package
{
	import flash.display.Sprite;
	import skysand.animation.SkyClip;
	
	public class Main extends Sprite
	{
		private var _array:Array;
		
		public function Main() 
		{
			var skysand:SkySand = new SkySand(); //Экзэмпляр класса SkySand
			skysand.initialize(stage, 60, 800, 800); //Инициализация(ссылка на сцену, частота кадров, разрешение окна)
			skysand.mainClass = new App(); //Ссылка на класс
			
			addChild(skysand); //Добавляет на сцену отображаемый объект
		}
		
		private function startRandomize():void {
			var length:uint = _array.length;
 
			while (length--) {
				var n:int = Math.random() * (length + 1);
				swap(length, n);
			}
		}
 
 
		private function swap(x:uint, y:uint):void{
			var temp:* = _array[x];
			_array[x] = _array[y];
			_array[y] = temp;
		}
 
 
		//---------------------------------------------------------------------------
		//
		// PUBLIC STATIC METHODS
		//
		//---------------------------------------------------------------------------
 
		public function randomize(array:Array, count:uint = 1):Array {
			if (!array) return null;
 
			_array = array.slice();
 
			for (var i:uint = 0; i < count; i++) {
				startRandomize();
			}
 
			return _array;
		}
	}
}