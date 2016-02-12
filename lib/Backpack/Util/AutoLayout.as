package Backpack.Util 
{
	import flash.display.Stage;
	import flash.system.Capabilities;
	
	/**
	 * AutoLayout
	 * 自動レイアウト用のユーティリティ
	 */
	public class AutoLayout 
	{
		public static function GetFloatingHeightAspect(stage:Stage):Number
		{
			return stage.stageWidth * Capabilities.screenResolutionY / Capabilities.screenResolutionX / stage.stageHeight;
		}
		
		public static function GetDifferenceHeight(stage:Stage):Number
        {
            return (stage.stageHeight * GetFloatingHeightAspect(stage)) - stage.stageHeight;
		}
	}
}