close all; clear all
% Dimenstions of .raw images. Assumed to be square
cols = 2048;
rows = cols;

% Load background image file

bg_file = uigetfile('*.raw','Select the background raw-file');
bg_open = fopen(bg_file, 'r', 'l');
bg_data = fread(bg_open, [cols, rows], '*uint16');

% Create matrix of odd and even integers up to file dimensions
even = 2*(1:cols/2);
odd = even-1;

% Select .raw image files to be debayered
[fileNames,pathName] = uigetfile('*.raw','Select the raw-files', 'MultiSelect','on');

% Perform debayering and save separate colour channels as .tiff files with
% colour prepended

if iscell(fileNames) == 0 
    fileNames = {fileNames};
end

for i = 1:length(fileNames)
    file = fileNames{i};
    fin = fopen(file, 'r', 'l');
    ima = fread(fin, [cols rows], '*uint16');
    
    ima_sub = ima - bg_data;
    oddOdd = ima_sub(odd, odd);
    oddEven = ima_sub(odd, even);
    evenEven = ima_sub(even, even);
    evenOdd = ima_sub(even, odd);
    
    imwrite(oddEven, strcat("red_", file(1:end-4), ".tiff"))
    imwrite(evenOdd, strcat("blue_", file(1:end-4), ".tiff"))
    %     imwrite(oddOdd, strcat("green1_", file(1:end-4), ".tiff"))
    %     imwrite(evenEven, strcat("green2_", file(1:end-4), ".tiff"))
end


% Show each colour channel of final image
% figure(1)
% imshow(oddOdd)
% 
% figure(2)
% imshow(oddEven)
% figure(2)
% title('red')
% 
% figure(3)
% imshow(evenEven)
% 
% figure(4)
% imshow(evenOdd)
% figure(4)
% title('blue')
% 
% figure(5)
% imshow(ima_sub);
% 
% figure(6)
% imshow(ima);