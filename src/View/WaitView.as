package View 
{
	import Backpack.Base.ViewBase;
	import Constant.SCENE_STATE;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class WaitView extends ViewBase
	{
		private var btnStart:SimpleButton;
		
		
		public function WaitView() 
		{
			super();
		}
		
		
		//////////////////////////////////////////////////////////////// Init
		
		override protected function InitVar():void 
		{
			super.InitVar();
		}
		
		override protected function InitView():void 
		{
			super.InitView();
			
			view = new WaitViewMC();
			this.addChild(view);
			
			btnStart = view.getChildByName("btn_start") as SimpleButton;
		}
		
		override protected function InitEvent():void 
		{
			super.InitEvent();
			
			btnStart.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				Main.Instance.debugManager.Trace("change state to [ PLAY ]");
				Main.Instance.sceneStateManager.ChangeState(SCENE_STATE.PLAY);
			}, false, 0, true);
		}
		
		
		//////////////////////////////////////////////////////////////// EventListner
		
		// デストラクタ
		override protected function Destructor(e:Event):void 
		{
			super.Destructor(e);
			
			btnStart = null;
			
			this.removeChild(view);
			view = null;
		}	
	}
}