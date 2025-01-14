/* Build system Processing */

// Depends on processing.video library

boolean saveIt = false;

// 1665 frames ~ 2 mins ~ 3Gb ~ 29min render after rec
int minutes = 1;
//String files[] = {"02.mp4", "13.mp4", "01.mp4"};
String files[] = {"1.mp4", "2.mp4", "3.mp4"};
// String files[] = {"1.mp4"};
int playlistCount = files.length;
int playlistIndex = 0;

int firstFrame = 843;
int jumpFrame = 55;

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
	size(480, 320);
	setupVideo();
	cropImage = loadImage("back.jpg");
	sortCrop = new SortCrop(cropImage);
}

void draw() {
	background(0);
	sortCrop.draw();
	tint(225, int(random(200, 235)));
	drawVideo();
}

void setupVideo() {
	smooth();
    frameRate( 16 );

    // init players
    for (int i = 0; i < playlistCount; i++) {
    	println("new Player: " + (files[i]));
    	playlist[i] = new Player(this, (files[i]), 10);
    	movielist[i] = playlist[i].getMovie();

    	movielist[i].loop();
    	movielist[i].speed(0.125);
    	movielist[i].jump(jumpFrame);
    	if (!movielist[i].available()){
    		movielist[i].jump(1);
    	}
    	movielist[i].volume(0);
    }

	sortSpiral = new SortSpiral();
	sortByHighestRGBValue = new SortByHighestRGBValue(); 
}

void drawVideo() {
	playlist[playlistIndex].draw();
	
	if (frameCount % 100 == 0) {
		blendIndex = int(random(0, blendStyle.length - 1));
	}

	if (frameCount % 183 == 0 || frameCount % 373 == 0 || frameCount % 551 == 0 || frameCount % 703 == 0) {
		playlistIndex = getNextMovieIndex(1);
	}
	println("nextMovie1: " + getNextMovieIndex(1) + ", nextMovie2: " + getNextMovieIndex(2));
	blend(movielist[getNextMovieIndex(1)], 0, 0, width, height, 0, 0, width, height, blendStyle[blendIndex]);
	
	
	sortSpiral.draw();
	//blend(movielist[getNextMovieIndex(2)], 0, 0, width, height, 0, 0, width, height, blendStyle[getBlendIndex(2)]);
	tint(255, int(random(205, 235)));
	// sortByHighestRGBValue.reSort();
  // save if specified
  if (saveIt) {   
    save("frames/frame_" + nf(frameCount + firstFrame,4) + ".png");
  } else {
  	//exit();
  }
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
