package Backpack.Util 
{
	import flash.utils.Dictionary;
	
	/**
	 * EnviromentArgs
	 * アプリケーション起動時の引数を持つ
	 */
	public class EnviromentArgs 
	{
		private static var args:Dictionary = new Dictionary();
		public static function get Args():Dictionary { return args; }
		
		//引数をディクショナリにセットする
		public static function SetArgs(key:String, value:String):void
		{
			args[key] = value;
		}
	}
}