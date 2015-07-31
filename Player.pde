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
		style = new int[]{GRAY, OPAQUE, INVERT, ERODE};
		styleIndex = 0;
		blurIndex = int(random(2, 10));

		movie = new Movie(applet, path);
		movie.jump(frame);
	}

	void draw() {
		image(movie, 0, 0, width, height);
		iframe = int(frameCount/2) % 100;
		
		if (iframe % 20 == 0 ) {
			styleIndex = int(random(0, style.length - 1));
			println("styleIndex: "+styleIndex);
		}
		
		if (iframe > 11 && iframe < 22) {
			filter( POSTERIZE, int(random(2, 16)) );
		} else if (iframe > 55 && iframe < 66) {
			filter(THRESHOLD, random(0.25, 0.75));
		}
		//filter( BLUR, blurIndex );
		
		filter( style[ styleIndex ] );
		
	}

	void mousePressed() {
		//speed = map( mouseX, 0, width, -2, 2 );
		//movie.speed(speed);
	}

	Movie getMovie() {
		return movie;
	}
}