clear
close all
clc

Anchor01 = [0;0;711];
Anchor02 = [5360;0;737];
Anchor03 = [-305;5868;356];
Anchor04 = [5944;5842;350];
% Anchor05 = [7417;3848;1118];

% Anchor01 = [0;0;711];
% Anchor02 = [5360;0;737];
% Anchor03 = [-305;5868;356];
% Anchor04 = [5944;5842;0];
% Anchor05 = [7417;3848;1118];

Exact = [1000;2000;1000];

Dist01 = 478; % sqrt( (Exact(1)-Anchor01(1))^2 + (Exact(2)-Anchor01(2))^2 + (Exact(3)-Anchor01(3))^2 ) + randi([-200,200],1,1);
Dist02 = 4188; % sqrt( (Exact(1)-Anchor02(1))^2 + (Exact(2)-Anchor02(2))^2 + (Exact(3)-Anchor02(3))^2 ) + randi([-200,200],1,1);
Dist03 = 6425; % sqrt( (Exact(1)-Anchor03(1))^2 + (Exact(2)-Anchor03(2))^2 + (Exact(3)-Anchor03(3))^2 ) + randi([-200,200],1,1);
Dist04 = 8161; %sqrt( (Exact(1)-Anchor04(1))^2 + (Exact(2)-Anchor04(2))^2 + (Exact(3)-Anchor04(3))^2 ) + randi([-200,200],1,1);
%Dist05 = sqrt( (Exact(1)-Anchor05(1))^2 + (Exact(2)-Anchor05(2))^2 + (Exact(3)-Anchor05(3))^2 ) + randi([-200,200],1,1);

A = [2*(Anchor02(1)-Anchor01(1)) 2*(Anchor02(2)-Anchor01(2)) 2*(Anchor02(3)-Anchor01(3));
    2*(Anchor03(1)-Anchor01(1)) 2*(Anchor03(2)-Anchor01(2)) 2*(Anchor03(3)-Anchor01(3));
    2*(Anchor04(1)-Anchor01(1)) 2*(Anchor04(2)-Anchor01(2)) 2*(Anchor04(3)-Anchor01(3))];%2*(Anchor05(1)-Anchor01(1)) 2*(Anchor05(2)-Anchor01(2)) 2*(Anchor05(3)-Anchor01(3))

Y = [(Anchor02(1)^2)+(Anchor02(2)^2)+(Anchor02(3)^2)-(Anchor01(1)^2)-(Anchor01(2)^2)-(Anchor01(3)^2)-(Dist02^2)+(Dist01^2);
    (Anchor03(1)^2)+(Anchor03(2)^2)+(Anchor03(3)^2)-(Anchor01(1)^2)-(Anchor01(2)^2)-(Anchor01(3)^2)-(Dist03^2)+(Dist01^2);
    (Anchor04(1)^2)+(Anchor04(2)^2)+(Anchor04(3)^2)-(Anchor01(1)^2)-(Anchor01(2)^2)-(Anchor01(3)^2)-(Dist04^2)+(Dist01^2)]; %(Anchor05(1)^2)+(Anchor05(2)^2)+(Anchor05(3)^2)-(Anchor01(1)^2)-(Anchor01(2)^2)-(Anchor01(3)^2)-(Dist05^2)+(Dist01^2)

B = (A'*A);
B_inv = B^(-1);
C = B_inv*A';
X = C*Y;
Pos = X

Eval = (A'*A) / norm(B);
Eval1 = (A*A') / norm(B);

det(A'*A)


%%
A1 = [-2*Anchor01(1) -2*Anchor01(2) -2*Anchor01(3) 1;
    -2*Anchor02(1) -2*Anchor02(2) -2*Anchor02(3) 1;
    -2*Anchor03(1) -2*Anchor03(2) -2*Anchor03(3) 1;
    -2*Anchor04(1) -2*Anchor04(2) -2*Anchor04(3) 1]; %-2*Anchor05(1) -2*Anchor05(2) -2*Anchor05(3) 1

Y1 = [(Dist01^2)-((Anchor01(1)^2)+(Anchor01(2)^2)+(Anchor01(3)^2));
    (Dist02^2)-((Anchor02(1)^2)+(Anchor02(2)^2)+(Anchor02(3)^2));
    (Dist03^2)-((Anchor03(1)^2)+(Anchor03(2)^2)+(Anchor03(3)^2));
    (Dist04^2)-((Anchor04(1)^2)+(Anchor04(2)^2)+(Anchor04(3)^2))]; %(Dist05^2)-((Anchor05(1)^2)+(Anchor05(2)^2)+(Anchor05(3)^2))];

B1 = (A1'*A1);
B1_inv = B1^(-1);
C1 = B1_inv*A1';
X1 = C1*Y1;
Pos1 = X1(1:3)

Eval2 = B1 / norm(B1)


A2 = [1 0 0;
    0 1 0;
    0 0 1;
    1 1 1];
Y2 = [X1(1)^2;
    X1(2)^2;
    X1(3)^2;
    X1(4)];
X2 = ((A2'*A2)^(-1))*A2'*Y2;
Pos2 = diag(sign(X1(1:3))) * sqrt(abs(X2));



