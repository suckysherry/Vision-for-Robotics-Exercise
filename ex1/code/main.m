close all;
clear all;

poses = load('/Users/daisiqi/Documents/MATLAB/ex1/data/poses.txt');

% Create a matrix for checkboard corners
square_size = 0.04;
num_corners_x = 9;
num_corners_y = 6;
num_corners = num_corners_x * num_corners_y;

% X and Y are both 6x9 matrix
[X,Y] = meshgrid(0:num_corners_x-1, 0:num_corners_y-1);
%p_w_corners is a 54x2 matrix
p_w_corners = square_size * [X(:) Y(:)];
%p_w_corners is a 3*54 matrix
p_w_corners = [p_w_corners zeros(num_corners,1)]';

K = load('/Users/daisiqi/Documents/MATLAB/ex1/data/K.txt');
D = load('/Users/daisiqi/Documents/MATLAB/ex1/data/D.txt');

img_index = 5;
img = rgb2gray(imread(['/Users/daisiqi/Documents/MATLAB/ex1/data/images/',sprintf('img_%04d.jpg',img_index)]));

%Project the corners on the image
T_C_W = poseVectorToTransformationMatrix(poses(img_index,:));

% Transform 3d point from world to current camera pose
p_c_corners = T_C_W * [p_w_corners; ones(1, num_corners)];
p_c_corners = p_c_corners(1:3,:);

projected_pts = projectPoints(p_c_corners, K, D);

figure();
imshow(img);
hold on;
plot(projected_pts(1,:), projected_pts(2,:), 'r.', 'markersize', 12);
hold off;