function blobMeasurements = findObjects(cam, colour, debug)

    %obtain image from the webcam
    img = snapshot(cam);
    if(debug==1)
        subplot(2,2,1);
        imshow(img);
    end

    img1 = rgb2gray(img); %turn image to grayscale
    obj_colour = img(:,:,colour); %obtain colour values of image
    img1 = imsubtract(obj_colour,img1); %remove colour from the image or image from the red. not sure yet havent googled. 
    binaryImage = im2bw(img1,0.1);%  will need to calibrate threshold when in correct environment
    binaryImage = imfill(binaryImage, 'holes'); %fill in holes in the regions

    if(debug==1)
        subplot(2,2,2);
        imshow(binaryImage);
    end

    %show all the different blobs in the image. Only for testing. 
    labeledImage = bwlabel(binaryImage, 8);
    coloredLabels = label2rgb (labeledImage, 'hsv', 'k', 'shuffle'); % pseudo random color labels
    
    if(debug==1)
        subplot(2, 2, 3);
        imshow(coloredLabels, []);
    end
   
    % get the properties of the blobs
    blobMeasurements = regionprops(labeledImage, 'basic');
    numberOfBlobs = size(blobMeasurements, 1);

end

