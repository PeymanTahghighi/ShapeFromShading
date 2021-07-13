
M=128;
N=128;
E = zeros(M,N);
fid = fopen('img', 'r') ;
data = fscanf(fid, '%f');
fclose(fid);
surface=zeros(M,N);
for i=0 : M-1
    for j = 1 : N
        E(i+1,j) = data(i*M + j);
    end
end

figure;
surfl(surface);
shading interp;
colormap gray(256);
lighting phong;
imshow(E)
imwrite(E,'sphere.bmp');