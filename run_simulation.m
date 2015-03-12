% -----------------------------
% Load gpx data of the airport taxiway markers
%------------------------------
INPUT = 'gpx\test_spiral_short';
INPUT = 'gpx\txwy_osr_hangar'
txwy = gpxread(INPUT, 'FeatureType', 'track');

%open map and display route
webmap('WorldTopographicMap')
wmline(txwy, 'OverlayName', 'TXWY', 'Color', 'yellow');

%markers of individual pts approximating txwy with radius R=par.switch_distance
% wpt_names = cell(size(txwy));
% radius = 4;
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
parameters;
%set_param('aero_ground_model','MaskedZcDiagnostic','warning');
simOut = sim('aero_ground_model');


% -----------------------------
% Transform airplane trajectory to WGS84 and display on map
%------------------------------
end_time = X.Time(length(X.Time));
SAMPLE = 0.333;
time = [0:SAMPLE:end_time]; 
x = resample(X,time);
y = resample(Y,time);
Lat = zeros(size(x.Data));
Lon = zeros(size(x.Data));
for i=1:size(x.Data)
    [Lat(i),Lon(i)] = utm2deg(x.Data(i), y.Data(i), zone{1});
end
wmline(Lat, Lon, 'OverlayName', 'Aero', 'Color', 'blue');

%nose wheel
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

%right wheel
end_time = XR.Time(length(XR.Time));
time = [0:SAMPLE:end_time]; 
xr = resample(XR,time);
yr = resample(YR,time);
Lat = zeros(size(xr.Data));
Lon = zeros(size(xr.Data));
for i=1:size(xr.Data)
    [Lat(i),Lon(i)] = utm2deg(xr.Data(i), yr.Data(i), zone{1});
end
wmline(Lat, Lon, 'OverlayName', 'Aero R', 'Color', 'green');

%left wheel
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

