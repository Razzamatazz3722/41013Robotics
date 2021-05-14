clear;


vidObj = VideoReader('IMG_9651.MOV');
video = VideoWriter('dobotBlue.avi'); %create the video object

open(video); %open the file for writing

while hasFrame(vidObj)
  img = readFrame(vidObj);
  %imshow(img);
  bwimg = rgb2gray(img);
  [BW, maskedRGBImage] = createMask2(img);
  finalImg = imfuse(bwimg,maskedRGBImage,'blend');
  writeVideo(video,finalImg); %write the image to file
end

close(video); %close the file
%%
vidObj = VideoReader('IMG_9651.MOV');
img = readFrame(vidObj);

%%

while hasFrame(vidObj)
    img = readFrame(vidObj);
    
    bwimg = rgb2gray(img);
    
    [BW, maskedRGBImage] = createMask2(vidFrame);
    
    for colour = 1:3
       
        for row = 1:1
           for column = 1:1
            
               if maskedRGBImage(row,column,colour) == 0
                   
               end
               
           end
        end
            
            %maskedRGBImage(
        
    end

end