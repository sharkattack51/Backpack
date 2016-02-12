package Backpack.Util 
{
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	/**
	 * Process
	 * ネイティブプロセスを実行するクラス
	 * 
	 * NativeProcessクラスを使用するにはサポートするプロファイルに
	 * デスクトップ拡張を指定する必要があります。
	 * また、パッケージングオプションで-target nativeを指定し
	 * .exeとして出力する必要があります。
	 */
	public class Process extends EventDispatcher
	{
		// プロセス実行の本体
		private var process:NativeProcess = null;
		public function get nativeProcess():NativeProcess { return process; }
		
		private var processInfo:NativeProcessStartupInfo;
		
		// 標準入力へのアクセス
		public function get StandardInput():IDataOutput
		{
			if (process != null && process.running)
				return process.standardInput;
			else
				return null;
		}
		
		// 標準出力へのアクセス
		public function get StandardOutput():IDataInput
		{
			if (process != null && process.running)
				return process.standardOutput;
			else
				return null;
		}
		
		//標準エラー出力へのアクセス
		public function get StandardError():IDataInput
		{
			if (process != null && process.running)
				return process.standardError;
			else
				return null;
		}
		
		// 標準出力から取得したString
		private var standardOutputStr:String = "";
		public function get StandardOutputStr():String { return standardOutputStr; }
		
		
		public function Process(filePath:String, ...args):void
		{
			if (NativeProcess.isSupported)
			{
				// 実行するファイルを指定
				var file:File = File.applicationDirectory.resolvePath(filePath);
				if (!file.exists)
				{
					trace("Process :: 実行ファイルがありません " + filePath);
					return;
				}
				
				// 引数を設定
				var argStr:Vector.<String> = new Vector.<String>();
				for each (var arg:String in args) 
					argStr.push(arg.toString());
				
				// プロセス情報を設定
				processInfo = new NativeProcessStartupInfo();
				processInfo.executable = file;
				processInfo.arguments = argStr;
				process = new NativeProcess();
				process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, OnStdOutData);
				process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, OnStdErrorData);
			}
			else
			{
				trace("Process :: サポートするプロファイルにデスクトップ拡張が指定されていません");
			}
		}
		
		
		//////////////////////////////////////////////////////////////// EventListener
		
		// 標準出力のキャッチ
		private function OnStdOutData(e:ProgressEvent):void 
		{
			// データを取得
			standardOutputStr = process.standardOutput.readUTFBytes(process.standardOutput.bytesAvailable);
			
			this.dispatchEvent(e);
		}
		
		// 標準エラー出力のキャッチ
		private function OnStdErrorData(e:ProgressEvent):void 
		{
			trace("Process :: 標準エラー出力");
		}
		
		
		//////////////////////////////////////////////////////////////// PublicFunction
		
		// プロセスの実行
		public function Execute():void
		{
			if(process != null && !process.running)
				process.start(processInfo);
		}
		
		// プロセスの停止
		public function Exit():void
		{
			if (process != null && process.running)
				process.exit(true);
		}
		
		// プロセスへの入力
		public function StandardInputWriteString(str:String):void
		{
			if(process != null && process.running)
				process.standardInput.writeUTFBytes(str);
		}
	}
}