package Backpack.Base 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ViewBase
	 * Viewクラスのベースクラス
	 */
	public class ViewBase extends FrameworkObjectBase 
	{
		protected var view:MovieClip;
		
		
		public function ViewBase() 
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
		}
		
		override protected function InitEvent():void 
		{
			super.InitEvent();
		}
		
		
		//////////////////////////////////////////////////////////////// EventListner
		
		// デストラクタ
		override protected function Destructor(e:Event):void 
		{
			super.Destructor(e);
		}
	}
}