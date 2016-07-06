package mediaScreens
{
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	
	import feathers.controls.Button;
	import feathers.controls.PanelScreen;
	import feathers.controls.WebView;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class VideoDetailsScreen extends PanelScreen
	{
		private var webView:WebView;

		protected var _data:NavigatorData;
		
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

			this.title = this._data.videoinfo.snippet.title;
			this.layout = new AnchorLayout();
			this.backButtonHandler = goBack;
			
			var backButton:Button = new Button();
			backButton.styleNameList.add("back-button");
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
		
		private function goBack():void{
			this.dispatchEventWith(Event.COMPLETE);
		}
	}
}