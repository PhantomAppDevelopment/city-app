package screens
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
	
	public class AboutScreen extends PanelScreen
	{
		private var scrollText:ScrollText;
		
		override protected function initialize():void
		{
			super.initialize();
			
			this.title = "About";
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
			
			this.addEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, transitionComplete);
		}
		
		private function transitionComplete(event:Event):void
		{
			this.removeEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, transitionComplete);
			
			scrollText = new ScrollText();
			scrollText.layoutData = new AnchorLayoutData(10, 10, 10, 10, NaN, NaN);
			scrollText.text = "Phantom App Development - 2016\nhttp://phantom.im/\n\nThis application uses the following APIs and Webservices:\n\nYoutube V3 API\nGoogle News RSS Feeds\nGoogle Maps Embed API\nFlickr API\nFoursquare API";
			this.addChild(scrollText);
		}
		
		private function goBack(event:Event):void{
			this.dispatchEventWith(Event.COMPLETE);
		}
	}
}