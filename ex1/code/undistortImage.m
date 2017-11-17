function undistorted_img = undistortImage(img, K, D, bilinear_interpolation)

if nargin < 4
    bilinear_interpolation = 0;
end

[height, width] = size(img);
% height*width matrix with 0
undistorted_img = uint8(zeros(height, width));

for y=1:height
    for x=1:width
        normalized_coords = K\[x;y;1];
        x_d = distortPoints(normalized_coords, D);
        
        distorted_coords = K * [x_d;1];
        u = distorted_coords(1)/distorted_coords(3);
        v = distorted_coords(2)/distorted_coords(3);
        
        u1 = floor(u);
        v1 = floor(v);
        if bilinear_interpolation >0
            a = u-u1; b = v-v1;
            if u1+1>0 && u1+1<=width && v1+1>0 && v1+1<=height
                undistorted_img(y,x) = (1-b)*((1-a)*img(v1,u1)+a*img(v1,u1+1)) ...
                                       +b*((1-a)*img(v1+1,u1)+a*img(v1+1,u1+1));
            end
        else
            if u1 > 0 && u1 <= width && v1 > 0 && v1 <= height
                undistorted_img(y,x) = img(v1,u1);
            end
        end
    end
end