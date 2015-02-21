% -----------------------------
% Load gpx data of the airport taxiway markers
%------------------------------
INPUT = 'gpx\txwy_brq';
txwy = gpxread(INPUT, 'FeatureType', 'track');
wpt = gpxread(INPUT); %just markers of individual pts approximating txwy

%open map and display route
webmap('WorldTopographicMap')
wmline(txwy, 'OverlayName', 'TXWY', 'Color', 'yellow');
wpt_names = cell(size(wpt));
for i=1:size(wpt)
    wpt_names{i} = ['Waypoint ' num2str(i)];
end
wmmarker(wpt, 'FeatureName', wpt_names, 'OverlayName', 'Waypoints');

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
set_param('aero_ground_model','MaskedZcDiagnostic','none');
sim('aero_ground_model');


% -----------------------------
% Transform airplane trajectory to WGS84 and display on map
%------------------------------
time = [0:0.333:500]; 
x = resample(X,time);
y = resample(Y,time);
Lat = zeros(size(x.Data));
Lon = zeros(size(x.Data));
for i=1:size(x.Data)
    [Lat(i),Lon(i)] = utm2deg(x.Data(i), y.Data(i), zone{1});
end
wmline(Lat, Lon, 'OverlayName', 'Aero', 'Color', 'red');

