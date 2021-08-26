function [mass,P_G,Inertia] = inertia_tensor

%% Parameters (units grams and milimeter)

material_density = 0.0027;
u1 = 0.001;
u2 = 1.0*10^-6;
u3 = 1.0*10^-9;

%Base
mass_b = 392900.625;
P_gb = [0.000 -2.9020 -213.1061]';

I_bxx = 61017762234.37; I_bxy = 0.00; I_bxz = 0.00;
I_byy = 64782384916.99; I_byz = -513090703.13;
I_bzz = 18153025901.37;

I_base = [I_bxx -I_bxy -I_bxz
    -I_bxy I_byy -I_byz
    -I_bxz -I_byz I_bzz];

% Joint 1
mass_1 = 24585.53;
P_g1 = [-0.32 11.61 0.00]';

I_1xx = 255250944.45; I_1xy = -416800.98; I_1xz = 0.00;
I_1yy = 291346050.24; I_1yz = 0.00;
I_1zz = 147359449.68;

I_1 = [I_1xx -I_1xy -I_1xz
    -I_1xy I_1yy -I_1yz
    -I_1xz -I_1yz I_1zz];

% Joint 2
mass_2 = 13733.91;
P_g2 = [0.03 0.06 429.46]';

I_2xx = 3376732460.01; I_2xy = 17055.59; I_2xz = 373203.14;
I_2yy = 33775621925.85; I_2yz = 637156.83;
I_2zz = 13761348.21;

I_2 = [I_2xx -I_2xy -I_2xz
    -I_2xy I_2yy -I_2yz
    -I_2xz -I_2yz I_2zz];

% Joint 3
mass_3 = 11702.10;
P_g3 = [0.04 -262.31 -0.76]';

I_3xx = 1484193151.37; I_3xy = -8768.99; I_3xz = -38887.17;
I_3yy = 23920268.41; I_3yz = -427293.99;
I_3zz = 1470615861.95;

I_3 = [I_3xx -I_3xy -I_3xz
    -I_3xy I_3yy -I_3yz
    -I_3xz -I_3yz I_3zz];

% Joint 4
mass_4 = 4283.77;
P_g4 = [0.00 0.07 92.17]';

I_4xx = 78921407.33; I_4xy = -1.73; I_4xz = 3.94;
I_4yy = 73833198.42; I_4yz = 73237.31;
I_4zz = 9922402.27;

I_4 = [I_4xx -I_4xy -I_4xz
    -I_4xy I_4yy -I_4yz
    -I_4xz -I_4yz I_4zz];

% Joint 5
mass_5 = 4766.31;
P_g5 = [-0.10 -44.46 2.02]';

I_5xx = 44058687.33; I_5xy = -5173.52; I_5xz = -41024.40;
I_5yy = 12304280.63; I_5yz = 63021.21;
I_5zz = 36389912.58;

I_5 = [I_5xx -I_5xy -I_5xz
    -I_5xy I_5yy -I_5yz
    -I_5xz -I_5yz I_5zz];

% Joint 6
mass_6 = 5901.84;
P_g6 = [0.00 0.06 445.50]';

I_6xx = 1286844631.76; I_6xy = 0.00; I_6xz = 0.00;
I_6yy = 1286855956.51; I_6yz = 78000.83;
I_6zz = 4397544.68;

I_6 = [I_6xx -I_6xy -I_6xz
    -I_6xy I_6yy -I_6yz
    -I_6xz -I_6yz I_6zz];

% End-Effector
mass_ee = 2922.39;
P_gee = [-0.32 0.52 -94.50]';

I_eexx = 30809463.03; I_eexy = -427.46; I_eexz = 41553.77;
I_eeyy = 126675054.21; I_eeyz = -167410.43;
I_eezz = 96690996.71;

I_ee = [I_eexx -I_eexy -I_eexz
    -I_eexy I_eeyy -I_eeyz
    -I_eexz -I_eeyz I_eezz];

% Matrix
mass = [mass_b, mass_1, mass_2, mass_3, mass_4, mass_5, mass_6, mass_ee];%*u1;
P_G = [P_gb, P_g1, P_g2, P_g3, P_g4, P_g5, P_g6, P_gee];%*u2;
Inertia = [I_base, I_1, I_2, I_3, I_4, I_5, I_6, I_ee];%*u3;
