function [J_3w,inv_J_3w,J_det,A_det,C_det,Tv] = my_jacobian(d_1,th_2,th_3,th_4,th_5,th_6)

%% Parameters

% 1) Link Lengths (mm)
a_0 = 0;    a_3 = 0;
a_1 = 0;    a_4 = 0;
a_2 = 0;    a_5 = 0;
a_ee = 0;

% 2) Link Twists (deg)
alpha_0 = 0;    alpha_3 = -90;
alpha_1 = +90;  alpha_4 = +90;
alpha_2 = +90;  alpha_5 = +90;
alpha_ee = 0;

% 3) Link Offsets (mm)
% syms d_1 
d_2 = -838.5;   d_3 = 0; 
d_4 = -972;     d_5 = 0;
d_6 = 0;        d_ee = 945;


% 4) Joint Angles (deg)
% syms th_2 th_3 th_4 th_5 th_6
th_1 = 0;
th_ee = 0;

%% MATRICES

T_01    =   [cos(th_1)               sin(th_1)*(-1)          0                  a_0
    sin(th_1)*cosd(alpha_0) cos(th_1)*cosd(alpha_0) sind(alpha_0)*(-1) d_1*sind(alpha_0)*(-1)
    sin(th_1)*sind(alpha_0) cos(th_1)*sind(alpha_0) cosd(alpha_0)      d_1*cosd(alpha_0)
    0                0                0                  1];

T_12    =   [cos(th_2)               sin(th_2)*(-1)          0                  a_1
    sin(th_2)*cosd(alpha_1) cos(th_2)*cosd(alpha_1) sind(alpha_1)*(-1) d_2*sind(alpha_1)*(-1)
    sin(th_2)*sind(alpha_1) cos(th_2)*sind(alpha_1) cosd(alpha_1)      d_2*cosd(alpha_1)
    0                0                0                  1];

T_23    =   [cos(th_3)               sin(th_3)*(-1)          0                  a_2
    sin(th_3)*cosd(alpha_2) cos(th_3)*cosd(alpha_2) sind(alpha_2)*(-1) d_3*sind(alpha_2)*(-1)
    sin(th_3)*sind(alpha_2) cos(th_3)*sind(alpha_2) cosd(alpha_2)      d_3*cosd(alpha_2)
    0                0                0                  1];

T_34    =   [cos(th_4)               sin(th_4)*(-1)          0                  a_3
    sin(th_4)*cosd(alpha_3) cos(th_4)*cosd(alpha_3) sind(alpha_3)*(-1) d_4*sind(alpha_3)*(-1)
    sin(th_4)*sind(alpha_3) cos(th_4)*sind(alpha_3) cosd(alpha_3)      d_4*cosd(alpha_3)
    0                0                0                  1];

T_45    =   [cos(th_5)               sin(th_5)*(-1)          0                  a_4
    sin(th_5)*cosd(alpha_4) cos(th_5)*cosd(alpha_4) sind(alpha_4)*(-1) d_5*sind(alpha_4)*(-1)
    sin(th_5)*sind(alpha_4) cos(th_5)*sind(alpha_4) cosd(alpha_4)      d_5*cosd(alpha_4)
    0                0                0                  1];

T_56    =   [cos(th_6)               sin(th_6)*(-1)          0                  a_5
    sin(th_6)*cosd(alpha_5) cos(th_6)*cosd(alpha_5) sind(alpha_5)*(-1) d_6*sind(alpha_5)*(-1)
    sin(th_6)*sind(alpha_5) cos(th_6)*sind(alpha_5) cosd(alpha_5)      d_6*cosd(alpha_5)
    0                0                0                  1];

T_6ee   =   [cos(th_ee)               sin(th_ee)*(-1)          0                  a_ee
    sin(th_ee)*cosd(alpha_ee) cos(th_ee)*cosd(alpha_ee) sind(alpha_ee)*(-1) d_ee*sind(alpha_ee)*(-1)
    sin(th_ee)*sind(alpha_ee) cos(th_ee)*sind(alpha_ee) cosd(alpha_ee)      d_ee*cosd(alpha_ee)
    0                0                0                  1];


%% Forward Kinematics
%Position and Rotation matrices of matrices.
R_01 = T_01(1:3,1:3);   P_01 = T_01(1:3,4);
R_12 = T_12(1:3,1:3);   P_12 = T_12(1:3,4);
R_23 = T_23(1:3,1:3);   P_23 = T_23(1:3,4);
R_34 = T_34(1:3,1:3);   P_34 = T_34(1:3,4);
R_45 = T_45(1:3,1:3);   P_45 = T_45(1:3,4);
R_56 = T_56(1:3,1:3);   P_56 = T_56(1:3,4);
R_6ee = T_6ee(1:3,1:3); P_6ee = T_6ee(1:3,4);

%Homogeneous Tranforms, Position vectors and Rotation matrices of frames.
T_02 =  T_01*T_12;      R_02 = T_02(1:3,1:3);   P_02 = T_02(1:3,4);
T_03 =  T_02*T_23;      R_03 = T_03(1:3,1:3);   P_03 = T_03(1:3,4);
T_04 =  T_03*T_34;      R_04 = T_04(1:3,1:3);   P_04 = T_04(1:3,4);
T_05 =  T_04*T_45;      R_05 = T_05(1:3,1:3);   P_05 = T_05(1:3,4);
T_06 =  T_05*T_56;      R_06 = T_06(1:3,1:3);   P_06 = T_06(1:3,4);
T_0ee = T_06*T_6ee;     R_0ee = T_0ee(1:3,1:3); P_0ee = T_0ee(1:3,4);
T_36 = T_34*T_45*T_56;  R_36 = T_36(1:3,1:3);   P_36 = T_36(1:3,4);

%% Jacobian (ref_J_w) ref = 3, w = 4
% Joint Direction

% Main Arm
R_33 = eye(3);
Z_33 = R_33(:,3);

R_32 = R_23.';
Z_32 = R_32(:,3);

R_31 = (R_12*R_23).';
Z_31 = R_31(:,3);

%Wrist
Z_34 = R_34(:,3);

R_35 = R_34*R_45;
Z_35 = R_35(:,3);

R_36 = R_34*R_45*R_56;
Z_36 = R_36(:,3);

% Positions vectors
T_14 = T_12*T_23*T_34;
p_1w = T_14(1:3,4);
P_31w = R_31*p_1w;

T_24 = T_23*T_34;
p_2w = T_24(1:3,4);
P_32w = R_32*p_2w;

p_3w = T_34(1:3,4);
P_33w = R_33*p_3w;

P_34w = [0 0 0]';
P_35w = [0 0 0]';
P_36w = [0 0 0]';

% Cross Products
e1 = cross(Z_31,P_31w);
e2 = cross(Z_32,P_32w);
e3 = cross(Z_33,P_33w);
e4 = cross(Z_34,P_34w);
e5 = cross(Z_35,P_35w);
e6 = cross(Z_36,P_36w);

% Matrices & Singularities
lin_vel = [e1 e2 e3 e4 e5 e6];
ang_vel = [zeros(3,1) Z_32 Z_33 Z_34 Z_35 Z_36];
J_3w = [lin_vel; ang_vel];

B = J_3w(4:6,1:3);
B_det = det(B);

zero_J = J_3w(1:3,4:6);
zero_J_det = det(zero_J);

A = J_3w(1:3,1:3);
A_det = det(A);

C = J_3w(4:6,4:6);
C_det = det(C);

J_det = A_det*C_det;

inv_J_3w = [inv(A) zeros(3); -inv(C)*B*inv(A) inv(C)];

%% Velocity Transformation Matrix
%Position Vector P ref_w->ee
R_06 = T_06(1:3,1:3);
P_6ee = T_6ee(1:3,4);

P_0eew = -R_06*P_6ee;

skew = [0   -P_0eew(3,1)    P_0eew(2,1)
    P_0eew(3,1) 0   -P_0eew(1,1)
    -P_0eew(2,1)    P_0eew(1,1) 0];

Tv = [R_03 skew*R_03; zeros(3) R_03];
end
