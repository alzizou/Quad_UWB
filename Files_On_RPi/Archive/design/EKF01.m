clear
close all
clc

dt = 0.1;
tf = 60;

x(1,1) = 0;
v(1,1) = 0;
vd(1,1) = 0;
a(1,1) = 0;
ex(1,1) = 0;
ev(1,1) = 0;
time(1,1) = 0;
num = 1;
xt = 5;
kpx = 1;
kpv = 1;

A = [0 1;0 0];
B = [0;1];
C = [1 0];
Q = 10*eye(2);
R = 10;

P = struct;
P(1,1).data = eye(2);
P_dot = struct;
P_dot(1,1).data = zeros(2,2);
z = struct;
z(1,1).data = zeros(2,1);
z_dot = struct;
z_dot(1,1).data = zeros(2,1);

x_hat(1,1) = 0;
v_hat(1,1) = 0;
ex_hat(1,1) = 0;
ev_hat(1,1) = 0;
u(1,1) = 0;
y(1,1) = 0;

noise_amp = 0.2;
noise_frq = 100.0;

eta = +1e-0;

figure
for t=dt:dt:tf
    num = num + 1;
    time(num,1) = t;
    
    u(num-1,1) = a(num-1,1) + noise_amp*sin(noise_frq*t);
    y(num-1,1) = x(num-1,1) + noise_amp*sin(noise_frq*t);
    
    P_dot(num,1).data = A*P(num-1,1).data + P(num-1,1).data*A + Q*Q' - P(num-1,1).data*C'*(R^-1)*C*P(num-1,1).data;
    P(num,1).data = P(num-1,1).data + (dt * P_dot(num,1).data);
    z_dot(num,1).data = A*z(num-1,1).data + B*u(num-1,1) + eta*P(num,1).data*C'*(R^-1)*(y(num-1,1) - C*z(num-1,1).data);
    z(num,1).data = z(num-1,1).data + (dt * z_dot(num,1).data);
    
    x_hat(num,1) = z(num,1).data(1);
    v_hat(num,1) = z(num,1).data(2);   
    
    ex_hat(num,1) = x(num-1,1) - x_hat(num,1);
    ev_hat(num,1) = v(num-1,1) - v_hat(num,1);
    
    ex(num,1) = xt - x_hat(num-1,1);
    vd(num,1) = kpx * ex(num,1);
    ev(num,1) = vd(num,1) - v_hat(num-1,1);
    a(num,1) = kpv * ev(num,1);
    
    v(num,1) = v(num-1,1) + (dt * a(num,1));
    x(num,1) = x(num-1,1) + (dt * v(num,1));
    
    subplot(4,2,1)
    plot(time,ex)
    title("ex")
    grid
    drawnow;
    
    subplot(4,2,2)
    plot(time,vd)
    title("vd")
    grid
    drawnow;
    
    subplot(4,2,3)
    plot(time,ev)
    title("ev")
    grid
    drawnow;
    
    subplot(4,2,4)
    plot(time,a)
    title("a")
    grid
    drawnow;
    
    subplot(4,2,5)
    plot(time,v)
    title("v")
    grid
    drawnow;
    
    subplot(4,2,6)
    plot(time,x)
    title("x")
    grid
    drawnow;
    
    subplot(4,2,7)
    plot(time,ex_hat)
    title("ex_{hat}")
    grid
    drawnow;
    
    subplot(4,2,8)
    plot(time,ev_hat)
    title("ev_{hat}")
    grid
    drawnow;
end
