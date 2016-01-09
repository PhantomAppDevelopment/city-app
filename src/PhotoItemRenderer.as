package
{
	import feathers.controls.ImageLoader;
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.utils.touch.TapToSelect;
	
	import starling.display.Image;
	
	public class PhotoItemRenderer extends LayoutGroupListItemRenderer
	{
		protected var _image:ImageLoader;
		private var _select:TapToSelect;
				
		public function PhotoItemRenderer()
		{
			super();
			this._select = new TapToSelect(this);
		}
			
		override protected function initialize():void
		{
			this.layout = new AnchorLayout();
			
			_image = new ImageLoader();
			_image.layoutData = new AnchorLayoutData(0, 0, 0, 0, NaN, NaN);
			_image.width = 70;
			_image.height = 70;
			this.addChild(_image);			
		}
		
		override protected function commitData():void
		{
			if(this._data && this._owner)
			{
				_image.source = 'http://farm'+data.@farm+'.staticflickr.com/'+data.@server+'/'+data.@id+'_'+data.@secret+'_s.jpg';
			} else
			{
				_image.source = null;
			}
		}
	}
}