package Backpack.Interface 
{
	/**
	 * IState
	 * Stateクラスのインターフェース
	 */
	public interface IState 
	{
		function StateStart():void;
		function StateUpdate():void;
		function StateExit():void;
	}
}