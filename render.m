%adjust size of rendered model
scale = 0.03;
step = 1;

%Resampling time data to bigger time-step and adding offset to UTM
%coordinates, so that we don't work with huge numbers but rather small
%distances, starting position of aircraft will allways have coordinates [0 0]
%Resampling speed is 10x, resaple with step 0.033 to get realtime
end_time = X.Time(length(X.Time));
time = [0:0.333:end_time];
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