package Manager
{
	import Backpack.Interface.IManager;
	import Backpack.Interface.IState;
	import com.flashdynamix.utils.SWFProfiler;
	import Constant.SCENE_STATE;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.System;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * SceneStateManager
	 * シーンStateを管理するクラス
	 */
	public class SceneStateManager extends EventDispatcher implements IManager
	{
		private var currentState:String;
		public function get  CurrentState():String { return currentState; }
		
		private var stateObj:IState = null;
		public function get  CurrentStateObj():IState { return stateObj; }
		
		
		public function SceneStateManager():void
		{	
			Init();
		}
		
		
		//////////////////////////////////////////////////////////////// Init
		
		private function Init():void
		{
			Main.Instance.addEventListener(Event.ENTER_FRAME, OnLoop);
		}
		
		
		//////////////////////////////////////////////////////////////// EventListner
		
		private function OnLoop(e:Event):void 
		{
			// 現Stateの更新処理
			if (stateObj != null)
				stateObj.StateUpdate();
		}
		
		
		//////////////////////////////////////////////////////////////// PublicFunction
		
		// デストラクタ
		public function Destruct():void
		{
			Main.Instance.removeEventListener(Event.ENTER_FRAME, OnLoop);
		}
		
		// アプリケーションを開始する
		public function InitState():void
		{
			// スタートアップシーン
			ChangeState(SCENE_STATE.START_UP);
		}
		
		// Stateを変更する
		public function ChangeState(sceneState:String):void 
		{
			// 前Stateの終了処理
			if (stateObj != null)
				stateObj.StateExit();
			stateObj = null;
			
			currentState = sceneState;
			
			// 新規Stateのセット
			var stateClass:Class = getDefinitionByName(getQualifiedClassName(SCENE_STATE.StateTable[sceneState])) as Class;
			stateObj = new stateClass() as IState;
			
			// 新規Stateの初期化処理
			stateObj.StateStart();
		}
		
		public function ResetState():void
		{
			// 強制GC
			System.gc();
			SWFProfiler.gc();
			
			// StateをWait変更
			ChangeState(SCENE_STATE.WAIT);
		}
	}
}