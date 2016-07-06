package photoScreens
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import feathers.controls.PanelScreen;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.PopUpManager;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.TiledRowsLayout;
	
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.utils.ScaleMode;
	
	public class PhotosScreen extends PanelScreen
	{
		
		private var photosList:List;
		private var flickrLoader:URLLoader;
		private var popup:LayoutGroup;
		private var searchTerm:String = "Cities";
		private var popupOpen:Boolean;
		private var bigImage:ImageLoader;
		private var photoTitle:Label;
		private var blackBar:ImageLoader;
		
		private static const FLICKR_API_KEY:String = "";
		
		override protected function initialize():void
		{
			super.initialize();
			
			this.title = "Photos";
			this.layout = new AnchorLayout();
			this.backButtonHandler = goBack;
			
			popupOpen = false;
			
			var backButton:Button = new Button();
			backButton.styleNameList.add("back-button");
			backButton.addEventListener(starling.events.Event.TRIGGERED, goBack);
			this.headerProperties.leftItems = new <DisplayObject>[backButton];
			
			var tiledLayout:TiledRowsLayout = new TiledRowsLayout();
			tiledLayout.gap = 20;
			
			photosList = new List();
			photosList.addEventListener(starling.events.Event.CHANGE, listHandler);
			photosList.layoutData = new AnchorLayoutData(0, 0, 0, 0, NaN, NaN);
			photosList.layout = tiledLayout;
			photosList.paddingTop = 15;
			photosList.paddingBottom = 15;
			photosList.itemRendererFactory = function():IListItemRenderer
			{
				var renderer:PhotoItemRenderer = new PhotoItemRenderer();
				renderer.isQuickHitAreaEnabled = true;
				
				return renderer;				
			}
				
			this.addChild(photosList);
			
			flickrLoader = new URLLoader();
			flickrLoader.dataFormat = URLLoaderDataFormat.TEXT;
			flickrLoader.addEventListener(flash.events.Event.COMPLETE, flickrLoaded);
			
			this.addEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, transitionInComplete);
		}
		
		private function transitionInComplete(event:starling.events.Event):void
		{
			this.removeEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, transitionInComplete);
			flickrLoader.load(new URLRequest("https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key="+FLICKR_API_KEY+"&text="+searchTerm+"a&sort=relevance&format=rest"));	
		}
		
		private function flickrLoaded(fevent:flash.events.Event):void
		{
			var myXMLList:XMLList = new XMLList(flickrLoader.data);			
			photosList.dataProvider = new ListCollection(myXMLList.photos.photo);
		}
		
		private function resizePopUp():void
		{
			if(popupOpen)
			{
				PopUpManager.centerPopUp(popup);
				
				bigImage.width = stage.stageWidth;
				bigImage.height = stage.stageHeight;
				
				photoTitle.width = stage.stageWidth;
				blackBar.width = stage.stageWidth;
			}
		}
		
		private function listHandler(event:starling.events.Event):void
		{
			popupOpen = true;
						
			popup = new LayoutGroup();
			popup.layout = new AnchorLayout();
						
			bigImage = new ImageLoader();
			bigImage.width = stage.stageWidth;
			bigImage.height = stage.stageHeight;
			bigImage.padding = 20;
			bigImage.source = 'http://farm'+photosList.selectedItem.@farm+'.staticflickr.com/'+photosList.selectedItem.@server+'/'+photosList.selectedItem.@id+'_'+photosList.selectedItem.@secret+'_z.jpg';
			popup.addChild(bigImage);
			
			var closeIcon:ImageLoader = new ImageLoader();
			closeIcon.source = "assets/icons/ic_highlight_off_white_48dp.png";
			closeIcon.width = 25;
			closeIcon.height = 25;
			
			var closeButton:Button = new Button();
			closeButton.addEventListener(starling.events.Event.TRIGGERED, closePopup);
			closeButton.layoutData = new AnchorLayoutData(0, 0, NaN, NaN, NaN, NaN);
			closeButton.padding = 10;
			closeButton.width = 45;
			closeButton.height = 45;
			closeButton.styleNameList.add("header-button");
			closeButton.defaultIcon = closeIcon;
			popup.addChild(closeButton);
			
			blackBar = new ImageLoader();
			blackBar.source = "assets/icons/black.png";
			blackBar.layoutData = new AnchorLayoutData(NaN, 0, 0, 0, NaN, NaN);
			blackBar.scaleMode = ScaleMode.NO_BORDER;
			blackBar.width = stage.stageWidth;
			blackBar.height = 40;
			popup.addChild(blackBar);
						
			photoTitle = new Label();
			photoTitle.layoutData = new AnchorLayoutData(NaN, 0, 0, 0, NaN, NaN);
			photoTitle.width = stage.stageWidth;
			photoTitle.paddingLeft = 20;
			photoTitle.paddingRight = 20;
			photoTitle.paddingBottom = 15;
			photoTitle.text = photosList.selectedItem.@title;
			popup.addChild(photoTitle);
			photoTitle.textRendererProperties.elementFormat = new ElementFormat(new FontDescription("_sans"), 12, 0xFFFFFF);
						
			PopUpManager.addPopUp(popup, true, true, function():DisplayObject
			{
				var quad:Quad = new Quad(3, 3, 0x000000);
				quad.alpha = 0.50;
				return quad;				
			});
			
			this.addEventListener(starling.events.Event.RESIZE, resizePopUp);
		}
			
		private function closePopup(event:starling.events.Event):void
		{
			PopUpManager.removePopUp(popup, true);
			this.removeEventListener(starling.events.Event.RESIZE, resizePopUp);			
			popupOpen = false;
		}
		
		private function goBack():void
		{
			if(popupOpen)
			{
				PopUpManager.removePopUp(popup, true);
			}
			
			this.dispatchEventWith(starling.events.Event.COMPLETE);
		}
	}
}