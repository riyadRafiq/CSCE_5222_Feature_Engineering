X = imread('image1.png'); % Read an image
X = rgb2gray(X);

[cA,cH,cV,cD] = wavelet(X); % apply wavelet 
iR = inv_wavelet(cA,cH,cV,cD); % apply inverse wavlet
visualization (cA,cH,cV,cD,iR); % apply visualize
corner_poins = detect_corner(X); % apply detect corners

% plot the detected corners to the wavelet reconstruction (without LL subband)
s = size(cA);
LL = zeros(s);
iR2 = inv_wavelet(LL,cH,cV,cD);
figure, imshow(iR2)
hold on
plot(strongest)

% Function to detect corners
function [corners, strongest] = detect_corner(img)
    corners = detectHarrisFeatures(img);
    strongest = selectStrongest(corners, 20);
    figure, imshow(img) 
    hold on
    plot(strongest)
end

% Function to visualize wavelet coefficient and reconstruction
function visualization(cA,cH,cV,cD,iR)
    figure, imagesc(cA)
    title('Approximation Coefficients')
    figure, imagesc(cH)
    title('Horizontal Detail Coefficients')
    figure, imagesc(cV)
    title('Vertical Detail Coefficients')
    figure, imagesc(cD)
    title('Diagonal Detail Coefficients')
    figure, imagesc(iR)
    title('Reconstruction')
end

% Function to perform wavelet transform
function [cA,cH,cV,cD] = wavelet(img)
    [cA,cH,cV,cD] = dwt2(img,'sym4','mode','per');
end

% Function to perform inverse wavelet
function iR = inv_wavelet(cA,cH,cV,cD)
    iR = idwt2(cA,cH,cV,cD,'sym4','mode','per');
end