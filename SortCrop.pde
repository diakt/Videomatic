
class SortCrop {
	
	public PImage img;
	
	PImage cropimg;
	boolean pixelMode = false;
	int copyWidth = 50;
	int copyHeight = 3;

	SortCrop(PImage defImg) {
		this.img = defImg;
		cropimg = defImg.get();
		cropimg.resize(width, height);		
	}

	void draw() {
		if (frameCount % 100 == 0) {
			cropimg = this.img.get();
			cropimg.resize(width, height);
		}
		
		pixelCrop(0, copyWidth, copyHeight, 127);
	}

	void pixelCrop(float angle, int cropWidth, int cropHeight, int velocity) {
		int x1 = floor( random( width ) );
		int y1 = floor( random( height ) );
		int x2 = floor( random( width ) );
		int y2 = floor( random( height ) );

		if ( pixelMode == true ) {
			
			color c1 = cropimg.get( x1, y1 );
			color c2 = cropimg.get( x2, y2 );
			cropimg.set( x1, y1, c2 );
			cropimg.set( x2, y2, c1 );

		} else {
			PImage crop1 = cropimg.get( x1, y1, cropWidth, cropHeight );
			PImage crop2 = cropimg.get( x2, y2, cropWidth, cropHeight );

			cropimg.set( x1, y1, crop2 );
			cropimg.set( x2, y2, crop1 );
		}

		image( cropimg, 0, 0 );
	}
}