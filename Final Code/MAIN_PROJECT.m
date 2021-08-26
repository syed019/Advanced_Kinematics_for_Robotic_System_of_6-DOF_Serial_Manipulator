%% 1. INITIALIZATION
%clear variables and close figures
clc; clear all; close all;

%1.1. Define size of figure and create figure handle (DO NOT MODIFY)
set(0,'Units','pixels');
dim = get(0,'ScreenSize');
fig_handle = figure('doublebuffer','on','Position',[0,35,dim(3),dim(4)-100],...
    'Name','3D Object','NumberTitle','off');
set(gcf,'color', [1 1 1]) %Background Colour

%1.2 Define the light in the figure (CHANGE POSITION VECTOR IF FIGURE IS TOO BRIGHT/DARK)
set(fig_handle,'Renderer','zbuffer','doublebuffer','off')
light('color',[.5,.5,.5],'position',[0,1,3],'Style','infinite')
lighting gouraud
daspect([1 1 1]);

%1.3 Axes (TO MODIFY Make sure your axes fit within the region)
axis([-2000 2000 -500 3000 -1000 2000]);  %To be changed to include workspace
view(127,20);                           %To be changed to view from other angle
zoom(0.9)                              %To be changed to zoom in/out
axis on;

%% 2. MANIPULATOR (LOAD THE PARTS IN YOUR MANIPULATOR)
%Load all the individual parts of the manipulator

load Base %This is the square base of the manipulator
setappdata(0,'object_data',object);
object = getappdata(0,'object_data');
obj{1}=object;

load P1 %This is the square base of the manipulator
setappdata(0,'object_data',object);
object = getappdata(0,'object_data');
obj{2}=object;

load R2 %This is the square base of the manipulator
setappdata(0,'object_data',object);
object = getappdata(0,'object_data');
obj{3}=object;

load R3 %This is the square base of the manipulator
setappdata(0,'object_data',object);
object = getappdata(0,'object_data');
obj{4}=object;

load R4 %This is the square base of the manipulator
setappdata(0,'object_data',object);
object = getappdata(0,'object_data');
obj{5}=object;

load R5 %This is the square base of the manipulator
setappdata(0,'object_data',object);
object = getappdata(0,'object_data');
obj{6}=object;

load R6 %This is the square base of the manipulator
setappdata(0,'object_data',object);
object = getappdata(0,'object_data');
obj{7}=object;

load End_Effector %This is the square base of the manipulator
setappdata(0,'object_data',object);
object = getappdata(0,'object_data');
obj{8}=object;

% Print all the parts of the manipulator.
% Note all moving parts are located at the global reference frame.
for i=1:8
    q(i) = patch('faces', obj{i}.F, 'vertices', obj{i}.V);
    set(q(i),'EdgeColor','none');
end

%Set colour to the componenets
set(q(1),'FaceColor', [1,0.242,0.293]); set(q(2),'FaceColor', [.4,0.6,0.6]);
set(q(3),'FaceColor', [.6,0.6,0.4]);    set(q(4),'FaceColor', [1,0.242,0.293]);
set(q(5),'FaceColor', [.4,0.6,0.6]);    set(q(6),'FaceColor', [.6,0.6,0.4]);
set(q(7),'FaceColor', [1,0.242,0.293]); set(q(8),'FaceColor', [.4,0.6,0.6]);

%Rename of all the vertices. This step is redundant obj{}.V will not longer be used.
V{1} = obj{1}.V'; V{2} = obj{2}.V'; V{3} = obj{3}.V';
V{4} = obj{4}.V'; V{5} = obj{5}.V'; V{6} = obj{6}.V';
V{7} = obj{7}.V'; V{8} = obj{8}.V';

%% ANIMATION FUNCTION
% Animation (DO NOT CHANGE)
RGB=256;  %Resolution
fm = getframe; [img,map] = rgb2ind(fm.cdata,RGB,'nodither');

%% 3. PATH GENERATION (MODIFY)

x_ee =      [50.80	101.05	150.18	197.67	243.00	285.66	325.20	361.17	393.18	420.89	443.98	462.21	475.38	483.34	486.00	483.34	475.38	462.21	443.98	420.89	393.18	361.17	325.20	285.66	243.00	197.67	150.18	101.05	50.80	0.00	-202.09	-395.35	-571.33	-722.34	-841.78	-924.43	-966.68	-966.68	-924.43	-841.78	-722.34	-571.33	-395.35	-202.09	0.00	202.09	395.35	571.33	722.34	841.78	924.43	966.68	966.68	924.43	841.78	722.34	571.33	395.35	202.09	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	-175.02	-342.38	-494.78	-625.56	-729.00	-800.58	-837.17	-837.17	-800.58	-729.00	-625.56	-494.78	-342.38	-175.02	0.00	175.02	342.38	494.78	625.56	729.00	800.58	837.17	837.17	800.58	729.00	625.56	494.78	342.38	175.02	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	-101.05	-197.67	-285.66	-361.17	-420.89	-462.21	-483.34	-483.34	-462.21	-420.89	-361.17	-285.66	-197.67	-101.05	0.00	101.05	197.67	285.66	361.17	420.89	462.21	483.34	483.34	462.21	420.89	361.17	285.66	197.67	101.05	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00];
y_ee =     [1809.17	1805.18	1798.53	1789.26	1777.38	1762.93	1745.94	1726.47	1704.56	1680.28	1653.69	1624.86	1593.89	1560.84	1525.81	1488.89	1450.20	1409.83	1367.89	1324.50	1279.78	1233.85	1186.83	1138.86	1090.07	1040.59	990.55	940.10	889.37	838.50	838.50	838.50	838.50	838.50	838.50	838.50	838.50	838.50	838.50	838.50	838.50	838.50	838.50	838.50	838.50	838.50	838.50	838.50	838.50	838.50	838.50	838.50	838.50	838.50	838.50	838.50	838.50	838.50	838.50	838.50	855.46	872.42	889.37	906.30	923.22	940.10	956.96	973.78	990.55	1007.29	1023.97	1040.59	1057.15	1073.65	1090.07	1106.42	1122.69	1138.86	1154.95	1170.94	1186.83	1202.62	1218.29	1233.85	1249.28	1264.60	1279.78	1294.83	1309.73	1324.50	1324.50	1324.50	1324.50	1324.50	1324.50	1324.50	1324.50	1324.50	1324.50	1324.50	1324.50	1324.50	1324.50	1324.50	1324.50	1324.50	1324.50	1324.50	1324.50	1324.50	1324.50	1324.50	1324.50	1324.50	1324.50	1324.50	1324.50	1324.50	1324.50	1324.50	1339.12	1353.58	1367.89	1382.04	1396.02	1409.83	1423.46	1436.92	1450.20	1463.29	1476.19	1488.89	1501.40	1513.71	1525.81	1537.70	1549.38	1560.84	1572.08	1583.10	1593.89	1604.45	1614.77	1624.86	1634.72	1644.32	1653.69	1662.80	1671.67	1680.28	1680.28	1680.28	1680.28	1680.28	1680.28	1680.28	1680.28	1680.28	1680.28	1680.28	1680.28	1680.28	1680.28	1680.28	1680.28	1680.28	1680.28	1680.28	1680.28	1680.28	1680.28	1680.28	1680.28	1680.28	1680.28	1680.28	1680.28	1680.28	1680.28	1680.28	1688.63	1696.73	1704.56	1712.13	1719.43	1726.47	1733.23	1739.72	1745.94	1751.88	1757.54	1762.93	1768.03	1772.85	1777.38	1781.63	1785.59	1789.26	1792.64	1795.73	1798.53	1801.04	1803.25	1805.18	1806.80	1808.13	1809.17	1809.91	1810.35	1810.50	1810.50	1810.50	1810.50	1810.50	1810.50	1810.50	1810.50	1810.50	1810.50	1810.50	1810.50	1810.50	1810.50	1810.50	1810.50	1810.50	1810.50	1810.50	1810.50	1810.50	1810.50	1810.50	1810.50	1810.50	1810.50	1810.50	1810.50	1810.50	1810.50	1810.50];
z_ee =      [162.66	180.62	203.79	232.02	265.11	302.82	344.83	390.80	440.34	493.00	548.33	605.82	664.95	725.20	786.00	846.80	907.05	966.18	1023.67	1079.00	1131.66	1181.20	1227.17	1269.18	1306.89	1339.98	1368.21	1391.38	1409.34	1422.00	1400.76	1337.97	1236.36	1100.39	936.00	750.36	551.60	348.40	149.64	-36.00	-200.39	-336.36	-437.97	-500.76	-522.00	-500.76	-437.97	-336.36	-200.39	-36.00	149.64	348.40	551.60	750.36	936.00	1100.39	1236.36	1337.97	1400.76	1422.00	1421.85	1421.41	1420.67	1419.63	1418.30	1416.68	1414.75	1412.54	1410.03	1407.23	1404.14	1400.76	1397.09	1393.13	1388.88	1384.35	1379.53	1374.43	1369.04	1363.38	1357.44	1351.22	1344.73	1337.97	1330.93	1323.63	1316.06	1308.23	1300.13	1291.78	1273.38	1219.00	1131.01	1013.26	870.89	710.12	537.99	362.01	189.88	29.11	-113.26	-231.01	-319.00	-373.38	-391.78	-373.38	-319.00	-231.01	-113.26	29.11	189.88	362.01	537.99	710.12	870.89	1013.26	1131.01	1219.00	1273.38	1291.78	1283.17	1274.30	1265.19	1255.82	1246.22	1236.36	1226.27	1215.95	1205.39	1194.60	1183.58	1172.34	1160.88	1149.20	1137.31	1125.21	1112.90	1100.39	1087.69	1074.79	1061.70	1048.42	1034.96	1021.33	1007.52	993.54	979.39	965.08	950.62	936.00	925.38	893.98	843.18	775.20	693.00	600.18	500.80	399.20	299.82	207.00	124.80	56.82	6.02	-25.38	-36.00	-25.38	6.02	56.82	124.80	207.00	299.82	399.20	500.80	600.18	693.00	775.20	843.18	893.98	925.38	936.00	921.23	906.33	891.28	876.10	860.78	845.35	829.79	814.12	798.33	782.44	766.45	750.36	734.19	717.92	701.57	685.15	668.65	652.09	635.47	618.79	602.05	585.28	568.46	551.60	534.72	517.80	500.87	483.92	466.96	450.00	450.00	450.00	450.00	450.00	450.00	450.00	450.00	450.00	450.00	450.00	450.00	450.00	450.00	450.00	450.00	450.00	450.00	450.00	450.00	450.00	450.00	450.00	450.00	450.00	450.00	450.00	450.00	450.00	450.00	450.00];

alpha_ee =  [0      0       0       0       0       0       0       0       0       0       180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0   	0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       180     180     180     180     180     180     180     180     180     180     180     180     180     180     0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       180     180     180     180     180     180     180     180     180     180     180     180     180     180     0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180     180];
beta_ee =   [9.0	18.0	27.0	36.0	45.0	54.0	63.0	72.0	81.0	90.0	81.0	72.0	63.0	54.0	45.0	36.0	27.0	18.0	9.0     0.0     -9.0	-18.0	-27.0	-36.0	-45.0	-54.0	-63.0	-72.0	-81.0	-90.0	-78.0	-66.0	-54.0	-42.0	-30.0	-18.0	-6.0	6.0 	18.0	30.0	42.0	54.0	66.0	78.0	90.0	78.0	66.0	54.0	42.0	30.0	18.0	6.0     -6.0	-18.0	-30.0	-42.0	-54.0	-66.0	-78.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-78.0	-66.0	-54.0	-42.0	-30.0	-18.0	-6.0	6.0     18.0	30.0	42.0	54.0	66.0	78.0	90.0	78.0	66.0	54.0	42.0	30.0	18.0	6.0     -6.0	-18.0	-30.0	-42.0	-54.0	-66.0	-78.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-78.0	-66.0	-54.0	-42.0	-30.0	-18.0	-6.0	6.0     18.0	30.0	42.0	54.0	66.0	78.0	90.0	78.0	66.0	54.0	42.0	30.0	18.0	6.0     -6.0	-18.0	-30.0	-42.0	-54.0	-66.0	-78.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-84.0	-78.0	-72.0	-66.0	-60.0	-54.0	-48.0	-42.0	-36.0	-30.0	-24.0	-18.0	-12.0	-6.0	0.0     6.0     12.0	18.0	24.0	30.0	36.0	42.0	48.0	54.0	60.0	66.0	72.0	78.0	84.0	90.0];
gamma_ee =  [-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	-90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0	90.0];

%  POPULATE THIS MATRIX
P_ee = [x_ee; y_ee; z_ee; alpha_ee; beta_ee; gamma_ee];

%% 4. INVERSE KINEMATICS OF THE SPRAY MANIPULATOR

D2 = 838.5;
D4 = 972;
Dee= 945;
s = 180/pi;
u = pi/180;

% Link Parameters of DH table (CHANGE, YOUR DESIGN)
alpha0 = 0;     a0 = 0;     d1_i = 160;     theta1 = 0;   %(d1 is variable)
alpha1 = +90;   a1 = 0;     d2 = -D2;      theta_2 = 0;  %(theta2 is variable)
alpha2 = +90;   a2 = 0;     d3 = 0;        theta_3 = 0;  %(theta3 is variable)
alpha3 = -90;   a3 = 0;     d4 = -D4;      theta_4 = 0;   %(theta4 is variable)
alpha4 = +90;   a4 = 0;     d5 = 0;        theta_5 = 0; %(theta5 is variable)
alpha5 = +90;   a5 = 0;     d6 = 0;        theta_6 = 0; %(theta6 is variable)
alpha6 = 0;     a6 = 0;     dee = Dee;     thetaee = 0;

for i=1:length(P_ee)
    
    %Positions
    Px = P_ee(1,i);
    Py = P_ee(2,i);
    Pz = P_ee(3,i);
    
    alpha = P_ee(4,i);%*u;
    beta  = P_ee(5,i);%*u;
    gamma = P_ee(6,i);%*u;
    
    Rxyz = [cosd(alpha)*cosd(beta), (cosd(alpha)*sind(beta)*sind(gamma))-(sind(alpha)*cosd(gamma)), (cosd(alpha)*sind(beta)*cosd(gamma))+(sind(alpha)*sind(gamma))
        sind(alpha)*cosd(beta), (sind(alpha)*sind(beta)*sind(gamma))+(cosd(alpha)*cosd(gamma)), (sind(alpha)*sind(beta)*cosd(gamma))-(cosd(alpha)*sind(gamma))
        -sind(beta),             cosd(beta)*sind(gamma),                                         cosd(beta)*cosd(gamma)];
    
    % "Theta 3"
    c3 = -(Py+d2)/d4; s3 = sqrt(1-(c3^2));
    theta3 = [atan2(s3,c3) atan2(-s3,c3)];
    R3(:,i) = s*theta3';
    Joints(3,i) = R3(1,i);
    
    % "Theta 2"
    c2_1 = -Px/(d4*s3);  s2_1 = sqrt(1-(c2_1^2));
    c2_2 = -Px/(-d4*s3); s2_2 = sqrt(1-(c2_2^2));
    theta2 = [atan2(s2_1,c2_1) atan2(-s2_1,c2_1) atan2(s2_2,c2_2) atan2(-s2_2,c2_2)];
    R2(:,i) = s*theta2';
    Joints(2,i) = R2(1,i);
    
    % "Prismatic 1"
    d1 = [Pz+d4*s2_1*s3 Pz-d4*s2_1*s3 Pz-d4*s2_2*s3 Pz+d4*s2_2*s3];
    P1(:,i) = d1';
    Joints(1,i) = P1(1,i);
    
    if((i>37 && i<53) || (i>97 && i<113) || (i>157 && i<173) ||(i>217 && i<233))
        Joints(1,i) = P1(2,i);
        Joints(2,i) = R2(2,i);
    end
    
    % Gimbal Lock
    if (s3 == 0)
        s3=0.0001;
        % "Theta 2"
        c2_1 = -Px/(d4*s3);  s2_1 = sqrt(1-(c2_1^2));
        c2_2 = -Px/(-d4*s3); s2_2 = sqrt(1-(c2_2^2));
        theta2 = [atan2(s2_1,c2_1) atan2(-s2_1,c2_1) atan2(s2_2,c2_2) atan2(-s2_2,c2_2)];
        R2(:,i) = s*theta2';
        Joints(2,i) = R2(1,i);
        
        % "Prismatic 1"
        d1 = [Pz+d4*s2_1*s3 Pz-d4*s2_1*s3 Pz-d4*s2_2*s3 Pz+d4*s2_2*s3];
        P1(:,i) = d1';
        Joints(1,i) = P1(1,i);
    end
    
    %Rotation Matrix 0 to 3 obtained from symbolic computation
    R03 = [cosd(Joints(2,i))*cosd(Joints(3,i)), -cosd(Joints(2,i))*sind(Joints(3,i)),  sind(Joints(2,i))
        -sind(Joints(3,i)),              -cosd(Joints(3,i)),               0
        cosd(Joints(3,i))*sind(Joints(2,i)), -sind(Joints(2,i))*sind(Joints(3,i)), -cosd(Joints(2,i))];
    
    % NOA Matrix
    noa=R03'*Rxyz;
    
    nx = noa(1,1); ox = noa(1,2); ax = noa(1,3);
    ny = noa(2,1); oy = noa(2,2); ay = noa(2,3);
    az = noa(3,3);
    
    % "Theta 4"
    s4 = az;
    c4 = -ax;
    theta4 = atan2(s4, c4);
    R4(1,i) = s*theta4;
    Joints(4,i) = R4(1,i);
    
    % "Theta 6"
    s6 = -ox;
    c6 = nx;
    theta6 = atan2(s6, c6);
    R6(:,i) = s*theta6;
    Joints(6,i) = R6(1,i);
    
    % "Theta 5"
    c5 = -ay;
    s5 = sqrt(1-c5^2);
    theta5 = [atan2(s5, c5) atan2(-s5, c5)];
    R5(:,i) = s*theta5';
    Joints(5,i) = R5(2,i);
end

% Error to be less than 0.5% !!!
Dp=my_path;
for i=1:length(Joints)
    for j=1:6
        if (abs((Dp(j,i)-Joints(j,i)))<0.005*abs(Dp(j,i)))
            error(j,i)=0;
        else
            error(j,i)=abs(Joints(j,i)-Dp(j,i));
        end
    end
end

% Converting some of the negative angle into positive,
% from range (0 to 360), e.g -168 to +192,
% for via points to interpolate properly.

for i=1:length(Joints)
    if ((i> 37 && i<53) || (i> 97 && i<113) || (i> 157 && i<173))
        Joints(2,i)=360+Joints(2,i);
    end
    if (i> 16 && i<31)
        Joints(6,i)=360+Joints(6,i);
    end
end

%% 5. TRAJECTORY GENERATION

% k=1;
% for i=0:length(Joints)-1
%     if(mod(i,6)==0)
%         for j=1:6
%             joints(j,k)=Joints(j,i+1);
%         end
%         k=k+1;
%     end
% end
joints=Joints;
stepsize = 0.05; %delta t

% Duration
duration = zeros(1,length(joints(1,:))-1);
for k=1:length(joints(1,:))-1
    duration(k) = 0.01;
end

[D, Velocity, Acceleration, time] = via_points_match_VA(joints, duration, stepsize, 'prescribed', [0,0]);

%% 6. FORWARD KINEMATICS / DISPLACEMENT AND ROTATION OF HANDLE OBJECTS
%INPUTS
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
l=1;
k=1;
kk=21;
% Inertia Tensor
% [P_gb,P_g1,P_g2,P_g3,P_g4,P_g5,P_g6,P_gee,I_base,I_1,I_2,I_3,I_4,I_5,I_6,I_ee] = inertia_tensor;
[mass,P_G,Inertia] = inertia_tensor;
Z = [0 0 1]';
omega=[0 0 0]';
omega_dot=[0 0 0]';
v_dot=[0 0 9.81]';
f_i=[0 0 0]';
m_i=[0 0 0]';

for i=1:length(D(1,:))
    
    %DH parameters (CHANGE BASED ON THE JOINT VARIABLE)
    T_01 = tmat(alpha0, a0, D(1,i), theta1);    R_01 = T_01(1:3,1:3);   P_01 = T_01(1:3,4);
    T_12 = tmat(alpha1, a1, d2, D(2,i));        R_12 = T_12(1:3,1:3);   P_12 = T_12(1:3,4);
    T_23 = tmat(alpha2, a2, d3, D(3,i));        R_23 = T_23(1:3,1:3);   P_23 = T_23(1:3,4);
    T_34 = tmat(alpha3, a3, d4, D(4,i));        R_34 = T_34(1:3,1:3);   P_34 = T_34(1:3,4);
    T_45 = tmat(alpha4, a4, d5, D(5,i));        R_45 = T_45(1:3,1:3);   P_45 = T_45(1:3,4);
    T_56 = tmat(alpha5, a5, d6, D(6,i));        R_56 = T_56(1:3,1:3);   P_56 = T_56(1:3,4);
    T_6ee = tmat(alpha6, a6, dee, thetaee);     R_6ee = T_6ee(1:3,1:3); P_6ee = T_6ee(1:3,4);
    
    Pos = [P_01 P_12 P_23 P_34 P_45 P_56 P_6ee];
    Rot = [R_01 R_12 R_23 R_34 R_45 R_56 R_6ee];
    Rot_t = [R_01' R_12' R_23' R_34' R_45' R_56' R_6ee'];
    
    %Forward Kinematics, Homogeneous Tranforms, Position and Rotation matrices of frames
    T_02 =  T_01*T_12;  R_02 = T_02(1:3,1:3);   P_02 = T_02(1:3,4);
    T_03 =  T_02*T_23;  R_03 = T_03(1:3,1:3);   P_03 = T_03(1:3,4);
    T_04 =  T_03*T_34;  R_04 = T_04(1:3,1:3);   P_04 = T_04(1:3,4);
    T_05 =  T_04*T_45;  R_05 = T_05(1:3,1:3);   P_05 = T_05(1:3,4);
    T_06 =  T_05*T_56;  R_06 = T_06(1:3,1:3);   P_06 = T_06(1:3,4);
    T_0ee = T_06*T_6ee; R_0ee = T_0ee(1:3,1:3); P_0ee = T_0ee(1:3,4);
    
    
    %Outward iteration
    for j=1:6
        if (j==1) % Prismatic
            
            ang_v = Rot_t(:,k:3*j)*omega;
            ang_a = Rot_t(:,k:3*j)*omega_dot;
            lin_a = Rot_t(:,k:3*j)*(cross(omega_dot,Pos(:,j))+cross(omega,cross(omega,Pos(:,j)))+v_dot)+cross(2*omega,Velocity(j,i)*Z)+Acceleration(j,i)*Z;
            
        else % Revolute
            
            ang_v = Rot_t(:,k:3*j)*omega+Velocity(j,i)*Z;
            ang_a = Rot_t(:,k:3*j)*omega_dot+cross(Rot_t(:,k:3*j)*omega,Velocity(j,i)*Z)+(Acceleration(j,i)*Z);
            lin_a = Rot_t(:,k:3*j)*(cross(omega_dot,Pos(:,j))+cross(omega,cross(omega,Pos(:,j)))+v_dot);
            
        end
        
        lin_a_COM = cross(ang_a,P_G(:,j+1))+cross(ang_v,cross(ang_v,P_G(:,j+1)))+lin_a;
        F_inertial = mass(j+1)*lin_a_COM;
        N_inertial = Inertia(:,k:3*j)*ang_a+cross(ang_v,Inertia(:,k:3*j)*ang_v);
        
        omega = ang_v;
        omega_dot = ang_a;
        v_dot = lin_a;
        k=k+3;
    end
    mat_ang_v(:,i) = ang_v;
    mat_ang_a(:,i) = ang_a;
    mat_lin_a(:,i) = lin_a;
    mat_lin_a_COM(:,i) = lin_a_COM;
    mat_F_inertial(:,i) = F_inertial;
    mat_N_inertial(:,i) = N_inertial;
    k=1;
    
    % Inward Iteration
    
    for m = 6:-1:1
        link_f = mat_F_inertial(:,i)+Rot(:,(3*m)+1:kk)*f_i;
        link_n = mat_N_inertial(:,i)+Rot(:,(3*m)+1:kk)*m_i+cross(P_G(:,m+1),mat_F_inertial(:,i))+cross(Pos(:,m+1),Rot(:,(3*m)+1:kk)*f_i);
        
        if (m==1) % Prismatic
            tau = link_f.'*Z;
        else % Revolute
            tau = link_n.'*Z;
        end
        
        f_i = link_f;
        m_i = link_n;
        kk = kk - 3;
    end
    mat_link_f(:,i) = link_f;
    mat_link_n(:,i) = link_n;
    mat_tau(:,i) = tau;
    kk=21;
    %Move Links of Manipulator
    %End-effector moves accordingly with T_03, other links will
    %move based on other T_0i. The following lines find the new
    %orientation and position of the vertices of the end-effector.
    newV{1} = R_01*V{1};
    
    newV{2} = R_01*V{2};
    newV{2} = newV{2} + repmat(P_01,[1 length(newV{2}(1,:))]);
    
    newV{3} = R_02*V{3};
    newV{3} = newV{3} + repmat(P_02,[1 length(newV{3}(1,:))]);
    
    newV{4} = R_03*V{4};
    newV{4} = newV{4} + repmat(P_03,[1 length(newV{4}(1,:))]);
    
    newV{5} = R_04*V{5};
    newV{5} = newV{5} + repmat(P_04,[1 length(newV{5}(1,:))]);
    
    newV{6} = R_05*V{6};
    newV{6} = newV{6} + repmat(P_05,[1 length(newV{6}(1,:))]);
    
    newV{7} = R_06*V{7};
    newV{7} = newV{7} + repmat(P_06,[1 length(newV{7}(1,:))]);
    
    newV{8} = R_0ee*V{8};
    newV{8} = newV{8} + repmat(P_0ee,[1 length(newV{8}(1,:))]);
    
    for ii=1:8 %use for loop for all the parts of your manipulator
        set(q(ii),'Vertices',newV{ii}(1:3,:)'); %Set the new position in the handle (graphical link)
    end
    %        ANIMATION, saves frames (DO NOT MODIFY)
    drawnow  %Draw objects to their new positions
    im= frame2im(getframe);
    gifim(:,:,:,i) = rgb2ind(im, map);
    mov(i)=getframe(gcf);
end

% % %ANIMATION, creates animated gif (DO NOT MODIFY)
imwrite(gifim,map,'Spray Manipulator.gif','DelayTime',0)%,'LoopCount',inf)


%% Jacobian Analysis
for i = 1:length(D)
    [J_3w,inv_J_3w,J_det,A_det,C_det,Tv]=my_jacobian(D(1,i),D(2,i),D(3,i),D(4,i),D(5,i),D(6,i));
    
    % Singularity Check
    if (A_det==0 || C_det==0)
        check(k) = i;
        k=k+1;
    end
    % Inverse Velocity
    qj_dot(:,i) = inv(Tv)*inv_J_3w*Velocity(:,i);
    
    % Forward Velocity
    vj_dot(:,i) = Tv*J_3w*Velocity(:,i);
end

%% Plots

% This function plots all the joints displacement, velocities and
% acceleration wrt to each joint, as well as path generation using comet
% function.
my_plot1(time,D,Velocity,Acceleration,P_ee);

% This function plots all the Forward and Inverse Velocity for all the joints, obtained by
% jacobian analysis.
my_plot2(time,qj_dot,vj_dot);

% This function plots all the Dynamics Relationships of the manipulator.
my_plot3(time,mat_ang_v,mat_ang_a,mat_lin_a,mat_lin_a_COM,mat_F_inertial,mat_N_inertial,mat_link_f,mat_link_n,mat_tau)
