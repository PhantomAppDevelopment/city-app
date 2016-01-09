package businessScreens
{
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.PanelScreen;
	import feathers.controls.WebView;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class MapScreen extends PanelScreen
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
			
			this.title = this._data.venueinfo.name;
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
						
			this.addEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, transitionInComplete);
		}
		
		private function transitionInComplete(event:starling.events.Event):void
		{
			this.removeEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, transitionInComplete);
			
			webView = new WebView();
			webView.layoutData = new AnchorLayoutData(5, 5, 5, 5, NaN, NaN);
			webView.useNative = true;
			this.addChild(webView);
			var urlString:String = "<iframe width='100%' height='100%' frameborder='0' style='border:0' src='https://www.google.com/maps/embed/v1/place?key=<YOURAPIKEY>" +
				"&zoom=17&q="+this._data.venueinfo.location.lat+","+this._data.venueinfo.location.lng+"'></iframe>";
			
			webView.loadString(urlString);
		}
		
		private function goBack(event:Event):void{
			this.dispatchEventWith(Event.COMPLETE);
		}
	}
}