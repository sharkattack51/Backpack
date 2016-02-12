package State 
{
	import Backpack.Base.StateBase;
	import View.PlayView;
	
	public class PlayState extends StateBase 
	{
		public function PlayState() 
		{
			// setup state view
			this.stateView = new PlayView();
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