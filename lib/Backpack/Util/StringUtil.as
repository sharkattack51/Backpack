package Backpack.Util 
{
	import mx.utils.StringUtil;
	
	/**
	 * StringUtil
	 * 文字列関係のユーティリティクラス
	 */
	public class StringUtil 
	{
		/*
		 * 数値を指定した桁数に揃える
		 */
		public static function DigitNumber(num:Number, digit:int):String
		{
			var str:String = String(num);
			while (str.length < digit)
				str = "0" + str;
			
			return str;
		}
		
		/*
		 * 空白文字のトリムと全角スペースのトリムを行う
		 */ 
		public static function Trim(str:String):String
		{
			var trimmedStr:String = mx.utils.StringUtil.trim(str);
			
			//全角スペースのトリム
			var expHead:RegExp = new RegExp('^[　]*');
			var expFoot:RegExp = new RegExp('[　]*$');
			trimmedStr = trimmedStr.replace(expHead, "").replace(expFoot, "");
			
			return trimmedStr;
		}
	}
}