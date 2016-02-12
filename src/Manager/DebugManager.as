package Manager
{
	import Backpack.Interface.IManager;
	import Backpack.Util.ApplicationSetting;
	import Backpack.Util.AutoLayout;
	import com.flashdynamix.utils.SWFProfiler;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import Main;
	
	/**
	 * DebugManager
	 * デバッグ機能を管理するクラス
	 */
	public class DebugManager extends EventDispatcher implements IManager
	{
		private var debugView:MovieClip;
		public function get DebugView():MovieClip { return debugView; }
		
		private var debugText:TextField;
		public function get DebugText():String { return debugText.text; }
		public function set DebugText(str:String):void { debugText.text = str; }
		
		private var debugTextBg:Sprite;
		
		private var isEnabled:Boolean;
		
		
		public function DebugManager():void
		{
			Init();
		}
		
		
		//////////////////////////////////////////////////////////////// Init
		
		private function Init():void
		{
			// 設定ファイルから反映
			isEnabled = ApplicationSetting.Instance.GetBoolean("IsDebug");
			
			// SWF Profiler
			if (isEnabled)
				SWFProfiler.init(Main.Instance.stage, Main.Instance);
			
			// デバッグ表示レイヤーを設定
			debugView = new MovieClip();
			debugView.mouseEnabled = false;
			debugView.mouseChildren = false;
			Main.Instance.stage.addChildAt(debugView, Main.Instance.stage.numChildren);
			
			// デバッグ表示用テキストフィールド
			debugTextBg = new Sprite();
			debugTextBg.graphics.beginFill(0xFF0000, 0.7);
			debugTextBg.graphics.drawRect(0, 0, 600, 800);
			debugTextBg.graphics.endFill();
			debugTextBg.x = 50;
			debugTextBg.y = 50 - (AutoLayout.GetDifferenceHeight(Main.Instance.stage) / 2);
			debugTextBg.mouseChildren = false;
			debugTextBg.mouseEnabled = false;
			debugView.addChild(debugTextBg);
			
			debugText = new TextField();
			debugText.x = 50;
			debugText.y = 50 - (AutoLayout.GetDifferenceHeight(Main.Instance.stage) / 2);
			debugText.width = 600;
			debugText.height = 800;
			debugText.defaultTextFormat = new TextFormat("_ゴシック", 16, 0xFFFFFF, true);
			debugText.selectable = false;
			debugText.mouseEnabled = false;
			debugView.addChild(debugText);
			debugText.text = "-- Debug window --";
			
			debugView.scaleX = Main.Instance.stage.stageWidth / 1920;
			debugView.scaleY = Main.Instance.stage.stageHeight / 1080;
			
			// 表示の初期化
			UpdateDisplay();
			
			Trace("Toggle this window [ D ] key.");
		}
		
		
		//////////////////////////////////////////////////////////////// PrivateFunction
		
		// 表示の更新
		private function UpdateDisplay():void
		{
			// デバッグViewの表示
			debugView.visible = isEnabled;
		}
		
		
		//////////////////////////////////////////////////////////////// PublicFunction
		
		// デストラクタ
		public function Destruct():void 
		{	
			debugView.removeChild(debugText);
			debugText = null;
			
			debugView.removeChild(debugTextBg);
			debugTextBg = null;
			
			Main.Instance.stage.removeChild(debugView);
			debugView = null;
		}
		
		// デバッグ表示のトグル
		public function ToggleDebug():void
		{
			isEnabled = !isEnabled;
			
			UpdateDisplay();
		}
		
		// デバッグ用トレース
		public function Trace(obj:Object):void
		{
			debugText.text = String(obj) + "\n" + debugText.text;
		}
	}
}