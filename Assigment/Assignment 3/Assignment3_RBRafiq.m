im = imread('circuit.png'); % Read image

L = 20; % Minimum certain leangth
W = 15; % Line's width

lineDetect(im, L);
lineWidthDetect(im, L, W);

function lineDetect(im, minLength)
     edgeImg = edge(im, 'canny'); % Edge detected image
     [H,T,R] = hough(edgeImg);
     P  = houghpeaks(H,10,'threshold',ceil(0.3*max(H(:))));
     lines = houghlines(edgeImg,T,R,P,'FillGap',5,'MinLength',minLength);
     figure, imshow(im), hold on
     for k = 1:length(lines)
        xy = [lines(k).point1; lines(k).point2];
        plot(xy(:,1),xy(:,2),'LineWidth', 2, 'Color','green');
     
        % Plot beginnings and ends of lines
        plot(xy(1,1),xy(1,2),'*','Color','yellow');
        plot(xy(2,1),xy(2,2),'*','Color','red');
      
     end
 end

function lineWidthDetect(im, givenLength, givenWidth)
    edgeImg = edge(im, 'canny'); % Edge detected image
    [H,T,R] = hough(edgeImg);
    P  = houghpeaks(H,10,'threshold',ceil(0.3*max(H(:))));
    lines = houghlines(edgeImg,T,R,P,'FillGap',5,'MinLength', givenLength);
    figure, imshow(im), hold on
    for k = 1:length(lines)
        for l = 1:length(lines)
            if k~=l 
                if lines(k).theta == lines(l).theta && norm(lines(k).point1 - lines(l).point1) == givenWidth
                    xy_1 = [lines(k).point1; lines(k).point2];
                    xy_2 = [lines(l).point1; lines(l).point2];
                    
                    plot(xy_1(:,1),xy_1(:,2),'LineWidth', 2, 'Color','green');
                    plot(xy_2(:,1),xy_2(:,2),'LineWidth', 2, 'Color','green');
                    % Plot beginnings and ends of lines
                    plot(xy_1(1,1),xy_1(1,2),'*','Color','yellow');
                    plot(xy_1(2,1),xy_1(2,2),'*','Color','red');
                    plot(xy_2(1,1),xy_2(1,2),'x','Color','yellow');
                    plot(xy_2(2,1),xy_2(2,2),'x','Color','red');
                end
            end
        end
    end
end

