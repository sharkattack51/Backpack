package Constant
{
	import flash.utils.Dictionary;
	import State.PlayState;
	import State.StartupState;
	import State.WaitState;
	
	/**
	 * SCENE_STATE
	 * シーンState定数
	 */
	public class SCENE_STATE
	{
		/*
		 * Setup the "State" classes and constant values.
		 */
		public static const START_UP:String = "start_up";
		public static const WAIT:String = "wait";
		public static const PLAY:String = "play";
		
		/*
		 *  Setup the relational state tables and import state classes.
		 */
		private static var stateTable:Dictionary = new Dictionary();
		public static function get StateTable():Dictionary
		{
			stateTable[SCENE_STATE.START_UP] = StartupState;
			stateTable[SCENE_STATE.WAIT] = WaitState;
			stateTable[SCENE_STATE.PLAY] = PlayState;
			
			return stateTable;
		}
	}
}