function path_mat = my_path()

path_mat=zeros(6,240);

for j=1:length(path_mat(1,:))
    if (j>=1 && j<=30)
        path_mat(1,j)=150+10*j;
        path_mat(2,j)=3*j;
        path_mat(3,j)=3*j;
        path_mat(4,j)=0;
        path_mat(5,j)=-3*j;
        path_mat(6,j)=12*j;
        if (path_mat(6,j)>180)
            path_mat(6,j)=12*j-360;
        end
        
    elseif (j>=31 && j<=60)
        path_mat(1,j)=450;
        path_mat(2,j)=90+12*(j-30);
        if (path_mat(2,j)>180)
            path_mat(2,j)=90+12*(j-30)-360;
        end
        path_mat(3,j)=90;
        path_mat(4,j)=0;
        path_mat(5,j)=-90;
        path_mat(6,j)=0;%12*(j-30);
        
    elseif (j>=61 && j<=90)
        path_mat(1,j)=450;
        path_mat(2,j)=90;
        path_mat(3,j)=90-(j-60);
        path_mat(4,j)=0;
        path_mat(5,j)=-90+(j-60);
        path_mat(6,j)=0;
        
    elseif (j>=91 && j<=120)
        path_mat(1,j)=450;
        path_mat(2,j)=90+12*(j-90);
        if (path_mat(2,j)>180)
            path_mat(2,j)=90+12*(j-90)-360;
        end
        path_mat(3,j)=60;
        path_mat(4,j)=0;
        path_mat(5,j)=-60;
        path_mat(6,j)=0;%12*(j-90);
        
    elseif (j>=121 && j<=150)
        path_mat(1,j)=450;
        path_mat(2,j)=90;
        path_mat(3,j)=60-(j-120);
        path_mat(4,j)=0;
        path_mat(5,j)=-60+(j-120);
        path_mat(6,j)=0;
        
    elseif (j>=151 && j<=180)
        path_mat(1,j)=450;
        path_mat(2,j)=90+12*(j-150);
        if (path_mat(2,j)>180)
            path_mat(2,j)=90+12*(j-150)-360;
        end
        path_mat(3,j)=30;
        path_mat(4,j)=0;
        path_mat(5,j)=-30;
        path_mat(6,j)=0;%12*(j-150);
        
    elseif (j>=181 && j<=210)
        path_mat(1,j)=450;
        path_mat(2,j)=90;
        path_mat(3,j)=30-(j-180);
        path_mat(4,j)=0;
        path_mat(5,j)=-30+(j-180);
        path_mat(6,j)=0;
        
    else
        path_mat(1,j)=450;
        path_mat(2,j)=90;
        path_mat(3,j)=0;
        path_mat(4,j)=0;
        path_mat(5,j)=0;
        path_mat(6,j)=6*(210-j);
    end
end