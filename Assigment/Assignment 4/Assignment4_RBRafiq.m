im = imread('image1.png');
im = rgb2gray(im);
figure, imshow(im)

% Apply Fourier transform to im
F = fftshift(fft2(im));

% Display both frequency and phase matrix as images.
freqDom = log(abs(F));
figure, imshow(freqDom, [])
figure, imshow(angle(F), [])

% Reconstruct and display the image 
lF = F;
lF(lF<0.01) = 0;
imgR = ifft2(ifftshift(lF));
figure, imshow(imgR, [])

% Construct and apply a spatial filter
h = fspecial('gaussian', [3 3], 0.5);
imgN = imfilter(im, h);
figure, imshow(imgN)

% Compute and display the similarity score
imgN = im2double(imgN);
score = immse(imgR, imgN);
disp(score)
