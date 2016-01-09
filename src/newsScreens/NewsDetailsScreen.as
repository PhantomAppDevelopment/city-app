package newsScreens
{
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.PanelScreen;
	import feathers.controls.ScrollText;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	
	public class NewsDetailsScreen extends PanelScreen
	{
		protected var _data:NavigatorData;
		private var scrollText:ScrollText;
		
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
			
			this.title = this._data.newsinfo.title;
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
			scrollText = new ScrollText();
			scrollText.layoutData = new AnchorLayoutData(10, 10, 10, 10, NaN, NaN);
			this.addChild(scrollText);
			scrollText.text = this._data.newsinfo.description;
		}		
		
		private function goBack(event:Event):void{
			this.dispatchEventWith(Event.COMPLETE);
		}
	}
}