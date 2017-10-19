function x_d = distortPoints(x,D)

k1 = D(1); k2 = D(2);
xp = x(1,:); yp = x(2, :);
r = xp.^2 + yp.^2;
xpp = xp .* (1 + k1*r + k2*r.^2);
ypp = yp .* (1 + k1*r + k2*r.^2);

x_d = [xpp; ypp];

end