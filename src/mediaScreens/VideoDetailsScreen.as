package mediaScreens
{
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.PanelScreen;
	import feathers.controls.WebView;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class VideoDetailsScreen extends PanelScreen
	{
		protected var _data:NavigatorData;
		private var webView:WebView;
		
		public function get data():NavigatorData
		{
			return this._data;
		}		
		
		public function set data(value:NavigatorData):void
		{
			this._data = value;
		}
		
		override protected function initialize():void
		{
			super.initialize();						

			//this.addEventListener(Event.REMOVED_FROM_STAGE, removeHandler);
			
			this.title = this._data.videoinfo.snippet.title;
			this.layout = new AnchorLayout();
			this.backButtonHandler = function():void
			{
				this.dispatchEventWith(Event.COMPLETE);
			}
			
			var arrowIcon:ImageLoader = new ImageLoader();
			arrowIcon.source = "assets/icons/ic_arrow_back_white_48dp.png";
			arrowIcon.width = 25;
			arrowIcon.height = 25;
			arrowIcon.snapToPixels = true;
			
			var backButton:Button = new Button();
			backButton.width = 45;
			backButton.height = 45;
			backButton.styleNameList.add("header-button");
			backButton.defaultIcon = arrowIcon;
			backButton.addEventListener(Event.TRIGGERED, goBack);
			this.headerProperties.leftItems = new <DisplayObject>[backButton];
			
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			
			this.addEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, transitionInComplete);
		}
		
		private function transitionInComplete(event:starling.events.Event):void
		{
			this.removeEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, transitionInComplete);
			webView = new WebView();
			webView.layoutData = new AnchorLayoutData(5, 5, 5, 5, NaN, NaN);
			webView.useNative = true;
			this.addChild(webView);
			webView.loadURL("http://www.youtube.com/embed/"+this._data.videoinfo.id.videoId);
		}
		
		private function removeHandler(event:Event):void
		{
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.NORMAL;
			webView.dispose();
		}
		
		private function goBack(event:Event):void{
			this.dispatchEventWith(Event.COMPLETE);
		}
	}
}