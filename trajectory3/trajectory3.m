function trajectory3(x,y,z,pitch,roll,yaw,targets,wheels,scale_factor,step,selector,varargin);



%   *******************************
%   Original file:
%   Function Version 3.0 
%   7/08/2004 (dd/mm/yyyy)
%   Valerio Scordamaglia
%   v.scordamaglia@tiscali.it
%   http://www.mathworks.com/matlabcentral/fileexchange/5656-trajectory-and-attitude-plot-version-3
%
%   Modified:
%   Juraj Kardos
%   19/01/2015
%   xkardo00@stud.fit.vutbr.cz
%   *******************************
%   function trajectory3(x,y,z,pitch,roll,yaw,targets,scale_factor,step,[selector,SoR])
%   
%
%   x,y,z               center trajectory (vector)    [m]
%   
%   pitch,roll,yaw      euler's angles                [rad]
%
%   targets             array of X,Y coordinates of target points
%
%   wheels              coordinates of wheels (N,R,L)   [m]
%                       format is: [xn yn xr yr xl yl]
%   
%   scale_factor        normalization factor          [scalar]
%                              (related to body aircraft dimension)
%   
%   step                attitude sampling factor      [scalar]
%                              (the points number between two body models)
%   
%   selector            select the body model         [string]
%
%                       gripen  JAS 39 Gripen            heli        Helicopter
%                       mig     Mig			             ah64        Apache helicopter
%                       tomcat  Tomcat(Default)          a10
%                       jet     Generic jet		         cessna      Cessna
%                       747     Boeing 747		         biplane     Generic biplane
%                       md90    MD90 jet		         shuttle     Space shuttle
%                       dc10    DC-10 jet
%
%       OPTIONAL INPUT:
%
%
%    View               sets the camera view. Use Matlab's "view" as argument to reuse the current view.                    
%       
%       Note:
%
%    Refernce System:   BFF
%                       X body- The axial force along the X body  axis is
%                       positive along forward; the momentum around X body
%                       is positive roll clockwise as viewed from behind;
%                       Y body- The side force along the Y body axis is
%                       positive along the right wing; the moment around Y
%                       body is positive in pitch up;
%                       Z body- The normal force along the Z body axis is
%                       positive down; the moment around Z body is positive
%                       roll clockwise as viewed from above.

if nargin<10
    disp('  Error:');

    disp('      Error: Invalid Number Inputs!');
    return;
end
if (length(x)~=length(y))|(length(x)~=length(z))|(length(y)~=length(z))
    disp('  Error:');
    disp('      Uncorrect Dimension of the center trajectory Vectors. Please Check the size');
    return;
end
if ((length(pitch)~=length(roll))||(length(pitch)~=length(yaw))||(length(roll)~=length(yaw)))
    disp('  Error:');
    disp('      Uncorrect Dimension of the euler''s angle Vectors. Please Check the size');
    return;
end
if length(pitch)~=length(x)
    disp('  Error:');
    disp('      Size mismatch between euler''s angle vectors and center trajectory vectors');
    return
end
if step>=length(x)
    disp('  Error:');
    disp('      Attitude samplig factor out of range. Reduce step');
    return
end
if step<1
    step=1;

end

if nargin==12
    
    theView=cell2mat(varargin(1));

end
if nargin>12
    disp('Too many inputs arguments');
    return
end
if nargin<11

    %theView=[82.50 2];
    theView=[0 90];
end

if strcmp(selector,'shuttle')
    load 3d\shuttle;
    V=[-V(:,2) V(:,1) V(:,3)];
    V(:,1)=V(:,1)-round(sum(V(:,1))/size(V,1));
    V(:,2)=V(:,2)-round(sum(V(:,2))/size(V,1));
    V(:,3)=V(:,3)-round(sum(V(:,3))/size(V,1));
elseif strcmp(selector,'helicopter')
    load 3d\helicopter;
    V=[-V(:,2) V(:,1) V(:,3)];
    V(:,1)=V(:,1)-round(sum(V(:,1))/size(V,1));
    V(:,2)=V(:,2)-round(sum(V(:,2))/size(V,1));
    V(:,3)=V(:,3)-round(sum(V(:,3))/size(V,1));
elseif strcmp(selector,'747')
    load 3d\boeing_747;
    V=[V(:,2) V(:,1) V(:,3)];
    V(:,1)=V(:,1)-round(sum(V(:,1))/size(V,1));
    V(:,2)=V(:,2)-round(sum(V(:,2))/size(V,1));
    V(:,3)=V(:,3)-round(sum(V(:,3))/size(V,1));
elseif strcmp(selector,'biplane')
    load 3d\biplane;
    V=[-V(:,2) V(:,1) V(:,3)];
    V(:,1)=V(:,1)-round(sum(V(:,1))/size(V,1));
    V(:,2)=V(:,2)-round(sum(V(:,2))/size(V,1));
    V(:,3)=V(:,3)-round(sum(V(:,3))/size(V,1));
elseif strcmp(selector,'md90')
    load 3d\md90;
    V=[-V(:,1) V(:,2) V(:,3)];
    V(:,1)=V(:,1)-round(sum(V(:,1))/size(V,1));
    V(:,2)=V(:,2)-round(sum(V(:,2))/size(V,1));
    V(:,3)=V(:,3)-round(sum(V(:,3))/size(V,1));
elseif strcmp(selector,'dc10')
    load 3d\dc10;
    V=[V(:,2) V(:,1) V(:,3)];
    V(:,1)=V(:,1)-round(sum(V(:,1))/size(V,1));
    V(:,2)=V(:,2)-round(sum(V(:,2))/size(V,1));
    V(:,3)=V(:,3)-round(sum(V(:,3))/size(V,1));
elseif strcmp(selector,'ah64')
    load 3d\ah64;
    V=[V(:,2) V(:,1) V(:,3)];
    V(:,1)=V(:,1)-round(sum(V(:,1))/size(V,1));
    V(:,2)=V(:,2)-round(sum(V(:,2))/size(V,1));
    V(:,3)=V(:,3)-round(sum(V(:,3))/size(V,1));
elseif strcmp(selector,'mig')
    load 3d\mig;
    V=[V(:,2) V(:,1) V(:,3)];
    V(:,1)=V(:,1)-round(sum(V(:,1))/size(V,1));
    V(:,2)=V(:,2)-round(sum(V(:,2))/size(V,1));
    V(:,3)=V(:,3)-round(sum(V(:,3))/size(V,1));
elseif strcmp(selector,'tomcat')
    load 3d\tomcat;
    V=[-V(:,2) V(:,1) V(:,3)];
    V(:,1)=V(:,1)-round(sum(V(:,1))/size(V,1));
    V(:,2)=V(:,2)-round(sum(V(:,2))/size(V,1));
    V(:,3)=V(:,3)-round(sum(V(:,3))/size(V,1));
elseif strcmp(selector,'jet')
    load 3d\80jet;
    V=[-V(:,2) V(:,1) V(:,3)];
    V(:,1)=V(:,1)-round(sum(V(:,1))/size(V,1));
    V(:,2)=V(:,2)-round(sum(V(:,2))/size(V,1));
    V(:,3)=V(:,3)-round(sum(V(:,3))/size(V,1));
elseif strcmp(selector,'cessna')
    load 3d\83plane;
    V=[-V(:,2) V(:,1) V(:,3)];
    V(:,1)=V(:,1)-round(sum(V(:,1))/size(V,1));
    V(:,2)=V(:,2)-round(sum(V(:,2))/size(V,1));
    V(:,3)=V(:,3)-round(sum(V(:,3))/size(V,1));
elseif strcmp(selector,'A-10')
    load 3d\A-10;
    V=[V(:,3) V(:,1) V(:,2)];
    V(:,1)=V(:,1)-round(sum(V(:,1))/size(V,1));
    V(:,2)=V(:,2)-round(sum(V(:,2))/size(V,1));
    V(:,3)=V(:,3)-round(sum(V(:,3))/size(V,1));
elseif strcmp(selector,'gripen')
    load 3d\gripen;
    V=[-V(:,1) -V(:,2) V(:,3)];
    V(:,1)=V(:,1)-round(sum(V(:,1))/size(V,1));
    V(:,2)=V(:,2)-round(sum(V(:,2))/size(V,1));
    V(:,3)=V(:,3)-round(sum(V(:,3))/size(V,1));
else    
    try
    eval(['load ' selector ';']);
    V(:,1)=V(:,1)-round(sum(V(:,1))/size(V,1));
    V(:,2)=V(:,2)-round(sum(V(:,2))/size(V,1));
    V(:,3)=V(:,3)-round(sum(V(:,3))/size(V,1));
    catch
    str=strcat('Warning: ',selector,' not found.    Default=gripen');
    disp(str);
    load 3d\gripen;
    V=[V(:,3) V(:,1) V(:,2)];
    end
end
correction=max(abs(V(:,1)));
V=V./(scale_factor*correction);
ii=length(x);
resto=mod(ii,step);

%%%%%%%%%%%%%%%Prepare video output file%%%%%%%%%%%%%%%%%%%
%http://www.mathworks.com/help/matlab/ref/videowriter-class.html
writerObj = VideoWriter('video.avi');
open(writerObj);
set(gca,'nextplot','replacechildren');
set(gcf,'Renderer','zbuffer');

%%%%%%%%%%%%%%%needed for the transformation%%%%%%%%%%%%%%%
y=y;
z=z;
pitch=pitch;
roll=roll;
yaw=yaw;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MAX=(ii-resto);
START = 1;
%MAX = 200;
WHOLE_TRACK = 1;
for i=START:step:(ii-resto)
    
    if(i > MAX)
        break;
    end

    clf;
    %create offset between data limit values and figure edges to view whole
    %area and whole airplane when it reaches these limit values
    if(WHOLE_TRACK)
        offset=50;
        plot3(min(x)-offset,min(y)-offset,0,'white'); hold on;
        plot3(max(x)+offset,max(y)+offset,0,'white'); hold on;
    else
        offset=25;
        plot3(x(START)-4*offset,y(START)-4*offset,0,'white'); hold on;
        plot3(x(START)+offset,y(START)+offset,0,'white'); hold on;  
    end
    
    %draw already covered trajectory
    %plot3(x(1:i),y(1:i),z(1:i),'blue'); %C.G.
    plot3(wheels(START:i,1),wheels(START:i,2),z(START:i),'blue'); %Nose
    plot3(wheels(START:i,3),wheels(START:i,4),z(START:i),'red'); %Right
    plot3(wheels(START:i,5),wheels(START:i,6),z(START:i),'red'); %Left
    hold on;
    
    
    %draw target points
    if(WHOLE_TRACK)
        plot3(targets(1,:),targets(2,:),zeros(1,length(targets(1,:))),'Color',[0.92,0.81,0.11]); hold on;
    end
    
    grid on;
    hold on;
    light;

    theta=pitch(i);
    phi=-roll(i);
    psi=yaw(i);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Tbe=[cos(psi)*cos(theta), -sin(psi)*cos(theta), sin(theta);
         cos(psi)*sin(theta)*sin(phi)+sin(psi)*cos(phi) ...
         -sin(psi)*sin(theta)*sin(phi)+cos(psi)*cos(phi) ...
         -cos(theta)*sin(phi);
         -cos(psi)*sin(theta)*cos(phi)+sin(psi)*sin(phi) ...
         sin(psi)*sin(theta)*cos(phi)+cos(psi)*sin(phi) ...
         cos(theta)*cos(phi)];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Vnew=V*Tbe;
    rif=[x(i) y(i) z(i)];
    X0=repmat(rif,size(Vnew,1),1);
    Vnew=Vnew+X0;
    p=patch('faces', F, 'vertices' ,Vnew);
    set(p, 'facec', [1 0 0]); %face color         
    set(p, 'EdgeColor','none'); %edge color

    view(theView);
    axis equal;
    xlabel('X');
    ylabel('Y');
    zlabel('Z');

    if i == START
        ax = axis;
    else
        axis(ax);
    end

    lighting phong
    M = getframe;
    writeVideo(writerObj,M);
end

close(writerObj);























