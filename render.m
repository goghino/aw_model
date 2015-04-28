%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.

%adjust size of rendered model
scale = 0.05;
step = 1;

%Resampling time data to bigger time-step and adding offset to UTM
%coordinates, so that we don't work with huge numbers but rather small
%distances, starting position of aircraft will allways have coordinates [0 0]
%Resampling speed is 10x, resaple with step 0.033 to get realtime
SAMPLE = 0.06333;
%SAMPLE = 0.333;

end_time = X.Time(length(X.Time));
time = [0:SAMPLE:end_time];
x = resample(X,time);
OFFSET_X = x.Data(1);
x.Data = x.Data - OFFSET_X;

y = resample(Y,time);
OFFSET_Y = y.Data(1);
y.Data = y.Data - OFFSET_Y;

len = size(x.Data);
z = zeros(len(1),1);

%NOSE
end_time = XN.Time(length(XN.Time));
time = [0:SAMPLE:end_time];
xn = resample(XN,time);
xn.Data = xn.Data - OFFSET_X;

yn = resample(YN,time);
yn.Data = yn.Data - OFFSET_Y;

%RIGHT
end_time = XR.Time(length(XR.Time));
time = [0:SAMPLE:end_time];
xr = resample(XR,time);
xr.Data = xr.Data - OFFSET_X;

yr = resample(YR,time);
yr.Data = yr.Data - OFFSET_Y;

%LEFT
end_time = XL.Time(length(XL.Time));
time = [0:SAMPLE:end_time];
xl = resample(XL,time);
xl.Data = xl.Data - OFFSET_X;

yl = resample(YL,time);
yl.Data = yl.Data - OFFSET_Y;

%HEADING ERROR
end_time = HEADING_ERR.Time(length(HEADING_ERR.Time));
time = [0:SAMPLE:end_time];
heading_err = resample(HEADING_ERR,time);

%VELOCITY ERROR
end_time = VELO_ERR.Time(length(VELO_ERR.Time));
time = [0:SAMPLE:end_time];
velo_err = resample(VELO_ERR,time);

%wheels
wheels = [xn.Data yn.Data xr.Data yr.Data xl.Data yl.Data];

%ATTITUDE
roll = zeros(len(1),1);
pitch = zeros(len(1),1);
yaw = resample(PSI,time);

targets=[txwyUTM_x - OFFSET_X txwyUTM_y - OFFSET_Y]';

cd trajectory3;
%theView=[30 40];
theView=[0 90];
trajectory3(x.Data,y.Data,z,roll,pitch,yaw.Data,targets,wheels,heading_err.Data,velo_err.Data,scale,step,'747',theView)
cd ..;

disp('DONE...');