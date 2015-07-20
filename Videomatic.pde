/* Build system Processing */

String files[] = {"1.mp4", "17.mp4", "10.mp4"};
int playlistCount = files.length;
int playlistIndex = 0;

Player[] playlist = new Player[playlistCount];
Movie[] movielist = new Movie[playlistCount];

boolean frameChange = true;

SortCrop sortCrop;
PImage cropImage;

SortSpiral sortSpiral;
SortRes sortRes;
SortAerial sortAerial;
SortByHighestRGBValue sortByHighestRGBValue;

int blendStyle[] = new int[] {
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

int blendIndex = 0;

void setup() {
	size(1280, 720);
	setupVideo();
	cropImage = loadImage("1.JPG");
	sortCrop = new SortCrop(cropImage);
}

void draw() {
	background(0);
	sortCrop.draw();
	tint(225, 230);
	drawVideo();
}

void setupVideo() {
	smooth();
    frameRate( 24 );

    // init players
    for (int i = 0; i < playlistCount; i++) {
    	println("new Player: " + (files[i]));
    	playlist[i] = new Player(this, (files[i]), 10);
    	movielist[i] = playlist[i].getMovie();
    	
    	movielist[i].loop();
    	movielist[i].speed(0.5);
    	movielist[i].volume(0);
    }

	sortSpiral = new SortSpiral();
	sortByHighestRGBValue = new SortByHighestRGBValue(); 
}

void drawVideo() {
	playlist[playlistIndex].draw();
	
	if (frameCount % 25 == 0) {
		blendIndex = int(random(0, blendStyle.length - 1));
	}
	println("nextMovie1: "+getNextMovieIndex(1) + "nextMovie2: " + getNextMovieIndex(2));
	blend(movielist[getNextMovieIndex(1)], 0, 0, width, height, 0, 0, width, height, blendStyle[blendIndex]);
	
	tint(255, int(random(235, 255)));
	sortSpiral.draw();
	blend(movielist[getNextMovieIndex(2)], 0, 0, width, height, 0, 0, width, height, blendStyle[getBlendIndex(1)]);
}

int getNextMovieIndex(int offset) {
	int nextlistIndex = playlistIndex + offset;	
	if (nextlistIndex >= playlistCount) {
		nextlistIndex = 0;
	}
	return nextlistIndex;
}

int getBlendIndex(int offset) {
	int nextBlendIndex = blendIndex + offset;
	if (nextBlendIndex >= blendStyle.length - 1) {
		nextBlendIndex = blendIndex - 1;
	}
	return nextBlendIndex;
}

void mousePressed() {
	playlistIndex = getNextMovieIndex(1);
	println("mousePressed");
}

void movieEvent(Movie movie) {
	for (int i = 0; i < playlistCount; i++) {
		if (movie == movielist[i]) {
			movielist[i].read();
		}
	}
}
