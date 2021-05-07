clear;
clc;

%variables
totalCups = 2;
totalBalls = 4;
load('cameraParams.mat');

%set up the webacm
cam = webcam('USB Camera')

%detect objects in the image
r_obj = findObjects(cam,1,0.15,0);
%g_obj = findObjects(cam,2,0.1,1);
b_obj = findObjects(cam,3,0.1,0);


all_obj = [r_obj;b_obj]; % will need to add green once i figure it out. 

[cups, balls] = findBallsAndCups(all_obj,totalCups,totalBalls);

%display image
img = snapshot(cam);
imshow(img);
hold on;
for(i=1:length(cups))
    rectangle('position',cups(i).BoundingBox, 'EdgeColor', 'g', 'LineWidth', 3);
    plot(cups(i).Centroid(1), cups(i).Centroid(2), '+b');
    hold on;
end
for(i=1:length(balls))
    rectangle('position',balls(i).BoundingBox, 'EdgeColor', 'g', 'LineWidth', 3);
    plot(balls(i).Centroid(1), balls(i).Centroid(2), '+b');
    hold on;
end







%% old code 
load('cameraParams.mat');

%set up the webacm
cam = webcam('USB Camera')

%obtain image from the webcam
img = snapshot(cam);
subplot(2,2,1);
imshow(img);


img1 = rgb2gray(img); %turn image to grayscale
red = img(:,:,1); %obtain red values of image
img1 = imsubtract(red,img1); %remove red from the image or image from the red. not sure yet havent googled. 
binaryImage = im2bw(img1,0.1);%  will need to calibrate threshold when in correct environment
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
[tmp, index] = max(allAreas);
object = blobMeasurements(index);

if(length(object) ~= 0)

    %plot the bounding box and the centroid of the object
    subplot(2, 2, 4);
    imshow(img);
    hold on;
    rectangle('position',object.BoundingBox, 'EdgeColor', 'g', 'LineWidth', 3);
    plot(object.Centroid(1), object.Centroid(2), '+b');
    plot(1280/2,960/2, 'r+', 'LineWidth', 3);
    
else
    
    display("No objects detected");
    
end

if(length(object) ~= 0)

    % make K 
    fx = cameraParams.FocalLength(1);
    fy = cameraParams.FocalLength(2);
    cx = cameraParams.PrincipalPoint(1);
    cy = cameraParams.PrincipalPoint(2);

    k = [fx,0,cx;0,fy,cy;0,0,1];

    floor = 0.65;
    cup = 0.01;
    z = floor-cup;
    UZ = object.Centroid(1) * z;
    VZ = object.Centroid(2) * z;
    Z = z;

    pixel_coordinates = [UZ; VZ; Z];

    K_inverse = inv(k);

    object.Centroid;

    world_coord = (K_inverse * pixel_coordinates)

end

