package Backpack.Util 
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * TextFieldUtil
	 * テキストフィールド関係のユーティリティクラス
	 */
	public class TextFieldUtil 
	{	
		// テキストフィールドから溢れていたらフォントサイズを縮小する
		public static function ResizeFontAtOverFlow(textField:TextField, text:String, fieldHeight:Number):void
		{	
			// テキストを流し込んでサイズをチェックする
			textField.text = text;
			if (textField.height > fieldHeight)
			{
				var format:TextFormat = textField.getTextFormat();
				format.size = int(format.size) - 1;
				textField.defaultTextFormat = format;
				
				textField.text = "";
				
				ResizeFontAtOverFlow(textField, text, fieldHeight);
			}
		}
	}
}