package businessScreens
{
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
	
	public class DirectoryScreen extends PanelScreen
	{
		public static const GO_CATEGORY_DETAILS:String = "goCategoryDetails";
		
		private var businessList:List;
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
			
			this.title = "Business Directory";
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
						
			businessList = new List();
			businessList.layoutData =  new AnchorLayoutData(0, 0, 0, 0, NaN, NaN);
			businessList.addEventListener(starling.events.Event.CHANGE, businessListHandler);
						
			businessList.itemRendererFactory = function():IListItemRenderer
			{
				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				renderer.isQuickHitAreaEnabled = true;
				renderer.labelField = "label";
				renderer.iconSourceField = "icon";
				
				renderer.accessoryFunction = function():ImageLoader{
					var loader:ImageLoader = new ImageLoader();
					loader.width = 35;
					loader.height = 35;
					loader.snapToPixels = true;
					loader.source = "assets/icons/ic_chevron_right_white_48dp.png";
					return loader;
				}
				
				return renderer;
			}
			
			this.addChild(businessList);
			
			this.addEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, transitionInComplete);
		}
		
		private function transitionInComplete(event:starling.events.Event):void
		{
			this.removeEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, transitionInComplete);
			
			businessList.dataProvider = new ListCollection(
				[
					{label:"Arts & Entertainment", icon:"https://ss1.4sqi.net/img/categories_v2/arts_entertainment/default_bg_32-78db8c2bded4dc431381277ba99b4b15.png", category:"4d4b7104d754a06370d81259"},
					{label:"Colleges & Universities", icon:"https://ss0.4sqi.net/img/categories_v2/education/default_bg_32-b46e923f784924ee604bd32df8e4b05b.png", category:"4d4b7105d754a06372d81259"},
					{label:"Events", icon:"https://ss0.4sqi.net/img/categories_v2/event/default_bg_32-c9c920d22c5e652116e0c732bf3dbd5d.png", category:"4d4b7105d754a06373d81259"},
					{label:"Recreation", icon:"https://ss1.4sqi.net/img/categories_v2/parks_outdoors/default_bg_32-9aa65094c88446b54f98b23a958156f7.png", category:"4d4b7105d754a06377d81259"},
					{label:"Restaurants", icon:"https://ss1.4sqi.net/img/categories_v2/food/default_bg_32-ed3a94563906ecfc0e8200f889bb7b3e.png", category:"4d4b7105d754a06374d81259"},
					{label:"Travel & Transport", icon:"https://ss1.4sqi.net/img/categories_v2/travel/default_bg_32-d6eac6866a94501358882c2b80bba3fe.png", category:"4d4b7105d754a06379d81259"},
					{label:"Others", icon:"https://ss1.4sqi.net/img/categories_v2/building/default_bg_32-db7353b37805a5b08e2326bcdb2292cc.png", category:"4d4b7105d754a06375d81259"}
				]);
		}
		
		private function businessListHandler(event:starling.events.Event):void
		{
			this._data.categoryinfo = businessList.selectedItem;
			dispatchEventWith(GO_CATEGORY_DETAILS);
		}
		
		private function goBack(event:Event):void{
			this.dispatchEventWith(Event.COMPLETE);
		}
		
	}	
}