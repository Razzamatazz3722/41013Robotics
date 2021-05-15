while(1)

cam = webcam('USB Camera');
rgbImage = snapshot(cam);

[BW,maskedRGBImage] = createMaskYellow(rgbImage);

BW = imfill(BW, 'holes');
imshow(BW);
labeledImage = bwlabel(BW, 8);
blobMeasurements = regionprops(labeledImage, 'Perimeter', 'Area', 'Centroid', 'BoundingBox');


Circularities = [blobMeasurements.Perimeter].^2 ./ (4 * pi * [blobMeasurements.Area])
if(length(Circularities) > 0)
    if (Circularities(1) > 1.18) & (Circularities(1) < 1.25)
        display('object is triangle');

    else
       display('object not triangle'); 
    end
else
    display('no yellow objects');
end

end





%%

cam = webcam('USB Camera');
rgbImage = snapshot(cam);

imshow(rgbImage);

ocrResults = ocr(rgbImage)
