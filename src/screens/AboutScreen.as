package screens
{
	import feathers.controls.Button;
	import feathers.controls.PanelScreen;
	import feathers.controls.ScrollText;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class AboutScreen extends PanelScreen
	{
		
		override protected function initialize():void
		{
			super.initialize();
			
			this.title = "About";
			this.layout = new AnchorLayout();
			this.backButtonHandler = goBack;

			var backButton:Button = new Button();
			backButton.styleNameList.add("back-button");
			backButton.addEventListener(Event.TRIGGERED, goBack);
			this.headerProperties.leftItems = new <DisplayObject>[backButton];
			
			this.addEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, transitionComplete);
		}
		
		private function transitionComplete(event:Event):void
		{
			this.removeEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, transitionComplete);
			
			var scrollText:ScrollText = new ScrollText();
			scrollText.layoutData = new AnchorLayoutData(10, 10, 10, 10, NaN, NaN);
			scrollText.text = "Phantom App Development - 2016\nhttp://phantom.im/\n\nThis application uses the following APIs and Webservices:\n\nYoutube V3 API\nGoogle News RSS Feeds\nGoogle Maps Embed API\nFlickr API\nFoursquare API";
			this.addChild(scrollText);
		}
		
		private function goBack(event:Event):void
		{
			this.dispatchEventWith(Event.COMPLETE);
		}
	}
}