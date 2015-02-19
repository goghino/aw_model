%load gpx data of the airport taxiway markers
txwy = gpxread('gpx\test', 'FeatureType', 'track');
wpt = gpxread('gpx\test');

%open map and display route
webmap('WorldTopographicMap')
wmline(txwy, 'OverlayName', 'TXWY', 'Color', 'yellow');
wmmarker(wpt, 'FeatureName', 'WPT', 'OverlayName', 'Waypoints');

%convert taxiway from WGS to UTM coordinates
%   Lat. - corresponds to Y axis
%   Lon. - corresponds to X axis
txwyUTM_x=zeros(size(txwy)); %corresponds to longitude coords
txwyUTM_y=zeros(size(txwy)); %corresponds to latitude coords
zone=cell(size(txwy));
for i=1:size(txwy)
    [txwyUTM_y(i),txwyUTM_x(i),zone{i}] = wgs2utm(txwy(i).Latitude, txwy(i).Longitude);
end

%return;

% -----------------------------
%   HERE GOES THE SIMULATION
%------------------------------
%parameters;
%sim('aero_ground_model');

%transform airplane trajectory to WGS84 and display on map
time = [0:0.333:100]; 
x = resample(X,time);
y = resample(Y,time);
Lat = zeros(size(x.Data));
Lon = zeros(size(x.Data));
for i=1:size(x.Data)
    [Lat(i),Lon(i)] = utm2deg(y.Data(i), x.Data(i), zone{1});
end
wmline(Lat, Lon, 'OverlayName', 'Aero', 'Color', 'red');

