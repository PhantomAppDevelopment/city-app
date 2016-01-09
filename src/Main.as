package
{
	import businessScreens.CategoryDetailsScreen;
	import businessScreens.DirectoryScreen;
	import businessScreens.MapScreen;
	
	import feathers.controls.StackScreenNavigator;
	import feathers.controls.StackScreenNavigatorItem;
	import feathers.motion.Slide;
	
	import mediaScreens.MediaScreen;
	import mediaScreens.VideoDetailsScreen;
	
	import newsScreens.NewsDetailsScreen;
	import newsScreens.NewsScreen;
	
	import photoScreens.PhotosScreen;
	
	import screens.AboutScreen;
	import screens.HomeScreen;
	
	import starling.display.Sprite;
	import starling.events.Event;

	public class Main extends Sprite
	{
		public function Main()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private var myNavigator:StackScreenNavigator;
		
		private var NAVIGATOR_DATA:NavigatorData;
		
		private static const HOME_SCREEN:String = "homeScreen";
		private static const ABOUT_SCREEN:String = "aboutScreen";
		private static const NEWS_SCREEN:String = "newsScreen";
		private static const NEWS_DETAILS_SCREEN:String = "newsDetailsScreen";
		private static const DIRECTORY_SCREEN:String = "directoryScreen";
		private static const CATEGORY_DETAILS:String = "categoryDetails";
		private static const MAP_SCREEN:String = "mapScreen";
		private static const PHOTOS_SCREEN:String = "photosScreen";
		private static const MEDIA_SCREEN:String = "mediaScreen";
		private static const VIDEO_DETAILS_SCREEN:String = "videoDetailsScreen";
		
		protected function addedToStageHandler(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			this.NAVIGATOR_DATA = new NavigatorData();
			
			new CustomTheme();
			
			myNavigator = new StackScreenNavigator();
			myNavigator.pushTransition = Slide.createSlideLeftTransition();
			myNavigator.popTransition = Slide.createSlideRightTransition();
			addChild(myNavigator);
			
			var HomeScreenItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(HomeScreen);
			HomeScreenItem.setScreenIDForPushEvent(HomeScreen.GO_ABOUT, ABOUT_SCREEN);
			HomeScreenItem.setScreenIDForPushEvent(HomeScreen.GO_NEWS, NEWS_SCREEN);
			HomeScreenItem.setScreenIDForPushEvent(HomeScreen.GO_DIRECTORY, DIRECTORY_SCREEN);
			HomeScreenItem.setScreenIDForPushEvent(HomeScreen.GO_PHOTOS, PHOTOS_SCREEN);
			HomeScreenItem.setScreenIDForPushEvent(HomeScreen.GO_MEDIA, MEDIA_SCREEN);
			myNavigator.addScreen(HOME_SCREEN, HomeScreenItem);
			
			var aboutScreenItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(AboutScreen);
			aboutScreenItem.addPopEvent(Event.COMPLETE);
			myNavigator.addScreen(ABOUT_SCREEN, aboutScreenItem);
			
			var newsScreenItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(NewsScreen);
			newsScreenItem.properties.data = NAVIGATOR_DATA;
			newsScreenItem.setScreenIDForPushEvent(NewsScreen.GO_NEWS_DETAILS, NEWS_DETAILS_SCREEN);
			newsScreenItem.addPopEvent(Event.COMPLETE);
			myNavigator.addScreen(NEWS_SCREEN, newsScreenItem);
			
			var newsDetailsScreenItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(NewsDetailsScreen);
			newsDetailsScreenItem.properties.data = NAVIGATOR_DATA;
			newsDetailsScreenItem.addPopEvent(Event.COMPLETE);
			myNavigator.addScreen(NEWS_DETAILS_SCREEN, newsDetailsScreenItem);
			
			var directoryScreenItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(DirectoryScreen);
			directoryScreenItem.properties.data = NAVIGATOR_DATA;
			directoryScreenItem.setScreenIDForPushEvent(DirectoryScreen.GO_CATEGORY_DETAILS, CATEGORY_DETAILS);
			directoryScreenItem.addPopEvent(Event.COMPLETE);
			myNavigator.addScreen(DIRECTORY_SCREEN, directoryScreenItem);
			
			var categoryDetailsScreenItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(CategoryDetailsScreen);
			categoryDetailsScreenItem.properties.data = NAVIGATOR_DATA;
			categoryDetailsScreenItem.setScreenIDForPushEvent(CategoryDetailsScreen.GO_VENUE_DETAILS, MAP_SCREEN);
			categoryDetailsScreenItem.addPopEvent(Event.COMPLETE);
			myNavigator.addScreen(CATEGORY_DETAILS, categoryDetailsScreenItem);
			
			var mapScreenItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(MapScreen);
			mapScreenItem.properties.data = NAVIGATOR_DATA;
			mapScreenItem.addPopEvent(Event.COMPLETE);
			myNavigator.addScreen(MAP_SCREEN, mapScreenItem);
			
			var photosScreenItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(PhotosScreen);
			photosScreenItem.addPopEvent(Event.COMPLETE);
			myNavigator.addScreen(PHOTOS_SCREEN, photosScreenItem);
			
			var mediaScreenItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(MediaScreen);
			mediaScreenItem.properties.data = NAVIGATOR_DATA;
			mediaScreenItem.setScreenIDForPushEvent(MediaScreen.GO_VIDEO_DETAILS, VIDEO_DETAILS_SCREEN);
			mediaScreenItem.addPopEvent(Event.COMPLETE);
			myNavigator.addScreen(MEDIA_SCREEN, mediaScreenItem);
			
			var videoDetailsScreenItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(VideoDetailsScreen);
			videoDetailsScreenItem.properties.data = NAVIGATOR_DATA;
			videoDetailsScreenItem.addPopEvent(Event.COMPLETE);
			myNavigator.addScreen(VIDEO_DETAILS_SCREEN, videoDetailsScreenItem);
			
			myNavigator.rootScreenID = HOME_SCREEN;
		}
		
	}
}