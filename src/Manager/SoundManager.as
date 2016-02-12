package Manager
{
	import Backpack.Interface.IManager;
	import Backpack.Util.ApplicationSetting;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	/**
	 * SoundManager
	 * Soundの再生を管理するクラス
	 */
	public class  SoundManager extends EventDispatcher implements IManager
	{
		// BGM
		private var bgm:Sound;
		private var bgmCh:SoundChannel;
		private var bgmVol:Number = 0;
		
		// SE
		private var se:Sound;
		private var seCh:SoundChannel;
		private var seVol:Number = 0;
		
		
		public function SoundManager():void
		{
			Init();
		}
		
		
		//////////////////////////////////////////////////////////////// Init
		
		private function Init():void
		{
			// 設定ファイルから反映
			bgmVol  = ApplicationSetting.Instance.GetNumber("BgmVolume");
			seVol  = ApplicationSetting.Instance.GetNumber("SeVolume");
		}
		
		
		//////////////////////////////////////////////////////////////// PublicFunction
		
		// デストラクタ
		public function Destruct():void
		{
			bgm = null;
			bgmCh = null;
			
			se = null;
			seCh = null;
		}
		
		// BGMを再生
		public function PlayBGM(id:int):void
		{	
			if (bgmCh.position != 0)
				bgmCh.stop();
			
			switch (id)
			{
				/*
				 * Create instance of sound class from SWC.
				 */ 
				//case 0: bgm = new BGM_1(); break;
				//case 1: bgm = new BGM_2(); break;
				default: break;
			}
			
			if (bgm != null)
				bgmCh = bgm.play(0, 10000, new SoundTransform(bgmVol));
		}
		
		// SEを再生
		public function PlaySE(id:int, isPlayOne:Boolean = false):void
		{	
			if (isPlayOne && seCh.position != 0)
				seCh.stop();
			
			switch (id)
			{
				/*
				 * Create instance of sound class from SWC.
				 */ 
				//case 0: se = new SE_1(); break;
				//case 1: se = new SE_2(); break;
				default: break;
			}
			
			if (se != null)
				seCh = se.play(0, 1, new SoundTransform(seVol));
		}
	}
}