package
{
	import flash.text.TextFormat;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontLookup;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.PanelScreen;
	import feathers.controls.ScrollText;
	import feathers.controls.TabBar;
	import feathers.controls.ToggleButton;
	import feathers.controls.renderers.BaseDefaultItemRenderer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.text.StageTextTextEditor;
	import feathers.controls.text.TextBlockTextRenderer;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.ITextEditor;
	import feathers.core.ITextRenderer;
	import feathers.themes.StyleNameFunctionTheme;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class CustomTheme extends StyleNameFunctionTheme
	{
		[Embed(source="assets/font.otf", fontFamily="MyFont", fontWeight="normal", fontStyle="normal", mimeType="application/x-font", embedAsCFF="true")]
		private static const MY_FONT:Class;

		public function CustomTheme()
		{
			super();			
			this.initialize();
		}
		
		private function initialize():void
		{
			this.initializeGlobals();
			this.initializeStyleProviders();	
		}
		
		private function initializeGlobals():void
		{
			FeathersControl.defaultTextRendererFactory = function():ITextRenderer
			{
				return new TextBlockTextRenderer();
			}
			
			FeathersControl.defaultTextEditorFactory = function():ITextEditor
			{
				return new StageTextTextEditor();
			}
		}
		
		private function initializeStyleProviders():void
		{
			this.getStyleProviderForClass(Button).setFunctionForStyleName("back-button", this.setBackButtonStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName("transparent-button", this.setTransparentButtonStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName("header-button", this.setHeaderButtonStyles);
			this.getStyleProviderForClass(DefaultListItemRenderer).defaultStyleFunction = this.setItemRendererStyles;
			this.getStyleProviderForClass(Header).defaultStyleFunction = this.setHeaderStyles;
			this.getStyleProviderForClass(Label).defaultStyleFunction = this.setLabelStyles;
			this.getStyleProviderForClass(List).defaultStyleFunction = this.setListStyles;
			this.getStyleProviderForClass(PanelScreen).defaultStyleFunction = this.setPanelScreenStyles;
			this.getStyleProviderForClass(ToggleButton).setFunctionForStyleName(TabBar.DEFAULT_CHILD_STYLE_NAME_TAB, this.setTabStyles);
			this.getStyleProviderForClass(ScrollText).defaultStyleFunction = this.setScrollTextStyles;
		}
		
		private function createBlackGradient():Quad
		{
			var blackGradient:Quad = new Quad(3, 50);
			blackGradient.setVertexColor(0, 0x333333);
			blackGradient.setVertexColor(1, 0x333333);
			blackGradient.setVertexColor(2, 0x000000);
			blackGradient.setVertexColor(3, 0x000000);			
			return blackGradient;
		}
		
		private function createSmallBlueGradient():Quad
		{
			var blueQuad:Quad = new Quad(3, 5);
			blueQuad.y = 45;
			blueQuad.setVertexColor(0, 0x2CB1E1);
			blueQuad.setVertexColor(1, 0x2CB1E1);
			blueQuad.setVertexColor(2, 0x12A0CF);
			blueQuad.setVertexColor(3, 0x12A0CF);			
			return blueQuad;
		}
		
		private function createSmallBlueOpaqueGradient():Quad
		{
			var blueQuad:Quad = new Quad(3, 5);
			blueQuad.y = 45;
			blueQuad.alpha = 0.5;
			blueQuad.setVertexColor(0, 0x2CB1E1);
			blueQuad.setVertexColor(1, 0x2CB1E1);
			blueQuad.setVertexColor(2, 0x12A0CF);
			blueQuad.setVertexColor(3, 0x12A0CF);			
			return blueQuad;
		}
		
		//-------------------------
		// Button
		//-------------------------
		
		private function setBackButtonStyles(button:Button):void
		{
			var transparentQuad:Quad = new Quad(3, 3, 0xFFFFFF);
			transparentQuad.alpha = 0.20;
			
			var arrowIcon:ImageLoader = new ImageLoader();
			arrowIcon.width = arrowIcon.height = 25;
			arrowIcon.source = "assets/icons/ic_arrow_back_white_48dp.png";
			
			button.width = button.height = 45;
			button.defaultIcon = arrowIcon;
			button.downSkin = transparentQuad;
		}
		
		private function setTransparentButtonStyles(button:Button):void
		{
			var quad:Quad = new Quad(3, 3, 0xFFFFF);
			quad.alpha = 0;
			
			button.defaultSkin = quad;
			button.downSkin = quad;
		}
		
		//-------------------------
		// Header
		//-------------------------
		
		private function setHeaderStyles(header:Header):void
		{
			var topColor:uint = 0x222222;
			var bottomColor:uint = 0x000000;
			
			var quad:Quad = new Quad(1, 50);
			quad.setVertexColor(0, topColor);
			quad.setVertexColor(1, topColor);
			quad.setVertexColor(2, bottomColor);
			quad.setVertexColor(3, bottomColor);
			
			header.titleFactory = function():ITextRenderer
			{
				var font:FontDescription = new FontDescription("MyFont");
				font.fontLookup = FontLookup.EMBEDDED_CFF;
				
				var titleRenderer:TextBlockTextRenderer = new TextBlockTextRenderer();
				titleRenderer.elementFormat =new ElementFormat(font, 16, 0xFFFFFF);
				return titleRenderer;
			}
			
			header.gap = 10;
			header.titleAlign = Header.TITLE_ALIGN_PREFER_LEFT;
			header.backgroundSkin = quad;
		}
		
		private function setHeaderButtonStyles(button:Button):void
		{
			var transparentQuad:Quad = new Quad(3, 3, 0xFFFFFF);
			transparentQuad.alpha = 0.2;
			
			var invisibleQuad:Quad = new Quad(3, 3, 0xFFFFFF);
			invisibleQuad.alpha = 0.0
			
			button.defaultSkin = invisibleQuad;
			button.downSkin = transparentQuad;
		}		
		
		//-------------------------
		// Label
		//-------------------------
		
		private function setLabelStyles(label:Label):void
		{
			label.textRendererFactory = function():ITextRenderer
			{
				var font:FontDescription = new FontDescription("MyFont");
				font.fontLookup = FontLookup.EMBEDDED_CFF;
				
				var renderer:TextBlockTextRenderer = new TextBlockTextRenderer();
				renderer.elementFormat = new ElementFormat(font, 20, 0xFFFFFF);
				return renderer;
			}
		}
		
		//-------------------------
		// List
		//-------------------------
		
		private function setListStyles(list:List):void
		{
			list.backgroundSkin = new Quad(3, 3, 0x444444);
		}
		
		private function setItemRendererStyles(renderer:BaseDefaultItemRenderer):void
		{			
			renderer.defaultSkin = new Quad(3, 3, 0x333333);
			renderer.defaultSelectedSkin = new Quad(3, 3, 0x11A9FF);
			renderer.downSkin = new Quad(3, 3, 0x11A9FF);
			
			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingLeft = 10;
			renderer.paddingRight = 0;
			renderer.paddingTop = 10;
			renderer.paddingBottom = 10;
			renderer.gap = 10;
			renderer.minHeight = 55;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.iconPosition = Button.ICON_POSITION_LEFT;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.labelFactory = function():ITextRenderer
			{
				var renderer:TextFieldTextRenderer = new TextFieldTextRenderer();
				renderer.isHTML = true;
				renderer.wordWrap = true;
				
				var format:TextFormat = new TextFormat("_sans", 14, 0xFFFFFF);
				format.leading = 7;
				
				renderer.textFormat = format;
				return renderer;
			};
		}	
		
		//-------------------------
		// PanelScreen
		//-------------------------
		
		private function setPanelScreenStyles(screen:PanelScreen):void
		{
			screen.backgroundSkin = new Quad(3, 3, 0x333333);
		}
		
		//-------------------------
		// TabBar
		//-------------------------
		
		private function setTabStyles(button:ToggleButton):void
		{					
			var defaultSkin:Sprite = new Sprite();						
			defaultSkin.addChild(createBlackGradient());						
			defaultSkin.addChild(createSmallBlueOpaqueGradient());
			
			var defaultSelectedSkin:Sprite = new Sprite();
			defaultSelectedSkin.addChild(createBlackGradient());						
			defaultSelectedSkin.addChild(createSmallBlueGradient());
			
			button.defaultSkin = defaultSkin;
			button.downSkin = defaultSelectedSkin;
			button.selectedDownSkin = defaultSelectedSkin;
			button.defaultSelectedSkin = defaultSelectedSkin;
			
			button.labelFactory = function():ITextRenderer
			{
				var renderer:TextBlockTextRenderer = new TextBlockTextRenderer();
				
				var font:FontDescription = new FontDescription("MyFont");
				font.fontLookup = FontLookup.EMBEDDED_CFF;
				
				renderer.elementFormat =new ElementFormat(font, 14, 0xFFFFFF);
				return renderer;
			}
		}
		
		//-------------------------
		// ScrollText
		//-------------------------
		
		private function setScrollTextStyles(scrolltext:ScrollText):void
		{
			scrolltext.textFormat = new TextFormat("_sans", 12, 0xFFFFFF);
			scrolltext.isHTML = true;
		}
		
	}
}