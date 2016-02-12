package State 
{
	import Backpack.Base.StateBase;
	import Constant.SCENE_STATE;
	
	public class StartupState extends StateBase 
	{
		public function StartupState() 
		{
			
		}
		
		
		//////////////////////////////////////////////////////////////// IntefaceFunction
		
		override public function StateStart():void 
		{
			super.StateStart();
			
			// change state
			Main.Instance.sceneStateManager.ChangeState(SCENE_STATE.WAIT);
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