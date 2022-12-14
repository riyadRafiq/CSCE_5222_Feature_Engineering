path_directory1 = 'result images';
path_directory2 = 'ground truths';
result_image_files = dir([path_directory1 '/*.jpg']);
ground_image_files = dir([path_directory2 '/*.jpg']);

nfiles = length(result_image_files);

for index=1:nfiles
    r_img = imread(fullfile(path_directory1, result_image_files(index).name));
    g_img = imread(fullfile(path_directory2, ground_image_files(index).name));
    r_img = rgb2gray(r_img);
    r_img (r_img<250) = 0;
    r_img (r_img>=250) = 1;
    [a, re, pr, f1] = evaluateSegmentationScores(g_img, r_img);
    Accuracy{index} = a;
    Recall{index} = re;
    Precision{index} = pr;
    F1score{index} = f1;
end


function [Accuracy, Recall, Precision, F1score] = evaluateSegmentationScores(A, B)

    % TP - true positive, FP - false positive 
    % TN - true negative, FN - false negative
    
     if(isa(A,'logical'))
         X = A;
     else
         X = imbinarize(A);
     end
     if(isa(B,'logical'))
         Y = B;
     else
     Y = imbinarize(B);
     end
    
     sumindex = X + Y;
     TP = length(find(sumindex == 2));
     TN = length(find(sumindex == 0));
     
     substractindex = X - Y;
     FP = length(find(substractindex == -1));
     FN = length(find(substractindex == 1));
     
     Accuracy = (TP+TN)/(FN+FP+TP+TN);
     Recall = TP/(TP+FN);
     Precision = TP/(TP+FP);
     F1score = (2*Precision*Recall)/(Precision+Recall);

end