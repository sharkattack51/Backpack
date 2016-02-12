package View 
{
	import Backpack.Base.ViewBase;
	import Constant.SCENE_STATE;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	public class PlayView extends ViewBase
	{
		private var tfTime:TextField;
		private var countTimer:Timer;
		
		
		public function PlayView() 
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
			
			view = new PlayViewMC();
			this.addChild(view);
			
			tfTime = view.getChildByName("tf_time") as TextField;
			tfTime.text = "10";
		}
		
		override protected function InitEvent():void 
		{
			super.InitEvent();
			
			countTimer = new Timer(1000);
			countTimer.addEventListener(TimerEvent.TIMER, function(e:TimerEvent):void {
				
				var ct:int = int(tfTime.text) - 1;
				
				Main.Instance.debugManager.Trace(String(ct));
				tfTime.text = String(ct);
				
				if (ct == 0)
				{
					Main.Instance.debugManager.Trace("change state to [ WAIT ]");
					Main.Instance.sceneStateManager.ChangeState(SCENE_STATE.WAIT);
				}
			}, false, 0, true);
			countTimer.start();
		}
		
		
		//////////////////////////////////////////////////////////////// EventListner
		
		// デストラクタ
		override protected function Destructor(e:Event):void 
		{
			super.Destructor(e);
			
			tfTime = null;
			
			countTimer.stop();
			countTimer = null;
			
			this.removeChild(view);
			view = null;
		}
	}
}