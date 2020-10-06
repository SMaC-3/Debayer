% Dimenstions of .raw images. Assumed to be square
cols = 2048;
rows = cols;

% Create matrix of odd and even integers up to file dimensions
even = 2*(1:cols/2);
odd = even-1;

% Select .raw image files to be debayered
[fileNames,pathName] = uigetfile('*.raw','Select the raw-files', 'MultiSelect','on');

% Perform debayering and save separate colour channels as .tiff files with
% colour prepended
if iscell(fileNames) == 1
    for i = 1:length(fileNames)
        file = fileNames{i};
        fin = fopen(file, 'r', 'l');
        ima = fread(fin, [cols rows], '*uint16');
        
        oddOdd = ima(odd, odd);
        oddEven = ima(odd, even);
        evenEven = ima(even, even);
        evenOdd = ima(even, odd);
        
        imwrite(oddEven, strcat("red_", file(1:end-4), ".tiff"))
        imwrite(evenOdd, strcat("blue_", file(1:end-4), ".tiff"))
        %     imwrite(oddOdd, strcat("green1_", file(1:end-4), ".tiff"))
        %     imwrite(evenEven, strcat("green2_", file(1:end-4), ".tiff"))
    end
else 
    file = fileNames;
    fin = fopen(file, 'r', 'l');
    ima = fread(fin, [cols rows], '*uint16');
    
    oddOdd = ima(odd, odd);
    oddEven = ima(odd, even);
    evenEven = ima(even, even);
    evenOdd = ima(even, odd);
    
    imwrite(oddEven, strcat("red_", file(1:end-4), ".tiff"))
    imwrite(evenOdd, strcat("blue_", file(1:end-4), ".tiff"))
    %     imwrite(oddOdd, strcat("green1_", file(1:end-4), ".tiff"))
    %     imwrite(evenEven, strcat("green2_", file(1:end-4), ".tiff"))
end

% Show each colour channel of final image
figure(1)
imshow(oddOdd)

figure(2)
imshow(oddEven)
title('red')

figure(3)
imshow(evenEven)

figure(4)
imshow(evenOdd)
title('blue')