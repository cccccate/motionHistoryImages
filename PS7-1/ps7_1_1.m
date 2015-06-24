%Cristina Chu

%PS7
%Part 1.1: Frame differenced MHI

% Get video 
video = VideoReader('PS7A1P1T1.avi');

% Frames
numFrames = video.NumberOfFrames;
frames(1:numFrames) = struct('cdata', zeros(video.Height, video.Width, 3, 'uint8'),'colormap', []);
    
% binary
binary = zeros(video.Height, video.Width,numFrames-1);

f = fspecial('gaussian', [4 4], 10);

% getting frames data
for k = 1 : numFrames
    frames(k).cdata = imfilter(rgb2gray(read(video, k)),f,'replicate');
end

% threshold
t = 0.15;

for i = 2:numFrames
    diff = frames(i).cdata-frames(i-1).cdata;
    binary(:,:,i-1) = (im2bw(diff,t));
end

figure(1)
imshow(binary(:,:,40));
figure(2)
imshow(binary(:,:,10));
figure(3)
imshow(binary(:,:,20));
figure(4)
imshow(binary(:,:,40));





