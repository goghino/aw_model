scale = 0.05;
step = 1;

%Resampling time data to bigger time-step
time = [0:0.333:100];
x = resample(X,time);
y = resample(Y,time);
len = size(x.Data);
z = zeros(len(1),1);

roll = zeros(len(1),1);
pitch = zeros(len(1),1);
yaw = resample(PSI,time);

targets=[par.x_targets; par.y_targets];

cd trajectory3;
trajectory3(x.Data,y.Data,z,roll,pitch,yaw.Data,targets,scale,step,'747', [45 30])
cd ..;