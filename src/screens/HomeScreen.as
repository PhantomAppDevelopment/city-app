package screens
{
	import flash.system.System;
	
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.PanelScreen;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;
	
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.events.Event;
	
	public class HomeScreen extends PanelScreen
	{
	
		public static const GO_ABOUT:String = "goAbout";
		public static const GO_NEWS:String = "goNews";
		public static const GO_DIRECTORY:String = "goDirectory";
		public static const GO_PHOTOS:String = "goPhotos";
		public static const GO_MEDIA:String = "goMedia";
		
		override protected function initialize():void{
			super.initialize();
			
			this.title = "City App";
			this.layout = new VerticalLayout();			
			
			var aboutIcon:ImageLoader = new ImageLoader();
			aboutIcon.source = "assets/icons/ic_info_outline_white_48dp.png";
			aboutIcon.width = 25;
			aboutIcon.height = 25;
			aboutIcon.snapToPixels = true;
			
			var aboutButton:Button = new Button();
			aboutButton.width = 45;
			aboutButton.height = 45;
			aboutButton.styleNameList.add("header-button");
			aboutButton.defaultIcon = aboutIcon;
			aboutButton.addEventListener(starling.events.Event.TRIGGERED, goAbout);
			this.headerProperties.rightItems = new <DisplayObject>[aboutButton];
			this.headerProperties.paddingLeft = 10;						
			
			var mainGroupsLayoutData:VerticalLayoutData = new VerticalLayoutData(100, 25);
			
			//Orange Group
			
			var orangeGroup:LayoutGroup = new LayoutGroup();
			orangeGroup.layout = new AnchorLayout();
			orangeGroup.layoutData = mainGroupsLayoutData;
			
			var orangeQuad:Quad = new Quad(3, 3);
			orangeQuad.setVertexColor(0, 0xFFAE18);
			orangeQuad.setVertexColor(1, 0xFFAE18);
			orangeQuad.setVertexColor(2, 0xFF8A00);
			orangeQuad.setVertexColor(3, 0xFF8A00);
			orangeGroup.backgroundSkin = orangeQuad;			
			this.addChild(orangeGroup);
			
			orangeGroup.addChild(createArrowIcon());		
			orangeGroup.addChild(createLabel("NEWS"));
			orangeGroup.addChild(createIcon("assets/icons/rss.png"));
						
			var newsButton:Button = new Button();
			newsButton.addEventListener(Event.TRIGGERED, newsButtonHandler);
			newsButton.layoutData = new AnchorLayoutData(0, 0, 0, 0)			
			orangeGroup.addChild(newsButton);
			newsButton.styleNameList.add("transparent-button");
			
			//Blue Group
			
			var blueGroup:LayoutGroup = new LayoutGroup();
			blueGroup.layout = new AnchorLayout();
			blueGroup.layoutData = mainGroupsLayoutData;
			var blueQuad:Quad = new Quad(3, 3);
			blueQuad.setVertexColor(0, 0x2CB1E1);
			blueQuad.setVertexColor(1, 0x2CB1E1);
			blueQuad.setVertexColor(2, 0x12A0CF);
			blueQuad.setVertexColor(3, 0x12A0CF);
			blueGroup.backgroundSkin = blueQuad;			
			this.addChild(blueGroup);
			
			blueGroup.addChild(createArrowIcon());
			blueGroup.addChild(createLabel("DIRECTORY"));
			blueGroup.addChild(createIcon("assets/icons/ic_store_white_48dp.png"));
			
			var directoryButton:Button = new Button();
			directoryButton.addEventListener(Event.TRIGGERED, directoryButtonHandler);
			directoryButton.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			blueGroup.addChild(directoryButton);
			directoryButton.styleNameList.add("transparent-button");
			
			//Green Group
			
			var greenGroup:LayoutGroup = new LayoutGroup();
			greenGroup.layout = new AnchorLayout();
			greenGroup.layoutData = mainGroupsLayoutData;
			var greenQuad:Quad = new Quad(3, 3);
			greenQuad.setVertexColor(0, 0x92C500);
			greenQuad.setVertexColor(1, 0x92C500);
			greenQuad.setVertexColor(2, 0x669900);
			greenQuad.setVertexColor(3, 0x669900);
			greenGroup.backgroundSkin = greenQuad;			
			this.addChild(greenGroup);
			
			greenGroup.addChild(createArrowIcon());
			greenGroup.addChild(createLabel("PHOTOS"));
			greenGroup.addChild(createIcon("assets/icons/ic_local_see_white_48dp.png"));
			
			var photosButton:Button = new Button();
			photosButton.addEventListener(Event.TRIGGERED, photosButtonHandler);
			photosButton.layoutData = new AnchorLayoutData(0, 0, 0, 0)			
			greenGroup.addChild(photosButton);
			photosButton.styleNameList.add("transparent-button");
			
			//Red Group
			
			var redGroup:LayoutGroup = new LayoutGroup();
			redGroup.layout = new AnchorLayout();
			redGroup.layoutData = mainGroupsLayoutData;
			var redQuad:Quad = new Quad(3, 3);
			redQuad.setVertexColor(0, 0xE92727);
			redQuad.setVertexColor(1, 0xE92727);
			redQuad.setVertexColor(2, 0xCC0000);
			redQuad.setVertexColor(3, 0xCC0000);
			redGroup.backgroundSkin = redQuad;			
			this.addChild(redGroup);
			
			redGroup.addChild(createArrowIcon());
			redGroup.addChild(createLabel("MEDIA"));
			redGroup.addChild(createIcon("assets/icons/ic_theaters_white_48dp.png"));
			
			var mediaButton:Button = new Button();
			mediaButton.addEventListener(Event.TRIGGERED, mediaButtonHandler);
			mediaButton.layoutData = new AnchorLayoutData(0, 0, 0, 0)			
			redGroup.addChild(mediaButton);
			mediaButton.styleNameList.add("transparent-button");
		}
		
		private function createIcon(value:String):ImageLoader
		{
			var icon:ImageLoader = new ImageLoader();
			icon.source = value;
			icon.width = 40;
			icon.height = 40;
			icon.snapToPixels = true;
			icon.layoutData = new AnchorLayoutData(NaN, NaN, NaN, 20, NaN, 0);
			return icon;
		}
		
		private function createArrowIcon():ImageLoader
		{
			var arrowIcon:ImageLoader = new ImageLoader();
			arrowIcon.source = "assets/icons/ic_chevron_right_white_48dp.png";
			arrowIcon.width = 45;
			arrowIcon.height = 45;
			arrowIcon.snapToPixels = true;
			arrowIcon.layoutData = new AnchorLayoutData(NaN, 5, NaN, NaN, NaN, 0);
			return arrowIcon;
		}
				
		private function createLabel(value:String):Label
		{
			var label:Label = new Label();
			label.text = value;
			label.layoutData = new AnchorLayoutData(NaN, NaN, NaN, 80, NaN, 0);
			return label;
		}
		
		private function goAbout(event:Event):void
		{
			dispatchEventWith(GO_ABOUT);
		}
		
		private function newsButtonHandler(event:Event):void
		{
			dispatchEventWith(GO_NEWS);	
		}
		
		private function directoryButtonHandler(event:Event):void
		{
			dispatchEventWith(GO_DIRECTORY);
		}
		
		private function photosButtonHandler(event:Event):void
		{
			dispatchEventWith(GO_PHOTOS);
		}
		
		private function mediaButtonHandler(event:Event):void
		{
			dispatchEventWith(GO_MEDIA);
		}
	}
}