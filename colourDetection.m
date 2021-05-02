clear;
clf;
clc;

cam = webcam('USB Camera')
img = snapshot(cam);

subplot(2,2,1);
imshow(img);

img1 = rgb2gray(img);
red = img(:,:,1);

img1 = imsubtract(red,img1);
binaryImage = im2bw(img1,0.15);%  will need to calibrate threshold when in correct environment
binaryImage = imfill(binaryImage, 'holes');

subplot(2,2,2);
imshow(binaryImage);

labeledImage = bwlabel(binaryImage, 8);
subplot(2, 2, 3);
imshow(labeledImage, []);  % Show the gray scale image.
coloredLabels = label2rgb (labeledImage, 'hsv', 'k', 'shuffle'); % pseudo random color labels
subplot(2, 2, 3);
imshow(coloredLabels, []);

%% not working yet
blobMeasurements = regionprops(labeledImage, 'basic');
numberOfBlobs = size(blobMeasurements, 1);
allAreas = vertcat(blobMeasurements.Area);
[tmp, index] = max(allAreas)

object = blobMeasurements(index)

subplot(2, 2, 4);
imshow(img);
hold on;
rectangle('position',object.BoundingBox, 'EdgeColor', 'g', 'LineWidth', 3);
plot(object.Centroid(1), object.Centroid(2), '+b')


