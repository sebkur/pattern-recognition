
function img = normalizeImg(in)
	minimum = min(in(:));
	img = in .- minimum;
	maximum = max(img(:));
	img = img ./ maximum;
endfunction

img10 = double(imread("wildfire/raw/10.png"));
img11 = double(imread("wildfire/raw/11.png"));
img12 = double(imread("wildfire/raw/12.png"));

img20 = double(imread("wildfire/raw/20.png"));
img21 = double(imread("wildfire/raw/21.png"));
img22 = double(imread("wildfire/raw/22.png"));

img30 = double(imread("wildfire/raw/30.png"));
img31 = double(imread("wildfire/raw/31.png"));
img32 = double(imread("wildfire/raw/32.png"));

img10 = normalizeImg(img10);
img11 = normalizeImg(img11);
img12 = normalizeImg(img12);

img20 = normalizeImg(img20);
img21 = normalizeImg(img21);
img22 = normalizeImg(img22);

img30 = normalizeImg(img30);
img31 = normalizeImg(img31);
img32 = normalizeImg(img32);

kernel = ones(5,5)

subplot(2, 3, 1)
bla1 = dilate(erode(((img10 - img11)), kernel),kernel);
bla2 = dilate(erode(((img11 - img12)), kernel),kernel);
imshow(img11 .* (bla1 - bla2 < 0))

subplot(2, 3, 2)
bla1 = dilate(erode(((img20 - img21)), kernel),kernel);
bla2 = dilate(erode(((img21 - img22)), kernel),kernel);
imshow(img21 .* (bla1 - bla2 < 0))

subplot(2, 3, 3)
bla1 = dilate(erode(((img30 - img31)), kernel),kernel);
bla2 = dilate(erode(((img31 - img32)), kernel),kernel);
imshow(img31 .* (bla1 - bla2 < 0))

subplot(2, 3, 4)
imshow(img11)

subplot(2, 3, 5)
imshow(img21)

subplot(2, 3, 6)
imshow(img31)


print("features.png");

pause
