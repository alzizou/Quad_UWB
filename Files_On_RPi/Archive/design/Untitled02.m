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

% Exact = [1000;2000;1000];

Dist01 = 1913; % sqrt( (Exact(1)-Anchor01(1))^2 + (Exact(2)-Anchor01(2))^2 + (Exact(3)-Anchor01(3))^2 ) + randi([-200,200],1,1);
Dist02 = 2739; % sqrt( (Exact(1)-Anchor02(1))^2 + (Exact(2)-Anchor02(2))^2 + (Exact(3)-Anchor02(3))^2 ) + randi([-200,200],1,1);
Dist03 = 6022; % sqrt( (Exact(1)-Anchor03(1))^2 + (Exact(2)-Anchor03(2))^2 + (Exact(3)-Anchor03(3))^2 ) + randi([-200,200],1,1);
Dist04 = 6782; %sqrt( (Exact(1)-Anchor04(1))^2 + (Exact(2)-Anchor04(2))^2 + (Exact(3)-Anchor04(3))^2 ) + randi([-200,200],1,1);
%Dist05 = sqrt( (Exact(1)-Anchor05(1))^2 + (Exact(2)-Anchor05(2))^2 + (Exact(3)-Anchor05(3))^2 ) + randi([-200,200],1,1);

%%
A = [-2*Anchor01(1) -2*Anchor01(2) -2*Anchor01(3) 1;
    -2*Anchor02(1) -2*Anchor02(2) -2*Anchor02(3) 1;
    -2*Anchor03(1) -2*Anchor03(2) -2*Anchor03(3) 1;
    -2*Anchor04(1) -2*Anchor04(2) -2*Anchor04(3) 1]; %-2*Anchor05(1) -2*Anchor05(2) -2*Anchor05(3) 1

Y = [(Dist01^2)-((Anchor01(1)^2)+(Anchor01(2)^2)+(Anchor01(3)^2));
    (Dist02^2)-((Anchor02(1)^2)+(Anchor02(2)^2)+(Anchor02(3)^2));
    (Dist03^2)-((Anchor03(1)^2)+(Anchor03(2)^2)+(Anchor03(3)^2));
    (Dist04^2)-((Anchor04(1)^2)+(Anchor04(2)^2)+(Anchor04(3)^2))]; %(Dist05^2)-((Anchor05(1)^2)+(Anchor05(2)^2)+(Anchor05(3)^2))];

B = (A'*A);
B_inv = B^(-1);
C = B_inv*A';
W = diag([1;1;1;1]);
X = C*W*Y;
Pos = X(1:3)

Eval = B / norm(B);


%%
x_avg = 0; %mean([Anchor01(1);Anchor02(1);Anchor03(1);Anchor04(1)]);
y_avg = 0; %mean([Anchor01(2);Anchor02(2);Anchor03(2);Anchor04(2)]);
z_avg = 0; %mean([Anchor01(3);Anchor02(3);Anchor03(3);Anchor04(3)]);
Max_Dist = max([Dist01;Dist02;Dist03;Dist04]) + 500;
Sum_Dist = (Max_Dist-Dist01) + (Max_Dist-Dist02) + (Max_Dist-Dist03) + (Max_Dist-Dist04);
w1 = (Max_Dist-Dist01)/Sum_Dist;
w2 = (Max_Dist-Dist02)/Sum_Dist;
w3 = (Max_Dist-Dist03)/Sum_Dist;
w4 = (Max_Dist-Dist04)/Sum_Dist;
W = diag([w1;w2;w3;w4])
Thresh = 1e+2;

P0 = [x_avg;y_avg;z_avg];
P(:,1) = P0;
num = 0;
alpha = 1e-9*diag([1;1;1;1]);
err = 10000;
Abs_Dif_err = 10000;

while Abs_Dif_err > Thresh
    
    num = num+1;
    
    Dist01_hat = sqrt( (P(1,num)-Anchor01(1))^2 + (P(2,num)-Anchor01(2))^2 + (P(3,num)-Anchor01(3))^2 );
    Dist02_hat = sqrt( (P(1,num)-Anchor02(1))^2 + (P(2,num)-Anchor02(2))^2 + (P(3,num)-Anchor02(3))^2 ); 
    Dist03_hat = sqrt( (P(1,num)-Anchor03(1))^2 + (P(2,num)-Anchor03(2))^2 + (P(3,num)-Anchor03(3))^2 ); 
    Dist04_hat = sqrt( (P(1,num)-Anchor04(1))^2 + (P(2,num)-Anchor04(2))^2 + (P(3,num)-Anchor04(3))^2 );
    
    Y_hat = [(Dist01_hat^2)-((Anchor01(1)^2)+(Anchor01(2)^2)+(Anchor01(3)^2));
    (Dist02_hat^2)-((Anchor02(1)^2)+(Anchor02(2)^2)+(Anchor02(3)^2));
    (Dist03_hat^2)-((Anchor03(1)^2)+(Anchor03(2)^2)+(Anchor03(3)^2));
    (Dist04_hat^2)-((Anchor04(1)^2)+(Anchor04(2)^2)+(Anchor04(3)^2))];
    
    e = Y - Y_hat;
    
    P_dot = alpha * A' * W * e;
    P_new = P(:,num) + P_dot(1:3);
    
    P(:,num+1) = P_new;
    err = norm(e);
    err_Arr(num,1) = err;
    
    if num >2 
        Dif_err = (err_Arr(num) - err_Arr(num-1));
        Abs_Dif_err = abs(Dif_err);
    end
    Dif_err_Arr(num,1) = Abs_Dif_err;
    
    if num>10
        if Dif_err > 0 
            break
        end
    end
    
    if num>1000
        break
    end
    
end

if P(3,end) < 0
    alpha(3,3) = -alpha(3,3);
    
    err = 10000;
    Abs_Dif_err = 10000;
    num = 0;
    clear P
    P0 = [x_avg;y_avg;z_avg];
    P(:,1) = P0;

    while Abs_Dif_err > Thresh

        num = num+1;

        Dist01_hat = sqrt( (P(1,num)-Anchor01(1))^2 + (P(2,num)-Anchor01(2))^2 + (P(3,num)-Anchor01(3))^2 );
        Dist02_hat = sqrt( (P(1,num)-Anchor02(1))^2 + (P(2,num)-Anchor02(2))^2 + (P(3,num)-Anchor02(3))^2 ); 
        Dist03_hat = sqrt( (P(1,num)-Anchor03(1))^2 + (P(2,num)-Anchor03(2))^2 + (P(3,num)-Anchor03(3))^2 ); 
        Dist04_hat = sqrt( (P(1,num)-Anchor04(1))^2 + (P(2,num)-Anchor04(2))^2 + (P(3,num)-Anchor04(3))^2 );

        Y_hat = [(Dist01_hat^2)-((Anchor01(1)^2)+(Anchor01(2)^2)+(Anchor01(3)^2));
        (Dist02_hat^2)-((Anchor02(1)^2)+(Anchor02(2)^2)+(Anchor02(3)^2));
        (Dist03_hat^2)-((Anchor03(1)^2)+(Anchor03(2)^2)+(Anchor03(3)^2));
        (Dist04_hat^2)-((Anchor04(1)^2)+(Anchor04(2)^2)+(Anchor04(3)^2))];

        e = Y - Y_hat;

        P_dot = alpha * A' * W * e;
        P_new = P(:,num) + P_dot(1:3);

        P(:,num+1) = P_new;
        err = norm(e);
        err_Arr(num,1) = err;

        if num >2 
            Dif_err = (err_Arr(num) - err_Arr(num-1));
            Abs_Dif_err = abs(Dif_err);
        end
        Dif_err_Arr(num,1) = Abs_Dif_err;

        if num>20
            if Dif_err > 0 
                break
            end
        end

        if num>1000
            break
        end

    end
    
end

plot(0:num,P(1,:))
title('X')
figure
plot(0:num,P(2,:))
title('Y')
figure
plot(0:num,P(3,:))
title('Z')
figure
plot(0:num-1,err_Arr)
title('error')
figure
plot(0:num-1,Dif_err_Arr)
title('Diff of Err')

Estimated_Pos = P(:,end)