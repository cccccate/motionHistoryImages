%Cristina Chu

%PS7
%Part 1.2: Frame differenced MHI

% Get video
% PS7A1P1T1.avi, PS7A2P1T1.avi, PS7A3P1T1.avi
video = VideoReader('PS7A3P1T1.avi');

% Frames
numFrames = video.NumberOfFrames;
frames(1:numFrames) = struct('cdata', zeros(video.Height, video.Width, 3, 'uint8'),'colormap', []);
       
binary = zeros(video.Height, video.Width,numFrames-1);
mhi = zeros(video.Height, video.Width,numFrames-1);
f = fspecial('gaussian', [4 4], 10); 

% frames' data
for k = 1 : numFrames
    frames(k).cdata = imfilter(rgb2gray(read(video, k)),f,'replicate');
end

t = 0.15;

for i = 2:numFrames
    diff = frames(i).cdata-frames(i-1).cdata;
    binary(:,:,i-1) = (im2bw(diff,t));
    mhi(:,:,i) = 60*binary(:,:,i-1);
    
    for j = 1:video.height
        
        for k = 1:video.width
            if(mhi(j,k,i)==0)
                mhi(j,k,i)=max(0,mhi(j,k,i-1)-2);    
            end
        end
        
    end
    
end

implay(mhi)





