// new Sphere(w/2, h/2, 0, 50 + inc*2);
// new Sphere(w/2 - w/4 - inc*2, h/2, 0, 50);
// new Sphere(w/2 + w/4 + inc*2, h/2, 0, 50);
// new Sphere(w/2, h/2 - h/4 - inc*2, 0, 50);
// new Sphere(w/2, h/2 + h/4 + inc*2, 0, 50);
class Sphere {

	int inc = 3;
	int w = width;
	int h = height;

	Sphere(int x, int y, int z, int r) {
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
}