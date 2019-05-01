%filename: in_LV_sa.m  (initialization for LV_sa)
T =0.0125;    %Duration of heartbeat (minutes)
TS=0.0050;    %Duration of systole   (minutes)
tauS=0.0025;  %CLV time constant during systole (minutes)
tauD=0.0075;  %CLV time constant during diastole (minutes)
Rs=(17.86+1.9);     %Systemic resistance (mmHg/(liter/minute))
%Valve resistances here are not supposed to be realistic,
%just small enough to be negligible:
RMi=0.01;     %mitral valve resistance (mmHg/(liter/minute))
RAo=0.01;     %aortic valve resistance (mmHg/(liter/minute))
 
%Oxygen Concentration Coeffcients
a_O2 = 0.0031; %mLO2/mmHgO2/dL of blood from Henry's Law
P_O2 = 70; %mmHg O2
O_2 = a_O2*P_O2; %mL/dL of blood
M = 0.250; %L/min
Ro = Rs/(O_2-(M/6.031)); %6.031 is healthy normal Qs
 
%The following value of Csa is approximate;
%needs adjustment to make blood pressure 120/80:
 
Csa=(0.00175*127/192);  %Systemic arterial compliance (liters/mmHg)
CLVS=(0.00003*4/3)*5; %Min (systolic)  value of CLV (liters/mmHg)
CLVD=(0.0146)*1.3;  %Max (diastolic) value of CLV (liters/mmHg)
Vsad=0.825;   %Systemic arterial volume when Psa=0 (liters)
%doubled volume remaining after ejection to decrease the ejection fraction
VLVd=(0.027*4);   %Left ventricular volume when PLV=0 (liters)
PLA=(5*.8);        %Left atrial pressure (mmHg) decrease 20%
dt=0.01*T;    %Time step duration (minutes)
%This choice implies 100 timesteps per cardiac cycle.
klokmax=15*T/dt; %Total number of timesteps 
%This choice implies simulation of 15 cardiac cycles.
PLV=(5*0.8);                    %Initial value of PLV (mmHg) decrease 20%
Psa=81;                   %Initial value of Psa (mmHg)
%set initial valve states:
SMi=(PLA>PLV); %evaluates to 1 if PLA>PLV, 0 otherwise
SAo=(PLV>Psa); %evaluates to 1 if PLV>Psa, 0 otherwise
CLV=CV_now(0,CLVS,CLVD);  %Initial value of CLV (liters/mmHg)
%Initialize arrays used to store data for plotting:
%Although the program will work without doing this, 
%it will run MUCH faster if MATLAB knows in advance 
%how much space is needed for these arrays.
  t_plot=zeros(1,klokmax);
CLV_plot=zeros(1,klokmax);
PLV_plot=zeros(1,klokmax);
Psa_plot=zeros(1,klokmax);
VLV_plot=zeros(1,klokmax);
Vsa_plot=zeros(1,klokmax);
QMi_plot=zeros(1,klokmax);
QAo_plot=zeros(1,klokmax);
 Qs_plot=zeros(1,klokmax);
SMi_plot=zeros(1,klokmax);
SAo_plot=zeros(1,klokmax);
%For self-checking in the function PLV_Psa_new, set CHECK=1                    
%To skip the self-checking, set CHECK=0
CHECK=0;