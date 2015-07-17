
/*
SORTING SPIRAL
updated by Dmitry Ryzhov
Jeff Thompson | 2012 | www.jeffreythompson.org

*/
class SortSpiral {

	color[] seam;
	int ratio;
	int iter;

	SortSpiral() {
		iter = 2;
		ratio = 0;
	}

	void reSort() {
		ratio = int(random(1, 10));
		
		if (ratio % 2 == 1) {
			iter = 2;
		} else {
			iter = 4;
		}

		loadPixels();

		for (int i = 0; i < height / 2; i+=iter) {
			println("    " + i + "/" + height / 2);
			seam = new color[0];
			getSeam(i);
			seam = sort(seam);
			drawSeam(i);
		}

		//println("  Updating pixel array and drawing to screen...");
		updatePixels();
	}

	void getSeam(int offset) {
		// top & bottom
		for (int x = offset; x < width - offset; x+=iter) {
			seam = append(seam, pixels[offset * width + x]);             // top
			seam = append(seam, pixels[(height - offset - 1) * width + x]); // bottom
		}

		// right & left
		for (int y = offset + 1; y < height - offset - 1; y+=iter) {
			seam = append(seam, pixels[y * width + offset]);             // right
			seam = append(seam, pixels[y * width + width - offset]);     // left
		}
	}

	void drawSeam(int offset) {
		int index = 0;

		// top
		for (int x = offset; x < width - offset; x+=iter) {
			pixels[offset * width + x] = seam[index];
			index++;
		}

		// right
		for (int y = offset + 1; y < height - offset - 1; y+=iter) {
			pixels[y * width + width - offset] = seam[index];
			index++;
		}

		// bottom
		for (int x = width - offset - 1; x >= offset; x-=iter) {
			pixels[(height - offset - 1) * width + x] = seam[index];
			index++;
		}

		// left
		for (int y = height - offset - 2; y > offset + 1; y-=iter) {
			pixels[y * width + offset] = seam[index];
			index++;
		}
	}
}