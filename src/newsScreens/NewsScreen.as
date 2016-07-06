package newsScreens
{	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.List;
	import feathers.controls.PanelScreen;
	import feathers.controls.TabBar;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class NewsScreen extends PanelScreen
	{
		public static const GO_NEWS_DETAILS:String = "goNewsDetails";
		
		private var mainTabBar:TabBar;
		private var newsList:List;
		private var newsLoader:URLLoader;
		private var searchTerm:String = "New York";
		
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
			
			this.title = "News";
			this.layout = new AnchorLayout();
			this.backButtonHandler = goBack;
						
			var backButton:Button = new Button();
			backButton.styleNameList.add("back-button");
			backButton.addEventListener(starling.events.Event.TRIGGERED, goBack);
			this.headerProperties.leftItems = new <DisplayObject>[backButton];
					
			newsList = new List();
			newsList.layoutData = new AnchorLayoutData(60, 0, 0, 0, NaN, NaN);
			newsList.addEventListener(starling.events.Event.CHANGE, newsListHandler);
			newsList.itemRendererFactory = function():IListItemRenderer
			{
				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				renderer.isQuickHitAreaEnabled = true;
				
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
				
				renderer.labelFunction = function(item:Object):String
				{
					return "<b>" + item.title + "</b>\n" + item.pubDate;
				}
					
				return renderer;
			}
						
			this.addChild(newsList);
			
			newsLoader = new URLLoader();
			newsLoader.dataFormat = URLLoaderDataFormat.TEXT;
			newsLoader.addEventListener(flash.events.Event.COMPLETE, newsLoaded);
						
			mainTabBar = new TabBar();
			mainTabBar.layoutData = new AnchorLayoutData(5, 5, NaN, 5, NaN, NaN);
			mainTabBar.height = 50;
			mainTabBar.dataProvider = new ListCollection(
				[
					{ label:"Google News" },
					{ label:"RSS News" }
				]);
			
			mainTabBar.addEventListener(starling.events.Event.CHANGE, tabBarHandler);
			this.addChild(mainTabBar);
			
			this.addEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, transitionInComplete);
		}
		
		private function transitionInComplete(event:starling.events.Event):void
		{
			this.removeEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, transitionInComplete);
			newsLoader.load(new URLRequest("https://news.google.com/news/feeds?q="+searchTerm+"&output=rss"));
		}
		
		private function tabBarHandler(event:starling.events.Event):void
		{
			if(mainTabBar.selectedItem.label == "Google News")
			{
				newsLoader.load(new URLRequest("https://news.google.com/news/feeds?q="+searchTerm+"&output=rss"));
			} else {
				newsLoader.load(new URLRequest("http://rss.nytimes.com/services/xml/rss/nyt/NYRegion.xml"));
			}
		}
		
		private function newsLoaded(event:flash.events.Event):void
		{
			this.removeEventListener(flash.events.Event.COMPLETE, newsLoaded);
			
			var myXMLList:XMLList = new XMLList(newsLoader.data);			
			newsList.dataProvider = new ListCollection(myXMLList.channel.item);
		}		
		
		private function newsListHandler(event:starling.events.Event):void
		{
			this._data.newsinfo = newsList.selectedItem;
			dispatchEventWith(GO_NEWS_DETAILS);
		}
		
		private function goBack():void
		{
			this.dispatchEventWith(starling.events.Event.COMPLETE);
		}
	}
}