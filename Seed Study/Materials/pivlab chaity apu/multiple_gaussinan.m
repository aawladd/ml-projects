function [cc] = multiple_gaussinan(xc ,yc, n_gauss, show_fig)
%
%--------------------------------------------------------------------------
% Generate multiple Gaussian profiles
%
% parameters
% xc        : gridded points in x dir
% yc        : gridded points in y dir
% n_gauss   : no. of Gaussian
% show_fig  : figure show options: 1 = YES, 0 = NO
%--------------------------------------------------------------------------
%
%disp('Generating multiple Gaussian profiles')
%
x0 = linspace(0, 1, 1 + n_gauss);
y0 = linspace(0, 1, 1 + n_gauss);

cc = zeros(size(xc));
s = 0.05;
M = 10;

for i = 1:length(x0);
    for j = 1:length(y0);
        cc = cc + M / (2*pi*s^2) * exp( -((xc-x0(i)).^2+(yc-y0(j)).^2)/(2*s^2));
    end
end

% figure show options: 1 = YES, 0 = NO
if show_fig == 1
    figure;
    %contourf(xc,yc,cc)
    pcolor(xc, yc, cc')
   shading flat
    axis equal tight
    xlabel('x')
    ylabel('y')
end