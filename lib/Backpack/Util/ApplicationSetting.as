package Backpack.Util
{
	import Backpack.Util.URLUtil;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.system.System;
	import flash.utils.Dictionary;
	
	/**
	 * ApplicationSetting
	 * コンテンツの設定ファイルを読み込む
	 */
	public class ApplicationSetting extends EventDispatcher
	{
		// singleton
		private static var instance:ApplicationSetting;
		public static function get Instance():ApplicationSetting
		{
			if (instance == null)
				instance = new ApplicationSetting();
			return instance;
		}
		
		private var url:String = "";
		public function get Url():String { return url; }
		public function set Url(value:String):void { url = value; }
		
		// XMLデータ
		private var xml:XML;
		public function get RawXML():XML { return xml; }
		
		// XML内データ
		private var data:Dictionary/*String*/ = new Dictionary();
		public function get Data():Dictionary/*String*/ { return data; }
		
		private var urlLoader:URLLoader;
		
		
		public function ApplicationSetting(url:String = "", useUnicode:Boolean = true)
		{
			instance = this;
			
			// unicode設定
			System.useCodePage = !useUnicode;
			
			// 自動読み込み開始
			if (url != "")
				Load(url);
		}
		
		
		// 読み込みを開始
		public function Load(url:String = ""):void
		{
			if (url != "")
				this.url = url;
			
			if (this.url != "")
			{
				var request:URLRequest = URLUtil.SetNoneCache(new URLRequest());
				request.method = URLRequestMethod.GET;
				request.url = this.url + URLUtil.GetTimeStampQuery();
				
				urlLoader = new URLLoader();
				urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
				urlLoader.addEventListener(Event.COMPLETE, OnXMLLoaded);
				urlLoader.addEventListener(IOErrorEvent.IO_ERROR, OnXMLLoadError);
				urlLoader.load(request);
			}
		}
		
		// 読み込み完了
		private function OnXMLLoaded(e:Event):void 
		{
			urlLoader.removeEventListener(Event.COMPLETE, OnXMLLoaded);
			urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, OnXMLLoadError);
			
			try
			{
				xml = new XML(urlLoader.data);
				ParseXML();
				
				// 完了イベント
				this.dispatchEvent(new Event(Event.COMPLETE));
			}
			catch (err:TypeError)
			{
				trace(err.message);
				
				// 失敗イベント
				this.dispatchEvent(new Event(IOErrorEvent.IO_ERROR));
			}
		}
		
		// 読み込み失敗
		private function OnXMLLoadError(e:IOErrorEvent):void 
		{
			urlLoader.removeEventListener(Event.COMPLETE, OnXMLLoaded);
			urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, OnXMLLoadError);
			
			trace(e.text);
			
			// 失敗イベント
			this.dispatchEvent(new Event(IOErrorEvent.IO_ERROR));
		}
		
		// パース処理
		private function ParseXML():void 
		{
			// ハッシュで登録
			for each (var item:XML in xml..item)
				data[String(item.@name)] = item.toString();
		}
		
		
		/*
		 * 型チェックしての取得
		 */
		
		public function GetString(key:String, defaultValue:String = ""):String
		{
			if (data.hasOwnProperty(key) && (data[key] as String) != null)
				return data[key];
			else
				return defaultValue;
		}
		
		public function GetBoolean(key:String, defaultValue:Boolean = false):Boolean
		{
			if (data.hasOwnProperty(key) && (data[key] as String) != null)
				return (data[key] as String).toLowerCase() == "true";
			else
				return defaultValue;
		}
		
		public function GetInt(key:String, defaultValue:int = 0):int
		{
			if (data.hasOwnProperty(key) && (data[key] as String) != null && !isNaN(int(data[key] as String)))
				return int(data[key] as String);
			else
				return defaultValue;
		}
		
		public function GetNumber(key:String, defaultValue:Number = 0.0):Number
		{
			if (data.hasOwnProperty(key) && (data[key] as String) != null && !isNaN(Number(data[key] as String)))
				return Number(data[key] as String);
			else
				return defaultValue;
		}
		
		public function GetStringArray(key:String, separator:String = ","):Array/*String*/
		{
			if (data.hasOwnProperty(key) && (data[key] as String) != null)
				return (data[key] as String).split(separator);
			else
				return new Array();
		}
		
		public function GetIntArray(key:String, separator:String = ",", defaultValue:int = 0):Array/*int*/
		{
			if (data.hasOwnProperty(key) && (data[key] as String) != null)
			{
				var strs:Array/*String*/ = (data[key] as String).split(separator);
				var list:Array/*int*/ = new Array();
				for each (var str:String in strs) 
				{
					if (!isNaN(int(str)))
						list.push(int(str));
					else
						list.push(defaultValue);
				}
				return list;
			}
			else
				return new Array();
		}
		
		public function GetNumberArray(key:String, separator:String = ",", defaultValue:Number = 0.0):Array/*Number*/
		{
			if (data.hasOwnProperty(key) && (data[key] as String) != null)
			{
				var strs:Array/*String*/ = (data[key] as String).split(separator);
				var list:Array/*Number*/ = new Array();
				for each (var str:String in strs) 
				{
					if (!isNaN(Number(str)))
						list.push(Number(str));
					else
						list.push(defaultValue);
				}
				return list;
			}
			else
				return new Array();
		}
		
		public function GetBooleanArray(key:String, separator:String = ","):Array/*Boolean*/
		{
			if (data.hasOwnProperty(key) && (data[key] as String) != null)
			{
				var strs:Array/*String*/ = (data[key] as String).split(separator);
				var list:Array/*Boolean*/ = new Array();
				for each (var str:String in strs)
					list.push(str.toLowerCase() == "true");
				return list;
			}
			else
				return new Array();
		}
	}
}