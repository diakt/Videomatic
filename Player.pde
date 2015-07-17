import processing.video.*;

class Player {

	public float speed;
	public Movie movie;
	int style[];
	int styleIndex;
	int blurIndex;
	int iframe;

	public int filterStyle[] = new int[] {
		THRESHOLD, 
		GRAY, 
		OPAQUE, 
		INVERT, 
		POSTERIZE, 
		BLUR, 
		ERODE, 
		DILATE
	};
	
	public int blendStyle[] = new int[] {
		ADD, 
		SUBTRACT, 
		LIGHTEST, 
		DARKEST, 
		DIFFERENCE, 
		MULTIPLY, 
		SCREEN, 
		OVERLAY, 
		HARD_LIGHT, 
		SOFT_LIGHT, 
		DODGE, 
		BURN
	};

	Player(PApplet applet, String path, int frame) {
		speed = 1;
		style = new int[]{GRAY, OPAQUE, INVERT, ERODE, DILATE};
		styleIndex = 0;
		blurIndex = int(random(2, 10));

		movie = new Movie(applet, path);
		movie.jump(frame);
	}

	void draw() {
		image(movie, 0, 0, width, height);
		iframe = frameCount % 100;
		
		if (frameCount % 20 == 0 ) {
			styleIndex = int(random(0, 4));
			println("styleIndex: "+styleIndex);
		}
		
		if (iframe % 10 == 0 ||
	        iframe % 11 == 0 ||
	        iframe % 13 == 0 ||
	        iframe % 12 == 0 ||
	        iframe % 16 == 0 ||
	        iframe % 17 == 0
		   ) {

			filter( POSTERIZE, int(random(2, 16)) );

		}

		filter( style[ styleIndex ] );
		
		if (iframe > 55 && iframe < 66) {
			//filter(BLUR, blurIndex);
		}
		
		movie.speed(speed);
	}

	void mousePressed() {
		//speed = map( mouseX, 0, width, -2, 2 );
		//movie.speed(speed);
	}

	Movie getMovie() {
		return movie;
	}
}