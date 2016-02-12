package Manager
{
	import ApplicationMain;
	import Backpack.Interface.IManager;
	import flash.desktop.NativeApplication;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	/**
	 * KeyInputManger
	 * キー入力を管理するクラス
	 */
	public class KeyInputManger extends EventDispatcher implements IManager
	{
		public function KeyInputManger():void
		{
			Init();
		}
		
		
		//////////////////////////////////////////////////////////////// Init
		
		private function Init():void
		{
			ApplicationMain.Instance.stage.addEventListener(KeyboardEvent.KEY_DOWN, OnKeyDown);
		}
		
		
		//////////////////////////////////////////////////////////////// EventListner
		
		private function OnKeyDown(e:KeyboardEvent):void 
		{
			/*
			 * Add the application key events.
			 */ 
			
			// D
			if (e.keyCode == Keyboard.D)
			{
				// デバッグ表示の切り替え
				if(Main.Instance.debugManager != null)
					Main.Instance.debugManager.ToggleDebug();
			}
			
			// ESC
			if (e.keyCode == Keyboard.ESCAPE)
			{	
				// アプリケーションの終了
				NativeApplication.nativeApplication.exit();
			}
		}
		
		
		//////////////////////////////////////////////////////////////// PublicFunction
		
		// デストラクタ
		public function Destruct():void
		{
			ApplicationMain.Instance.stage.removeEventListener(KeyboardEvent.KEY_DOWN, OnKeyDown);
		}
	}
}