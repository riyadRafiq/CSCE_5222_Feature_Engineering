image = 'Labeled_W107b.png';
I = imread(image);
I = rgb2gray(I);
I(I < 250) = 0;
imwrite(I, sprintf('binarized_%s', image));