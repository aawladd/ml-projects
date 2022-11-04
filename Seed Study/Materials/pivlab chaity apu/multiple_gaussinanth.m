function [cc1] = multiple_gaussinanth(xc ,yc, n_gauss, t,show_fig)
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

cc1 = zeros(size(xc));
s = 0.05;
M = 10;
a=M/(2.*pi.*s.^2);
k=0.0000000005;
nu=0.2;
for i = 1:length(x0)
    for j = 1:length(y0)
        b=((xc-x0(i)).^2+(yc-y0(j)).^2)/(2*s.^2);
        dx=-a.*exp(-b).*((xc-x0(i))/s.^2);
        dy=-a.*exp(-b).*((yc-y0(j))/s.^2);
        ddx=-(a.*exp(-b).*(1/s^2))+(dx.*((xc-x0(i))/s.^2));
        ddy=-(a.*exp(-b).*(1/s^2))+(dy.*((yc-y0(j))/s.^2));
        u=cos(xc).*sin(yc).*exp(-2.*nu.*t);
        v=-sin(xc).*cos(yc).*exp(-2.*nu.*t);
        cc1=cc1+a*exp(-b)+k*t*(ddx+ddy)-(u*dx+v*dy)*t;
    end
end
% figure show options: 1 = YES, 0 = NO
if show_fig == 1
    figure;
  %  contourf(xc,yc,cc1)
   pcolor(xc, yc, cc1)
   shading flat
    axis equal tight
    xlabel('x')
    ylabel('y')
end