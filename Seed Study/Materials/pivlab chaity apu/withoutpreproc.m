clc
close all
xc=0:0.005:1;
yc=0:0.005:1;nu=0.2;t1=0.00005;
absu=cos(xc).*sin(yc).*exp(-2.*nu.*t1);
[xc,yc]=meshgrid(xc,yc);
n=9;
th=multiple_gaussinan(xc,yc,n,0);
tg=multiple_gaussinanth(xc,yc,n,0.00005,0);
[m,n]=size(th);
a=zeros(m,n);
maxth=max(max(th));
minth=min(min(th));
for i=1:m
    for j=1:n
        a(i,j)=a(i,j)+(255*(th(i,j)-minth)/(maxth-minth));
    end
end
maxtg=max(max(tg));
mintg=min(min(tg));
[p1,q]=size(tg);
b=zeros(p1,q);
for i=1:p1
    for j=1:q
        b(i,j)=b(i,j)+(255*(tg(i,j)-mintg)/(maxtg-mintg));
    end
end
image1=repmat(a,3,3);
image2=repmat(b,3,3);
n=20;
r1=zeros(1,n);
r2=zeros(1,n);
for i=1:n
s = cell(15,2); % To make it more readable, let's create a "settings table"
%Parameter                          %Setting           %Options
s{1,1}= 'Int. area 1';              s{1,2}=6;          % window size of first pass
s{2,1}= 'Step size 1';              s{2,2}=3;          % step of first pass
s{3,1}= 'Subpix. finder';           s{3,2}=2;          % 1 = 3point Gauss, 2 = 2D Gauss
s{4,1}= 'Mask';                     s{4,2}=[];         % If needed, generate via: imagesc(image); [temp,Mask{1,1},Mask{1,2}]=roipoly;
s{5,1}= 'ROI';                      s{5,2}=[];         % Region of interest: [x,y,width,height] in pixels, may be left emptys
s{6,1}= 'Nr. of passes';            s{6,2}=i;          % 1-4 nr. of passes
s{7,1}= 'Int. area 2';              s{7,2}=6;          % second pass window size
s{8,1}= 'Int. area 3';              s{8,2}=6;          % third pass window size
s{9,1}= 'Int. area 4';              s{9,2}=6;          % fourth pass window size
s{10,1}='Window deformation';       s{10,2}='*spline'; % '*spline' is more accurate, but slower
s{11,1}='Repeated Correlation';     s{11,2}=1;         % 0 or 1 : Repeat the correlation four times and multiply the correlation matrices.
s{12,1}='Disable Autocorrelation';  s{12,2}=0;         % 0 or 1 : Disable Autocorrelation in the first pass. 
s{13,1}='Correlation style';        s{13,2}=0;         % 0 or 1 : Use circular correlation (0) or linear correlation (1).
s{14,1}='Repeat last pass';         s{14,2}=0;         % 0 or 1 : Repeat the last pass of a multipass analyis
s{15,1}='Last pass quality slope';  s{15,2}=0.025;     % Repetitions of last pass will stop when the average difference to the previous pass is less than this number.
tic % start timer for PIV analysis only
[x, y, u, v typevector,~,~] = piv_FFTmulti(image1,image2,s{1,2},s{2,2},s{3,2},s{4,2},s{5,2},s{6,2},s{7,2},s{8,2},s{9,2},s{10,2},s{11,2},s{12,2},s{13,2},0,s{14,2},s{15,2});
[error1,error2,vqu1,vqv1]=errorpiv(x,y,u,v);
r1(1,i)=error1;
r2(1,i)=error2;
disp(i);
end
figure;
plot(r1);
figure ;
plot(r2);


