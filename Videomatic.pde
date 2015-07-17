
String videoSrc = "0.mp4";

Player ya;
Player yaTrans;

Movie yaMovie;
Movie yaTransMovie;

SortSpiral sortSpiral;
SortRes sortRes;
SortAerial sortAerial;
SortByHighestRGBValue sortByHighestRGBValue;

PImage tempImg;
boolean tempImgShot = false;

int blendStyle[];
int blendIndex;

void setup() {
	size(1280, 760, P3D);
	setupVideo();
}

int inc = 3;

void draw() {
	background(0);
	drawVideo();
	int w = width;
	int h = height;
	// loadSphere(w/2, h/2, 0, 50 + inc*2);
	// loadSphere(w/2 - w/4 - inc*2, h/2, 0, 50);
	// loadSphere(w/2 + w/4 + inc*2, h/2, 0, 50);
	// loadSphere(w/2, h/2 - h/4 - inc*2, 0, 50);
	// loadSphere(w/2, h/2 + h/4 + inc*2, 0, 50);
}

void loadSphere(int x, int y, int z, int r) {
	pushMatrix();
	if (++inc == 90)
		inc = 3;
	sphereDetail(inc);
	translate(x, y, z);
	noFill();
	stroke(255);
	sphere(r);
	popMatrix();
}

void setupVideo() {
	smooth();
    frameRate( 24 );

	ya = new Player(this, videoSrc, 150);
	yaMovie = ya.getMovie();
	yaMovie.loop();

	yaTrans = new Player(this, videoSrc, 150);
	yaTransMovie = yaTrans.getMovie();
	yaTransMovie.loop();
	
	sortSpiral = new SortSpiral();
	sortByHighestRGBValue = new SortByHighestRGBValue(); 
	
	blendIndex = 5;
	blendStyle = new int[] {
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
}

void drawVideo() {
	ya.draw();

	if (frameCount % 15 == 0) {
		blendIndex = int(random(0, 11));
	}

	blend(yaTransMovie, 0, 0, width, height, 0, 0, width, height, blendStyle[blendIndex]);
}

void mousePressed() {
	ya.mousePressed();
}

void movieEvent(Movie movie) {
	if (movie == yaMovie) {
		yaMovie.read();	
		if (tempImgShot == true) {
			tempImg = movie;
		}
	} else if (movie == yaTransMovie) {
		yaTransMovie.read();
	}
}
