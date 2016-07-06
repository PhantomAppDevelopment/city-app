package businessScreens
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.List;
	import feathers.controls.PanelScreen;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class CategoryDetailsScreen extends PanelScreen
	{
		public static const GO_VENUE_DETAILS:String = "goVenueDetails";
		
		//Copy your own client ID
		private static const clientID:String = "";
				
		//Copy your own client secret
		private static const clientSecret:String = "";
		
		private var searchTerm:String = "New York";
		
		protected var _data:NavigatorData;
		
		private var fourSquareLoader:URLLoader;
		private var businessList:List;
		
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
			
			this.title = _data.categoryinfo.label;
			this.layout = new AnchorLayout();
			this.backButtonHandler = goBack;
			
			var backButton:Button = new Button();
			backButton.styleNameList.add("back-button");
			backButton.addEventListener(starling.events.Event.TRIGGERED, goBack);
			this.headerProperties.leftItems = new <DisplayObject>[backButton];
			
			businessList = new List();
			businessList.addEventListener(starling.events.Event.CHANGE, selectVenue);
			businessList.layoutData = new AnchorLayoutData(0, 0, 0, 0, NaN, NaN);
			businessList.itemRendererFactory = function():IListItemRenderer
			{
				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				renderer.isQuickHitAreaEnabled = true;
				
				renderer.labelFunction = function(item:Object):String
				{
					if(item.location.address == undefined)
					{
						if(item.categories.length != 0){
							return "<b>" + item.name + "</b>\n" + item.categories[0].name;
						} else {
							return item.name;
						}
					} else {
						if(item.categories.length != 0){
							return "<b>" + item.name + "</b>\n" + item.location.address + "\n" + item.categories[0].name;
						} else {
							return item.name;
						}
					}
				}
												
				renderer.accessoryLoaderFactory = function():ImageLoader
				{
					var loader:ImageLoader = new ImageLoader();
					loader.width = loader.height = 35;
					return loader;
				};
				
				renderer.accessorySourceFunction = function():String
				{
					return "assets/icons/ic_chevron_right_white_48dp.png";
				}
			
				return renderer;
			}
			this.addChild(businessList);
						
			fourSquareLoader =new URLLoader();
			fourSquareLoader.dataFormat = URLLoaderDataFormat.TEXT;
			fourSquareLoader.addEventListener(flash.events.Event.COMPLETE, loadedFourSquare);
			
			this.addEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, transitionInComplete);
		}
		
		private function transitionInComplete(event:starling.events.Event):void
		{
			this.removeEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, transitionInComplete);
		
			fourSquareLoader.load(new URLRequest("https://api.foursquare.com/v2/venues/search?near="+searchTerm+"&categoryId="+_data.categoryinfo.category+"&limit=50"+
				"&client_id="+clientID+"&client_secret="+clientSecret+"&v=20140101"));
		}
		
		private function loadedFourSquare(event:flash.events.Event):void
		{
			var rawData:Object = JSON.parse(String(fourSquareLoader.data));
			
			var businessArray:ListCollection = new ListCollection(rawData.response.venues as Array);
			businessList.dataProvider = businessArray;
		}
		
		private function selectVenue(event:starling.events.Event):void
		{
			this._data.venueinfo = businessList.selectedItem;
			dispatchEventWith(GO_VENUE_DETAILS);
		}
		
		private function goBack():void
		{
			this.dispatchEventWith(starling.events.Event.COMPLETE);
		}
	}
}