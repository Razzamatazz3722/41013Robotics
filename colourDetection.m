clear;
clf;
clc;

%set up the webacm
cam = webcam('USB Camera')

%obtain image from the webcam
img = snapshot(cam);
subplot(2,2,1);
imshow(img);


img1 = rgb2gray(img); %turn image to grayscale
red = img(:,:,1); %obtain red values of image
img1 = imsubtract(red,img1); %remove red from the image or image from the red. not sure yet havent googled. 
binaryImage = im2bw(img1,0.15);%  will need to calibrate threshold when in correct environment
binaryImage = imfill(binaryImage, 'holes'); %fill in holes in the regions

subplot(2,2,2);
imshow(binaryImage);

%show all the different blobs in the image. Only for testing. 
labeledImage = bwlabel(binaryImage, 8);
subplot(2, 2, 3);
imshow(labeledImage, []);  % Show the gray scale image.
coloredLabels = label2rgb (labeledImage, 'hsv', 'k', 'shuffle'); % pseudo random color labels
subplot(2, 2, 3);
imshow(coloredLabels, []);

% get the properties of the blobs
blobMeasurements = regionprops(labeledImage, 'basic');
numberOfBlobs = size(blobMeasurements, 1);

%Find the max blob to find the actual object. There is usually a big
%difference between the actual object and the other accidental
%identifications
allAreas = vertcat(blobMeasurements.Area);
[tmp, index] = max(allAreas)
object = blobMeasurements(index)

%plot the bounding box and the centroid of the object
subplot(2, 2, 4);
imshow(img);
hold on;
rectangle('position',object.BoundingBox, 'EdgeColor', 'g', 'LineWidth', 3);
plot(object.Centroid(1), object.Centroid(2), '+b');


