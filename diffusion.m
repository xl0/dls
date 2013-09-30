function diffusion(x,y,c0)

 

xlim=[0 50];
ylim=[0 50];
C=zeros(50,50);
Cnew=zeros(50,50);
C(x,y)=c0;
DeltaT=0.1;       %step of Time
D=0.1;            %diffusion factor
gamma=8;        %cAMP decay rate
DeltaX=1;
DeltaY=1;
test=1;

while test==1

    

    for i=3:48
        for j=3:48
%             if C(i,j)<0
%                 error('Negative value',i,j);
%             end
            Cnew(i,j)= C(i, j) + DeltaT*D*(( ...
                    C(i,j+2) ...
                    +C(i,j-2) ... %previous -
                    +C(i+2,j) ...
                    +C(i-2,j) ...   %previous -
                    +C(i+1,j+1) ...
                    +C(i+1,j-1) ... %previous -
                    +C(i-1,j+1) ... %previous -
                    +C(i-1,j-1) ...
                    )/4); % +(1-gamma*DeltaT)*C(i,j);
        end
    end
    C=Cnew;
    Cnew=zeros(50,50);    %just to be clean. Not mandatory at all
    G=gradient(C);
    mesh(C,G);
    pause on;
    pause(0.5);

end

 

end