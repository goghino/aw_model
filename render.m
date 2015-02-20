scale = 0.02;
step = 1;


%Resampling time data to bigger time-step
time = [0:0.333:50]; %speed 10x, resaple with step 0.033 to get realtime
x = resample(X,time);
OFFSET_X = x.Data(1);
x.Data = x.Data - OFFSET_X;

y = resample(Y,time);
OFFSET_Y = y.Data(1);
y.Data = y.Data - OFFSET_Y;

len = size(x.Data);
z = zeros(len(1),1);

roll = zeros(len(1),1);
pitch = zeros(len(1),1);
yaw = resample(PSI,time);

targets=[txwyUTM_x - OFFSET_X txwyUTM_y - OFFSET_Y]';

cd trajectory3;
%theView=[-45 30];
theView=[0 90];
trajectory3(x.Data,y.Data,z,roll,pitch,yaw.Data,targets,scale,step,'747',theView)
cd ..;

disp('DONE...');