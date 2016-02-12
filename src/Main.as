package 
{
	import Backpack.Util.ApplicationSetting;
	import Backpack.Util.EnviromentArgs;
	import Backpack.Util.Logger;
	import com.flashdynamix.utils.SWFProfiler;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.ui.Mouse;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import Main;
	import Manager.DebugManager;
	import Manager.KeyInputManger;
	import Manager.SceneStateManager;
	import Manager.SoundManager;
	
	/**
	 * Main
	 * Entrypoint for Flash SWF.
	 */
	public class Main extends MovieClip 
	{
		// Singleton
		private static var instance:Main;
		public static function get Instance():Main { return instance; };
		
		private var isDebug:Boolean;
		private var useMouse:Boolean;
		private var showMouseCursor:Boolean;
		
		// Viewコンテナ
		private var viewContainer:Sprite;
		public function get ViewContainer():Sprite { return viewContainer; }
		
		// マネージャー
		private var debugMng:DebugManager;
		public function get debugManager():DebugManager { return debugMng; }
		private var sceneStateMng:SceneStateManager;
		public function get sceneStateManager():SceneStateManager { return sceneStateMng; }
		private var soundMng:SoundManager;
		public function get soundManager():SoundManager { return soundMng; }
		private var keyInputMng:KeyInputManger;
		public function get keyInputManger():KeyInputManger { return keyInputMng; }
		
		// Logger
		private var _logger:Logger;
		public function get logger():Logger { return _logger; }
		
		
		public function Main():void 
		{
			instance = this;
			
			if (stage)
				Init();
			else
				this.addEventListener(Event.ADDED_TO_STAGE, Init);
			
			// バージョン出力
			trace("Backpack v1.0");
		}
		
		
		//////////////////////////////////////////////////////////////// Init
		
		private function Init(e:Event = null):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, Init);
			
			// 設定ファイルの読み込み
			ApplicationSetting.Instance.addEventListener(Event.COMPLETE, OnLoadXML);
			ApplicationSetting.Instance.Load("ApplicationSetting.xml");
		}
		
		private function OnLoadXML(e:Event):void 
		{
			ApplicationSetting.Instance.removeEventListener(Event.COMPLETE, OnLoadXML);
			
			// 初期化
			InitVar();
			InitView();
			InitEvent();
			InitManager();
			
			/*
			 * Project begins from here.
			 */ 
			
			sceneStateManager.InitState();
		}
		
		private function InitVar():void
		{
			// 起動時引数がある場合は設定ファイルを上書き
			if (EnviromentArgs.Args.hasOwnProperty("-mode"))
			{
				if (EnviromentArgs.Args["-mode"] == "mouse")
					ApplicationSetting.Instance.Data["UseMouse"] = true;
				else if (EnviromentArgs.Args["-mode"] == "touch")
					ApplicationSetting.Instance.Data["UseMouse"] = false;
			}
			
			// 設定ファイルから反映
			isDebug = ApplicationSetting.Instance.GetBoolean("IsDebug");
			useMouse = ApplicationSetting.Instance.GetBoolean("UseMouse");
			showMouseCursor = ApplicationSetting.Instance.GetBoolean("ShowMouseCursor");
			
			// 入力モードの設定（マウス/タッチ）
			if (useMouse)
			{
				/*
				 * Mouse input for Karabiner UI Component.
				 */
				
				/*
				ButtonBase.UseMouse = true;
				SimpleDraggableBase.UseMouse = true;
				DragInteractionBase.UseMouse = true;
				*/
			}
			else
			{
				Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
				
				/*
				 * Touch input for Karabiner UI Component.
				 */ 
				
				/*
				ButtonBase.UseMouse = false;
				SimpleDraggableBase.UseMouse = false;
				DragInteractionBase.UseMouse = false;
				*/
			}
			
			// マウスポインタの表示
			if (showMouseCursor)
				Mouse.show();
			else
				Mouse.hide();
			
			//外部jsコールバック関数設定
			if (ExternalInterface.available)
				ExternalInterface.addCallback("ExternalCallBackFunction", ExternalCallBackFunction);
			
			// for AIR
			if (ApplicationMain.Instance != null)
			{
				// ウィンドウをフルスクリーン化する
				if (ApplicationSetting.Instance.GetBoolean("UseFullScreen"))
					this.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
				
				// ウィンドウを最前面表示
				if (ApplicationSetting.Instance.GetBoolean("UseFrontWindow"))
					this.stage.nativeWindow.alwaysInFront = true;
				
				// ログ設定
				_logger = new Logger();
				
				// サポートアプリケーションの起動
				ApplicationMain.Instance.StartSupportApplication(ApplicationSetting.Instance.GetString("SupportApplication"));
			}
		}
		
		private function InitView():void 
		{
			// Viewコンテナ
			viewContainer = new Sprite();
			addChild(viewContainer);
		}
		
		private function InitEvent():void 
		{
			this.addEventListener(Event.REMOVED_FROM_STAGE, Destructor);
		}
		
		private function InitManager():void
		{
			// マネージャー設定
			debugMng = new DebugManager();
			sceneStateMng = new SceneStateManager();;
			soundMng = new SoundManager();
			keyInputMng = new KeyInputManger();
		}
		
		
		//////////////////////////////////////////////////////////////// EventListner
		
		// デストラクタ
		private function Destructor(e:Event):void 
		{	
			this.removeEventListener(Event.REMOVED_FROM_STAGE, Destructor);
			
			// Viewコンテナ
			removeChild(viewContainer);
			viewContainer = null;
			
			// マネージャー
			debugMng.Destruct();
			debugMng = null;
			
			sceneStateMng.Destruct();
			sceneStateMng = null;
			
			soundMng.Destruct();
			soundMng = null;
			
			keyInputMng.Destruct();
			keyInputMng = null;
			
			// ログ設定
			if (_logger != null)
				_logger.Close();
			_logger = null;
			
			SWFProfiler.gc();
		}
		
		
		//////////////////////////////////////////////////////////////// ExternalInterface
		
		public function ExternalCallBackFunction():void
		{
			/*
			 * Callback function from html.
			 */
		}
	}
}