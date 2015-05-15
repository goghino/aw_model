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

% -----------------------------
% Load gpx track for AutoTaxi 
%------------------------------
%INPUT = 'gpx\test_spiral';
%INPUT = 'gpx\txwy_brq_full'
%INPUT = 'gpx\txwy_dub1'
INPUT = 'gpx\txwy_prh'
%INPUT = 'gpx\txwy_osr_hangar_taxi'
txwy = gpxread(INPUT, 'FeatureType', 'track');

%open map and display route
webmap('WorldTopographicMap')
wmline(txwy, 'OverlayName', 'TXWY', 'Color', 'yellow');

% Display markers of individual wpts approximating
% the txwy with radius R=par.switch_distance
% wpt_names = cell(size(txwy));
% radius = 3;
% az=[];
% for i=1:size(txwy)
%     wpt_names{i} = ['Waypoint ' num2str(i)]; 
%     [lat, lon] = scircle1(txwy(i).Latitude, txwy(i).Longitude, radius, az, wgs84Ellipsoid);
%     wmline(lat, lon, 'Color', 'red', 'OverlayName', wpt_names{i});
% end

%convert taxiway from WGS to UTM (e.g. NED) coordinates
%   Lat. - corresponds to X axis
%   Lon. - corresponds to Y axis
txwyUTM_x=zeros(size(txwy));
txwyUTM_y=zeros(size(txwy));
zone=cell(size(txwy));
for i=1:size(txwy)
    [txwyUTM_x(i),txwyUTM_y(i),zone{i}] = wgs2utm(txwy(i).Latitude, txwy(i).Longitude);
end

% -----------------------------
%   HERE GOES THE SIMULATION
%------------------------------
% Load aircraft and environment parameters
parameters;

% Perfom the simulation
disp('RUNNING SIMULATION...');
simOut = sim('aero_ground_model');


% -----------------------------
% Transform simulated aircraft's trajectory to WGS84 and display on map
%------------------------------
% Selects which feature trajectories are shown on the map
CG = 0;
NOSE = 1;
LEFT = 1;
RIGHT = 1;

% Step size for resampling the time series
SAMPLE = 0.333;

% C.G.
if(CG)
    end_time = X.Time(length(X.Time));
    time = [0:SAMPLE:end_time]; 
    x = resample(X,time);
    y = resample(Y,time);
    Lat = zeros(size(x.Data));
    Lon = zeros(size(x.Data));
    for i=1:size(x.Data)
        [Lat(i),Lon(i)] = utm2deg(x.Data(i), y.Data(i), zone{1});
    end
    wmline(Lat, Lon, 'OverlayName', 'Aero', 'Color', 'blue');
end

% Nose wheel
if(NOSE)
    end_time = XN.Time(length(XN.Time));
    time = [0:SAMPLE:end_time]; 
    xn = resample(XN,time);
    yn = resample(YN,time);
    Lat = zeros(size(xn.Data));
    Lon = zeros(size(xn.Data));
    for i=1:size(xn.Data)
        [Lat(i),Lon(i)] = utm2deg(xn.Data(i), yn.Data(i), zone{1});
    end
    wmline(Lat, Lon, 'OverlayName', 'Aero N', 'Color', 'black');
end

% Right wheel
if(RIGHT)
    end_time = XR.Time(length(XR.Time));
    time = [0:SAMPLE:end_time]; 
    xr = resample(XR,time);
    yr = resample(YR,time);
    Lat = zeros(size(xr.Data));
    Lon = zeros(size(xr.Data));
    for i=1:size(xr.Data)
        [Lat(i),Lon(i)] = utm2deg(xr.Data(i), yr.Data(i), zone{1});
    end
    wmline(Lat, Lon, 'OverlayName', 'Aero R', 'Color', 'red');
end

% Left wheel
if(LEFT)
    end_time = XL.Time(length(XL.Time));
    time = [0:SAMPLE:end_time]; 
    xl = resample(XL,time);
    yl = resample(YL,time);
    Lat = zeros(size(xl.Data));
    Lon = zeros(size(xl.Data));
    for i=1:size(xl.Data)
        [Lat(i),Lon(i)] = utm2deg(xl.Data(i), yl.Data(i), zone{1});
    end
    wmline(Lat, Lon, 'OverlayName', 'Aero L', 'Color', 'red');
end