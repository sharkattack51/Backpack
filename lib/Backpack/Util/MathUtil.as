package Backpack.Util 
{
	/**
	 * MathUtil
	 * 数値計算関係のユーティリティクラス
	 */
	public class MathUtil 
	{
		/*
		 * 現状以外のIDをランダムで取得する
		 */
		public static function GetRandomOtherId(current:int, length:int):int
		{
			var newId:int = Math.floor(Math.random() * length);
			
			if (newId != current)
				return newId;
			else
				return GetRandomOtherId(current, length);
		}
	}
}