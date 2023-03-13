image1 = imread("traffic1.png");
image2 = imread("traffic2.png");
intensities_1 = im2double(image1());
intensities = im2double(image2());

filter_sobel = fspecial("sobel");

Iu = imfilter(intensities,filter_sobel);
Iv = imfilter(intensities, filter_sobel');

filter_gauss = fspecial("gaussian");
Iu2 = imfilter(Iu.^2, filter_gauss);
Iv2 = imfilter(Iv.^2, filter_gauss);
IuIv = imfilter(Iu.*Iv, filter_gauss);


[row,column] = size(intensities);
CHs = zeros(row,column);
for u=1:row
    for v=1:column
        A = [0 0; 0 0];
        for i=1:3
            for j=1:3
                if(u + i < row && v + j < column)
                    A = A + [Iu2(u + i,v + j) IuIv(u + i, v + j); IuIv(u + i, v + j) Iv2(u + i,v + j)];
                end
            end
        end
        Ch = det(A) - 0.04 * trace(A);
        CHs(u,v) = Ch;
    end
end

%%%% TU KRECE 2. ZADATAK
Corners = [];
Corners = corner(CHs);
It = imfilter(intensities,filter_gauss) - imfilter(intensities_1,filter_gauss);
newCorners = [];
for i=1:length(Corners)
    if(Corners(i,1) >= 50 && Corners(i,2) > 50 && Corners(i,1) + 50 < row && Corners(i,2) + 50 < column)
        newCorners = [newCorners; Corners(i,1) Corners(i,2)];
    end
end

Corners = newCorners;
x_move = zeros(length(Corners),1);
y_move = zeros(length(Corners),1);
w = 5;
Iu_1 = conv2(image1,[-1 1; -1 1], 'valid'); % partial on x
Iv_1 = conv2(image1, [-1 -1; 1 1], 'valid'); % partial on y
It = conv2(image1, ones(2), 'valid') + conv2(image2, -ones(2), 'valid'); % partial on t

for i=1:length(Corners(:,2))
    current_row = Corners(i,2);
    current_column = Corners(i,1);
    Iu_current = Iu_1(current_row-w:current_row+w, current_column-w:current_column+w);
    Iv_current = Iv_1(current_row-w:current_row+w, current_column-w:current_column+w);
    It_current = It(current_row-w:current_row+w, current_column-w:current_column+w);
    
    Iu_current = Iu_current(:);
    Iv_current = Iv_current(:);
    b = -It_current(:);

    A = [Iu_current Iv_current];
    x = pinv(A)*b;
    x_move(i) = x(1);
    y_move(i) = x(2);

end

figure();  
imshow(image2());
hold on
plot(Corners(:,1), Corners(:,2), "r*")
title("My calculation")


figure();
imshow(image2);
hold on;
quiver(Corners(:,1), Corners(:,2), x_move,y_move, 1,'r')