function [erroru,errorv,vqu,vqv]= errorpiv(x,y,u,v)
xc=0:0.005:1;
yc=0:0.005:1;
nu=0.2;t1=0.00005;
absu=zeros(size(xc));
absv=zeros(size(xc));

for j=1:201
absu(1,j)=absu(1,j)+cos(xc(j)).*sin(yc(j)).*exp(-2.*nu.*t1);
absv(1,j)=absv(1,j)-sin(xc(j)).*cos(yc(j)).*exp(-2.*nu.*t1);
end
[m,n]=size(u);
vqu=interp2(x,y,u,xc,yc,'spline');
vqv=interp2(x,y,v,xc,yc,'spline');
erroru=sqrt(sum(abs((absu-vqu).^2),'all'));
errorv=sqrt(sum(abs((absv-vqv).^2),'all'));
disp('done');
end
       
        


