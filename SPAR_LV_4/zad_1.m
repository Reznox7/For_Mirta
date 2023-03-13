myImage = imread("checkboard.png");
intensities = im2double(myImage());
filter_sobel = fspecial("sobel");

Iu = imfilter(intensities,filter_sobel);
Iv = imfilter(intensities, filter_sobel');

figure(1)
imshow(Iu)

figure(2)
imshow(Iv)

filter_gauss = fspecial("gaussian");
Iu2 = imfilter(Iu.^2, filter_gauss);
Iv2 = imfilter(Iv.^2, filter_gauss);
IuIv = imfilter(Iu.*Iv, filter_gauss);

figure(3);
imshow(IuIv);
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

Corners = [];
for u=1:row
    for v=1:column
        if(CHs(u,v) > 50)
            Corners = [Corners; v, u];
        end
    end
end
figure(4);  
imshow(myImage);
hold on
plot(Corners(:,1), Corners(:,2), "r*")
title("My calculation")
