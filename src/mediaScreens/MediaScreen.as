package mediaScreens
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
	
	public class MediaScreen extends PanelScreen
	{
		public static const GO_VIDEO_DETAILS:String = "goVideoDetails";
		
		private var mainTabBar:TabBar;
		private var videosList:List;
		private var youtubeLoader:URLLoader;
		
		private static const YOUTUBE_API_KEY:String = "";
		private var searchTerm:String = "New York City";
		private var pageToken:String;
		private var loading:Boolean;
		
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
			
			this.title = "Media";
			this.layout = new AnchorLayout();
			this.backButtonHandler = goBack;
			
			pageToken = "";
			
			youtubeLoader = new URLLoader();
			youtubeLoader.dataFormat = URLLoaderDataFormat.TEXT;
			youtubeLoader.addEventListener(flash.events.Event.COMPLETE, youtubeVideosLoaded);

			var backButton:Button = new Button();
			backButton.styleNameList.add("back-button");
			backButton.addEventListener(starling.events.Event.TRIGGERED, goBack);
			this.headerProperties.leftItems = new <DisplayObject>[backButton];
			
			videosList = new List();
			videosList.addEventListener(starling.events.Event.CHANGE, selectVideo);
			videosList.addEventListener(starling.events.Event.SCROLL, scrollHandler);
			videosList.layoutData = new AnchorLayoutData(60, 0, 0, 0, NaN, NaN);
			videosList.itemRendererFactory = function():IListItemRenderer
			{
				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				//Our item renderer has no special interaction, this property greatly increases performance.
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
				
				renderer.iconLoaderFactory = function():ImageLoader
				{
					var loader:ImageLoader = new ImageLoader();
					loader.width = 70;
					loader.height = 60;
					return loader;
				}
				
				renderer.iconSourceFunction = function(item:Object):String
				{
					return item.snippet.thumbnails["default"].url;
				}
					
				renderer.labelFunction = function(item:Object):String
				{
					return "<b>" + item.snippet.title + "</b>\n" + item.snippet.channelTitle;
				}
				
				return renderer;				
			}
			
			this.addChild(videosList);
			
			mainTabBar = new TabBar();
			mainTabBar.layoutData = new AnchorLayoutData(5, 5, NaN, 5, NaN, NaN);
			mainTabBar.height = 50;
			mainTabBar.dataProvider = new ListCollection(
				[
					{ label:"Popular Videos" },
					{ label:"Recent Videos" }
				]);
			
			//Add the event listener after you set its dataprovider to avoid it firing automatically.
			mainTabBar.addEventListener(starling.events.Event.CHANGE, changeSearch);
			this.addChild(mainTabBar);
			
			this.addEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, transitionInComplete);
		}
		
		private function transitionInComplete(event:starling.events.Event):void
		{	
			this.removeEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, transitionInComplete);		
			
			//Loading the Youtube API after everything has been added to the stage to avoid slowdowns.
			youtubeLoader.load(new URLRequest("https://www.googleapis.com/youtube/v3/search?q="+searchTerm+"&maxResults=50&order=relevance&type=video&part=snippet&key="+YOUTUBE_API_KEY));	
		}
		
		protected function changeSearch(event:starling.events.Event):void
		{	
			pageToken = "";
			
			if(mainTabBar.selectedItem.label == "Popular Videos")
			{
				youtubeLoader.load(new URLRequest("https://www.googleapis.com/youtube/v3/search?q="+searchTerm+"&maxResults=50&order=relevance&type=video&part=snippet&key="+YOUTUBE_API_KEY));
			} else {
				youtubeLoader.load(new URLRequest("https://www.googleapis.com/youtube/v3/search?q="+searchTerm+"&maxResults=50&order=date&type=video&part=snippet&key="+YOUTUBE_API_KEY));
			}
			
			videosList.dataProvider = null;
		}
		
		private function youtubeVideosLoaded(event:flash.events.Event):void
		{			
			//Convert the JSON data to an object
			var rawData:Object = JSON.parse(String(youtubeLoader.data));
			pageToken = rawData.nextPageToken;
			
			if(videosList.dataProvider == null){
				var videosArray:ListCollection = new ListCollection(rawData.items as Array);
				videosList.dataProvider = videosArray;
			} else {
				for each (var item:* in rawData.items){
					videosList.dataProvider.addItem(item);
				}
			}			
			
			loading = false;
		}
		
		private function loadMore():void
		{
			if(!loading){
				loading = true;
				
				if(mainTabBar.selectedItem.label == "Popular Videos"){
					youtubeLoader.load(new URLRequest("https://www.googleapis.com/youtube/v3/search?q="+searchTerm+"&maxResults=50&pageToken="+pageToken+"&order=relevance&type=video&part=snippet&key="+YOUTUBE_API_KEY));
				} else {
					youtubeLoader.load(new URLRequest("https://www.googleapis.com/youtube/v3/search?q="+searchTerm+"&maxResults=50&pageToken="+pageToken+"&order=date&type=video&part=snippet&key="+YOUTUBE_API_KEY));
				}
			}
		}
		
		private function scrollHandler(event:starling.events.Event):void
		{
			if(videosList.verticalScrollPosition == (videosList.viewPort.height - videosList.height))
			{
				loadMore();
			}
		}
		
		private function selectVideo(event:starling.events.Event):void
		{
			this._data.videoinfo = videosList.selectedItem;
			dispatchEventWith(GO_VIDEO_DETAILS);
		}
		
		private function goBack():void
		{
			this.dispatchEventWith(starling.events.Event.COMPLETE);
		}
	}
}