package Backpack.Base 
{
	import Backpack.Interface.IState;
	import flash.display.MovieClip;
	
	/**
	 * StateBase
	 * Stateクラスのベースクラス
	 */
	public class StateBase implements IState 
	{
		protected var stateView:MovieClip = null;
		public function get StateView():MovieClip { return stateView; }
		
		
		public function StateBase():void
		{
			
		}
		
		
		//////////////////////////////////////////////////////////////// InterfaceFunction
		
		public function StateStart():void 
		{
			if (stateView != null)
				Main.Instance.ViewContainer.addChild(stateView);
		}
		
		public function StateUpdate():void 
		{
			
		}
		
		public function StateExit():void 
		{
			if (stateView != null)
				Main.Instance.ViewContainer.removeChild(stateView);
			stateView = null;
		}
	}
}