package Backpack.Util 
{
	import Backpack.Util.StringUtil;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	/**
	 * Logger
	 * ログ出力をする
	 * 
	 * アプリケーションディレクトリ/log/タイムスタンプ.logで保存します。
	 * 出力時にprefixとしてタイムスタンプを自動で付与します。
	 */
	public class Logger 
	{
		private var logDir:File; 
		private var logFile:File;
		
		private var fileStream:FileStream;
		private var isOpen:Boolean = false;
		public function get IsOpen():Boolean { return isOpen; }
		
		
		public function Logger():void
		{
			// logフォルダを設定
			logDir = new File(File.applicationDirectory.nativePath + File.separator + "log");
			if (!logDir.exists)
				logDir.createDirectory();
			
			// logファイルを設定
			var date:Date = new Date();
			var fileName:String = date.fullYear + "_" + StringUtil.DigitNumber(date.month + 1, 2)
				+ "_" + StringUtil.DigitNumber(date.date, 2) + ".log";
			logFile = new File(logDir.nativePath + File.separator + fileName);
		}
		
		// ログを出力する
		public function Log(logStr:String):void
		{
			if (!isOpen)
			{
				fileStream = new FileStream();
				fileStream.open(logFile, FileMode.APPEND);
				isOpen = true;
			}
			
			fileStream.writeMultiByte(logStr + File.lineEnding, File.systemCharset);
		}
		
		// ログファイルを閉じる
		public function Close():void
		{
			if (!isOpen && fileStream != null)
			{
				fileStream.close();
				isOpen = false;
			}
		}
	}
}