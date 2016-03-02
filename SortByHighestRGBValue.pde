import java.io.File;           // use to find file size, check for repeats
import java.util.Collections;    // required to sort ArrayLists

class SortByHighestRGBValue {

	/*
	SORT BY HIGHEST RGB VALUE
	Jeff Thompson | 2013 | www.jeffreythompson.org

	Iterate image, storing pixels into red, green, and blue arrays depending
	on which value in the pixel is highest.  Sort and replace.

	NOTE: we use ArrayLists here as opposed to the 'append' method for regular
	int arrays - this is WAAAAYYY faster (like, 2 seconds instead of 15 minutes!); in
	order to make this work, we must store the colors as Integers, casting them
	back to color values using:
	  color c = (color)IntegerValue;

	*/

//String filename = "../SourceImageFiles/highRes/01.jpg";

	boolean saveIt = false;
		color c;                                                // values for looking at pixels
		float r, g, b;                                          //  initialize here to avoid re-creating each px
		ArrayList<Integer> rColor = new ArrayList<Integer>();   // store red colors
		ArrayList<Integer>rPos = new ArrayList<Integer>();      // store red positions in the px array
		ArrayList<Integer> gColor = new ArrayList<Integer>();   // ditto green
		ArrayList<Integer>gPos = new ArrayList<Integer>();
		ArrayList<Integer> bColor = new ArrayList<Integer>();   // ditto blue
		ArrayList<Integer>bPos = new ArrayList<Integer>();


	SortByHighestRGBValue(/*String filename*/) {

		// load image, basic setup
		// String fileSize = getFileSize(filename);
		// println("Loading image (" + fileSize + ")...");
		// PImage img = loadImage(filename);
		// size(img.width, img.height);
		// image(img, 0, 0);

		// ArrayLists for pixel values and positions - these are much faster than using 'append' on arrays
	}

	public void reSort() {
		// load all pixels, put into arrays based on max values
		println("Loading pixels, finding highest values, and putting into arrays...");
		loadPixels();
		for (int i = 0; i < pixels.length; i++) {

			// get current color values
			c = pixels[i];
			r = c >> 16 & 0xFF;
			g = c >> 8 & 0xFF;
			b = c & 0xFF;

			// get the highest value in the color
			int greatest = highestColor(r, g, b);

			// put into appropriate arrays
			switch (greatest) {
			case 1:
				rColor.add(c);
				rPos.add(i);
				break;
			case 2:
				gColor.add(c);
				gPos.add(i);
				break;
			case 3:
				bColor.add(c);
				bPos.add(i);
				break;
			}

			// update us on our progress every 10%
			if (i > 0 && i % (pixels.length / 10) == 0) {
				println("  " + nfc(i) + "\t/ " + nfc(pixels.length));
			}
		}

		// let us know the statistics of our gathering!
		println("\nSTATISTICS:");
		println("  Red:   " + nfc(rColor.size()) + "px");
		println("  Green: " + nfc(gColor.size()) + "px");
		println("  Blue:  " + nfc(bColor.size()) + "px\n");

		// sort ArrayLists using Java Collections
		println("Sorting arrays (may take a while)...");
		print("  red...");
		Collections.sort(rColor);
		print(" green...");
		Collections.sort(gColor);
		print(" blue...\n");
		Collections.sort(bColor);

		// put back in place
		println("Putting pixels back into image...");
		for (int i = 0; i < rPos.size(); i++) {
			pixels[rPos.get(i)] = (color)rColor.get(i);
		}
		for (int i = 0; i < gPos.size(); i++) {
			pixels[gPos.get(i)] = (color)gColor.get(i);
		}
		for (int i = 0; i < bPos.size(); i++) {
			pixels[bPos.get(i)] = (color)bColor.get(i);
		}
		updatePixels();
/*
		// save if specified
		if (saveIt) {
			filename = stripFilename(filename);
			save("results/SortHighestRGB_" + filename + ".tiff");
		}
*/
		// all done!
		println("\nDONE!");
	}


/*	String getFileSize(String filename) {

		String fileSize = "";
		File f = new File(filename);

		int fs = (int)f.length();

		if (fs < 1024) {                         // less than 1 kb
			fileSize += nfc(fs) + " bytes";
		} else if (fs > 1024 && fs < 1048576) {  // 1 kb - .99 MB
			fs /= 1024;
			fileSize += nfc(fs) + " kb";
		} else {
			fs /= 1048576;
			fileSize += nfc(fs) + " MB";                // larger? measure in megabytes
		}

		return fileSize;
	}*/


// which is the greatest? returns 1 (r), 2 (g), or 3 (b)
	int highestColor(float r, float g, float b) {

		int greatestColor = 0;
		float minVal = -1;          // account for 0s in the color (0 will be greater)
		if (r > minVal) {
			greatestColor = 1;
			minVal = r;
		}
		if (g > minVal) {
			greatestColor = 2;
			minVal = g;
		}
		if (b > minVal) {
			greatestColor = 3;
			minVal = b;
		}

		return greatestColor;
	}

// either copy/paste this into your project, or copy this entire
// .pde file into your project to load it as a tab!

	String stripFilename(String s) {
		s = s.substring(s.lastIndexOf('/') + 1, s.length());
		s = s.substring(s.lastIndexOf('\\') + 1, s.length());
		s = s.substring(0, s.lastIndexOf('.'));
		return s;
	}
}
