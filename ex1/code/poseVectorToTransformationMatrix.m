function RT = poseVectorToTransformationMatrix(pose)
% From world coordinates to cemara coordinates
% convert 1*6 matrix to 4*4 matrix

w = pose(1:3);
t = pose(4:6);

theta = norm(w);
k = w/theta;
kx = k(1); ky = k(2); kz = k(3);
K = [[0,-kz,ky];[kz,0,-kx];[-ky,kx,0]];

I = eye(3);
R = I + sin(theta)*K + (1-cos(theta))*(K^2);

RT = eye(4);
RT(1:3,1:3) = R;
RT(1:3,4) = t;

end