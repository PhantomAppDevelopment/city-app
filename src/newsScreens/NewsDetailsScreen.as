package newsScreens
{
	import feathers.controls.Button;
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
			this.backButtonHandler = goBack;
			
			var backButton:Button = new Button();
			backButton.styleNameList.add("back-button");
			backButton.addEventListener(Event.TRIGGERED, goBack);
			this.headerProperties.leftItems = new <DisplayObject>[backButton];
						
			this.addEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, transitionInComplete);
		}
		
		private function transitionInComplete(event:starling.events.Event):void
		{
			this.removeEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, transitionInComplete);
			
			var scrollText:ScrollText = new ScrollText();
			scrollText.layoutData = new AnchorLayoutData(10, 10, 10, 10, NaN, NaN);
			this.addChild(scrollText);
			
			scrollText.text = this._data.newsinfo.description;
		}		
		
		private function goBack():void
		{
			this.dispatchEventWith(Event.COMPLETE);
		}
	}
}