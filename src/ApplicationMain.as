package 
{
	import Backpack.Util.EnviromentArgs;
	import Backpack.Util.Process;
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.InvokeEvent;
	import flash.filesystem.File;
	import Main;
	
	/**
	 * ApplicationMain
	 * Application entry point for AIR.
	 */
	public class ApplicationMain extends Sprite 
	{
		// Singleton
		private static var instance:ApplicationMain;
		public static function get Instance():ApplicationMain { return instance; }
		
		// 関連アプリケーションプロセス
		private var externalProcess:Process;
		public function get ExternalProcess():Process { return externalProcess; }
		
		
		public function ApplicationMain():void 
		{
			instance = this;
			
			if (stage)
				Init();
			else
				this.addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		
		//////////////////////////////////////////////////////////////// Init
		
		private function Init(e:Event = null):void 
		{
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, OnApplicationStartUp);
			this.stage.nativeWindow.addEventListener(Event.CLOSING, OnApplicationWindowClose);
		}
		
		
		//////////////////////////////////////////////////////////////// EventListner
		
		// アプリケーションの起動シーケンス
		private function OnApplicationStartUp(e:InvokeEvent):void 
		{
			NativeApplication.nativeApplication.removeEventListener(InvokeEvent.INVOKE, OnApplicationStartUp);
			
			// 起動時引数を取得
			if (e.arguments.length > 0)
			{
				if(e.arguments.length % 2 == 0)
				{
					for (var i:int = 0; i < e.arguments.length; i+=2) 
						EnviromentArgs.SetArgs(e.arguments[0], e.arguments[1]);
				}
				else
					trace("起動時引数は[ key : value]のセットで指定してください。");
			}
			
			// アプリケーションを開始
			var main:Main = new Main();
			this.addChild(main)
		}
		
		// サポートアプリケーションを開始する
		public function StartSupportApplication(path:String):void
		{
			if (path != "")
			{
				if (new File(path).exists)
				{
					externalProcess = new Process(path);
					externalProcess.Execute();
				}
			}
		}
		
		// アプリケーション終了シーケンス
		private function OnApplicationWindowClose(e:Event):void 
		{
			this.stage.nativeWindow.removeEventListener(Event.CLOSING, OnApplicationWindowClose);
			
			// サポートアプリケーションの終了
			if (externalProcess != null)
				externalProcess.Exit();
		}
	}
}