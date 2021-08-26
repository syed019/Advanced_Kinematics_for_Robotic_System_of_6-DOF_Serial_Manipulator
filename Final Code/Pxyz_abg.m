clear all
close all
clc

% Length of links (CHANGE, YOUR DESIGN)
D2 = 838.5;
D4 = 972;
Dee= 945;

% D-H Parameters
alpha0 = 0;     a0 = 0;     theta1 = 0; %(d1 is variable)
alpha1 = +90;   a1 = 0;     d2 = -D2;   %(theta2 is variable)
alpha2 = +90;   a2 = 0;     d3 = 0;     %(theta3 is variable)
alpha3 = -90;   a3 = 0;     d4 = -D4;   %(theta4 is variable)
alpha4 = +90;   a4 = 0;     d5 = 0;     %(theta5 is variable)
alpha5 = +90;   a5 = 0;     d6 = 0;     %(theta6 is variable)
alpha6 = 0;     a6 = 0;     dee = Dee;     thetaee = 0;

D=my_path;
for i=1:length(D(1,:))
    
    %DH parameters (CHANGE BASED ON THE JOINT VARIABLE)
    T_01 = tmat(alpha0, a0, D(1,i), theta1);
    T_12 = tmat(alpha1, a1, d2, D(2,i));
    T_23 = tmat(alpha2, a2, d3, D(3,i));
    T_34 = tmat(alpha3, a3, d4, D(4,i));
    T_45 = tmat(alpha4, a4, d5, D(5,i));
    T_56 = tmat(alpha5, a5, d6, D(6,i));
    T_6ee = tmat(alpha6, a6, dee, thetaee);
    
    %Forward Kinematics
    T_02 =  T_01*T_12;
    T_03 =  T_02*T_23;
    T_04 =  T_03*T_34;
    T_05 =  T_04*T_45;
    T_06 =  T_05*T_56;
    T_0ee = T_06*T_6ee; %Homogeneous Tranforms
    
    %Position and Rotation matrices of frames
    R_01 = T_01(1:3,1:3);   P_01 = T_01(1:3,4);
    R_02 = T_02(1:3,1:3);   P_02 = T_02(1:3,4);
    R_03 = T_03(1:3,1:3);   P_03 = T_03(1:3,4);
    R_04 = T_04(1:3,1:3);   P_04 = T_04(1:3,4);
    R_05 = T_05(1:3,1:3);   P_05 = T_05(1:3,4);
    R_06 = T_06(1:3,1:3);   P_06 = T_06(1:3,4);
    R_0ee = T_0ee(1:3,1:3); P_0ee = T_0ee(1:3,4);
    
    % final position
    Px(1,i)=P_06(1,1);
    Py(1,i)=P_06(2,1);
    Pz(1,i)=P_06(3,1);
    
    r11=R_06(1,1);
    r21=R_06(2,1);
    r31=R_06(3,1);
    r32=R_06(3,2);
    r33=R_06(3,3);
    %beta    
    sb = -r31; cb = sqrt(1.000000000000001-sb^2);
    beta(:,i) =[atan2d(sb,cb) atan2d(sb,-cb)];
    %alpha
    sa = r21; ca = r11;
    alpha(:,i)=[atan2d(sa,ca) atan2d(sa,-ca) atan2d(sa1,ca1) atan2d(sa2,ca2)];
    %gamma
    sg = r32; cg = r33;
    sg1 = r32/cosd(beta(1,i)); cg1 = r33/cosd(beta(1,i));
    sg2 = r32/cosd(beta(2,i)); cg2 = r33/cosd(beta(2,i));
    gamma(:,i)=[atan2d(sg,cg) atan2d(-sg,-cg) atan2d(sg1,cg1) atan2d(sg2,cg2)];
end
Position=[Px; Py; Pz; alpha; beta; gamma];
