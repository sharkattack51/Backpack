package State 
{
	import Backpack.Base.StateBase;
	import View.WaitView;
	
	public class WaitState extends StateBase
	{
		public function WaitState() 
		{
			// setup state view
			this.stateView = new WaitView();
		}
		
		
		//////////////////////////////////////////////////////////////// IntefaceFunction
		
		override public function StateStart():void 
		{
			super.StateStart();
		}
		
		override public function StateUpdate():void 
		{
			super.StateUpdate();
		}
		
		override public function StateExit():void 
		{
			super.StateExit();
		}
	}
}