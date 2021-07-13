function [Surf] = SFS(E)

[width,height,numChannels] = size(E);
if numChannels == 3
    E = rgb2gray(E);
end
E=double(E);

width = ceil(width);
height = ceil(height);
E = E ./ max(E(:));

slant = 0.9703;
tilt = 0.3016;

maxIter = 200;

Zn1 = zeros(width,height);
Si1 = zeros(width,height);
Zn = zeros(width,height);
Si = zeros(width,height);
Si1(:,:) = 0.01;

p = 0.;
q = 0.;

Ps = cos(tilt)*tan(slant);
Qs = sin(tilt)*tan(slant);

Wn=0.0001*0.0001;

for I = 1 : maxIter
    for i= 1: width
        for j = 1 : height
            if (j-1 <1 || i-1 < 1)
                p=0.0;
                q=0.0;
            else
                p = Zn1(i,j) - Zn1(i,j-1);
                q = Zn1(i,j) - Zn1(i-1,j);
            end
            
            pq = 1.0 + p*p + q*q;
            PQs = 1.0 + Ps*Ps + Qs*Qs;
            Eij = E(i,j);
            fz = -1.0*(Eij - max(0.0,(1+p*Ps + q*Qs)/(sqrt(pq) * sqrt(PQs))));
            dfz = -1.0*((Ps + Qs)/(sqrt(pq)*sqrt(PQs)) - (p+q)*(1.0 + p*Ps + q*Qs)/(sqrt(pq*pq*pq)*sqrt(PQs)));
            Y = fz+ dfz*Zn1(i,j);
            K = Si1(i,j) * dfz/(Wn + dfz * Si1(i,j)*dfz);
            Si(i,j) = (1.0 - K*dfz) * Si1(i,j);
            Zn(i,j) = Zn1(i,j) + K*(Y - dfz * Zn1(i,j));
        end
    end
    
    
    for i= 1: width
        for j = 1 : height
            Zn1(i,j) = Zn(i,j);
            Si1(i,j) = Si(i,j);
        end
    end
end

%Normalize surface
min = 1000;
maximum=-1000;
for i=1 : width
    for j = 1 : height 
        if(Zn(i,j) < min)
            min = Zn(i,j);
        end
    end
end

for i=1 : width
    for j = 1 : height 
        
        Zn(i,j) = Zn(i,j) + (-min);
    end
end

for i=1 : width
    for j = 1 : height 
        if(Zn(i,j) > maximum)
            maximum = Zn(i,j);
        end
    end
end
for i=1 : width
    for j = 1 : height 
        
        Zn(i,j) = Zn(i,j) / (maximum);
    end
end
%--------------------------------------------------------------------------

Surf = Zn;

end

