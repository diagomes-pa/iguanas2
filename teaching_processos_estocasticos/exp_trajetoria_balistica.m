%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Experimento avulso.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
close
clc

function dY=moto_balistico(t,Y)
global rho S cd m g opz_aereo_y
%X(1)=Vx
%X(2)=Vy
%X(3)=x
%X(6)=y;
Vx=Y(1);
Vy=Y(2);
% Moto lungo x
% Sommatorie forze lungo x==> Solo aereo
Faereo_x=0.5*rho*S*Vx^2*cd;
% Moto lungo y
% Sommatorie forze lungo y==> Aereo+Gravità
Faereo_y=0.5*rho*S*Vy^2*cd*opz_aereo_y;
Fgrav=m*g;
dY(1)=-Faereo_x/m;
dY(2)=-(Faereo_y*sign(Vy)+Fgrav)/m;
dY(3)=Vx;
dY(4)=Vy;
dY=dY';
endfunction

global rho S cd m g opz_aereo_y
rho=1; %Air density [kg/m3]
S=0.1; %Surface [m2]
cd=0.8; %Drag coefficient [-]
m=0.8; %mass [kg]
g=9.8065; %gravitational acceleration [m/s2]
tf=10; %Simulation final time [s]
%Initial conditions
V0=30; %Initial speed [m/s]
x0=0; %Initial x [m]
y0=10; %Initial y [m]
opz_aereo_y=1; %Consider or not the aerodynamic drag along y
alpha_ini = 10*ones(2,1); %Launch angle
%Some figure setting and mtrix initialization
col='brgmck';
col=repmat(col,1,10);
range=zeros(size(alpha_ini));
max_h=range;
leg=cell(length(alpha_ini),1);
figure(1)
clf
subplot(2,2,[1 3])
hold on
grid on
xlabel('range [m]','FontWeight','bold')
ylabel('Height [m]','FontWeight','bold')
set(gca,'FontWeight','bold')
%Loop over launch angle
for ii=1:length(alpha_ini)
    alpha0=deg2rad(alpha_ini(ii));

    Vx0=V0*cos(alpha0);
    Vy0=V0*sin(alpha0);

    [t, Y]=ode45(@moto_balistico,[0 tf],[Vx0 Vy0 x0 y0]');

    x=linspace(min(Y(:,3)),max(Y(:,3)),1000);
    data=zeros(1000,3);

    for jj=1:4
        data(:,jj)=interp1(Y(:,3),Y(:,jj),x,'linear');
    end
    t=interp1(Y(:,3),t,x,'linear');

    pos_ground=find(data(:,4)<0,1,'first');
    data(pos_ground:end,:)=[];
    data = data + 0.1*randn(size(data));

    range(ii)=data(end,3);
    max_h(ii)=max(data(:,4));

    subplot(2,2,[1 3])
    scatter(data(:,3),data(:,4),col(ii),'filled', 'LineWidth',2)
    drawnow

    leg{ii}=['\alpha = ',num2str(alpha_ini(ii)),' °'];
end


