clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
imtool close all;  % Close all imtool figures.
clear;  % Erase all existing variables.
workspace;  % Make sure the workspace panel is showing.
fontSize = 20;

% Open an image.
cam = webcam('USB Camera');
rgbImage = snapshot(cam);

[rows, columns, numberOfColorBands] = size(rgbImage)
% If it's monochrome (indexed), convert it to color. 
% Check to see if it's an 8-bit image needed later for scaling).
if strcmpi(class(rgbImage), 'uint8')
  % Flag for 256 gray levels.
  eightBit = true;
else
  eightBit = false;
end

% Display the original image.
subplot(2, 2, 1);
imshow(rgbImage);
set(gcf, 'Position', get(0,'Screensize')); % Enlarge figure to full screen.
set(gcf,'name','Image Analysis Demo','numbertitle','off') 
drawnow; % Make it display immediately. 
if numberOfColorBands > 1 
  title('Original Color Image', 'FontSize', fontSize); 
  grayImage = rgbImage(:,:,1);
else 
  caption = sprintf('Original Indexed Image\n(converted to true color with its stored colormap)');
  title(caption, 'FontSize', fontSize);
  grayImage = rgbImage;
end
% Display it.
subplot(2, 2, 2);
imshow(grayImage, []);
title('Grayscale Image', 'FontSize', fontSize);
% Binarize the image.
binaryImage = grayImage < 100;
% Display it.
subplot(2, 2, 3);
imshow(binaryImage, []);
title('Binary Image', 'FontSize', fontSize);
% Remove small objects.
binaryImage = bwareaopen(binaryImage, 300);
% Display it.
subplot(2, 2, 4);
imshow(binaryImage, []);
title('Cleaned Binary Image', 'FontSize', fontSize);
[labeledImage, numberOfObjcts] = bwlabel(binaryImage);
blobMeasurements = regionprops(labeledImage,'Perimeter','Area', 'Centroid'); 
% for square ((a>17) && (a<20))
% for circle ((a>13) && (a<17))
% for triangle ((a>20) && (a<30))
circularities = [blobMeasurements.Perimeter].^2 ./ (4 * pi * [blobMeasurements.Area])
hold on;
% Say what they are
for blobNumber = 1 : numberOfObjcts
  if circularities(blobNumber) < 1.19
    message = sprintf('The circularity of object #%d is %.3f, so the object is a circle',...
      blobNumber, circularities(blobNumber));
    theLabel = 'Circle';
  elseif circularities(blobNumber) < 1.53
    message = sprintf('The circularity of object #%d is %.3f, so the object is a Rectangle',...
      blobNumber, circularities(blobNumber));
    theLabel = 'Rectangle';
  else
    message = sprintf('The circularity of object #%d is %.3f, so the object is a triangle',...
      blobNumber, circularities(blobNumber));
    theLabel = 'Triangle';
  end
  text(blobMeasurements(blobNumber).Centroid(1), blobMeasurements(blobNumber).Centroid(2),...
    theLabel, 'Color', 'r');
  uiwait(msgbox(message));
end