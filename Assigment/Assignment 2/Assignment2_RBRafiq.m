% Read and display image
I = imread('image1.png');
I = rgb2gray(I);
figure, imshow(I)
imwrite(I, 'res1.png');

% Add Gaussian noise and display both original and distorted images 
J = imnoise(I,'gaussian');
figure, imshowpair(I, J, 'montage')
imwrite(J, 'noisy.png');

% Remove noise and display result image
Kmedian = medfilt2(J);
figure, imshow(Kmedian)
imwrite(Kmedian, 'removed.png');

% Apply Sobel and Canny edge detector
E1 = edge(I,'Sobel');
E2 = edge(I,'Canny');

figure, imshow(E1)
figure, imshow(E2)
imwrite(E1, 'sobel.png');
imwrite(E2, 'canny.png');

% Apply two different threshholds for Sobel and Canny
ET1 = edge(I,'Sobel', 0.1); % Sobel -> threshhold = 0.1
ET2 = edge(I,'Sobel', 0.2); % Sobel -> threshhold = 0.2
ET3 = edge(I,'Canny', 0.3); % Canny -> threshhold = 0.3
ET4 = edge(I,'Canny', 0.5); % Canny -> threshhold = 0.5

figure, imshowpair(ET1, ET2, 'montage')
figure, imshowpair(ET3, ET4, 'montage')
imwrite(ET1, 'sobel_0.1.png');
imwrite(ET2, 'sobel_0.2.png');
imwrite(ET3, 'canny_0.3.png');
imwrite(ET4, 'canny_0.5.png');

% Resize the image by a factor and apply Sobel and Canny edge detector
I1 = imresize(I, 0.75); % Factor of 0.75 
I2 = imresize(I, 0.5); % Factor of 0.5
I3 = imresize(I, 0.25); % Factor of 0.25

EI11 = edge(I1,'Sobel');
EI12 = edge(I1,'Canny');

EI21 = edge(I2,'Sobel');
EI22 = edge(I2,'Canny');

EI31 = edge(I3,'Sobel');
EI32 = edge(I3,'Canny');

figure, imshowpair(EI11, EI12, 'montage')
figure, imshowpair(EI21, EI22, 'montage')
figure, imshowpair(EI31, EI32, 'montage')

imwrite(EI11, 're_sobel_0.75.png');
imwrite(EI12, 're_canny_0.75.png');
imwrite(EI21, 're_sobel_0.5.png');
imwrite(EI22, 're_canny_0.5.png');
imwrite(EI31, 're_sobel_0.25.png');
imwrite(EI32, 're_canny_0.25.png');





