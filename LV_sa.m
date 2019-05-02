%filename:  LV_sa.m
clear all %clear all variables
clf       %and figures
global T TS tauS tauD;
global Csa Rs RMi RAo dt CHECK PLA;
in_LV_sa

%%%%%%%%%%%%%%%%healthy%%%%%%%%%%%%%%%%

CLVS=(0.00003*4/3); %Healthy Min (systolic)  value of CLV (liters/mmHg)
CLVD=(0.0146);      %Healthy Max (diastolic) value of CLV (liters/mmHg)
VLVd=(0.027);       %Healthy Left ventricular volume when PLV=0 (liters)
PLA=5;              %Healthy Left atrial pressure (mmHg)
PLV=5;           %Healthy Initial value of PLV (mmHg)
CLV_healthy=zeros(1,klokmax);
PLV_healthy=zeros(1,klokmax);
Psa_healthy=zeros(1,klokmax);
VLV_healthy=zeros(1,klokmax);
Vsa_healthy=zeros(1,klokmax);
QMi_healthy=zeros(1,klokmax);
QAo_healthy=zeros(1,klokmax);
Qvital_healthy=zeros(1,klokmax);
Qskeletalmuscle_healthy=zeros(1,klokmax);
Qgi_healthy=zeros(1,klokmax);
SMi_healthy=zeros(1,klokmax);
SAo_healthy=zeros(1,klokmax);

for klok=1:klokmax  
  t=klok*dt;
  PLV_old=PLV;
  Psa_old=Psa;
  CLV_old=CLV;
  CLV=CV_now(t,CLVS,CLVD);
  %find self-consistent 
  %valve states and pressures:
  set_SMi_SAo
  
  %store in arrays for future use:
  t_plot(klok)=t;
  CLV_healthy(klok)=CLV;
  PLV_healthy(klok)=PLV;
  Psa_healthy(klok)=Psa;
  VLV_healthy(klok)=CLV*PLV+VLVd;
  Vsa_healthy(klok)=Csa*Psa+Vsad;
  QMi_healthy(klok)=SMi*(PLA-PLV)/RMi;
  QAo_healthy(klok)=SAo*(PLV-Psa)/RAo;
  Qvital_healthy(klok)=Psa/Rs;
  start = 0.04; %(min)
  grade = 60; %slow, gets to 2 at end of klokmax=15*T/dt
  factor = para(t,start,grade);
  factor_plot(klok)=factor;
  Rosm = (Rs*factor)/(O_2-((Msm)/(Psa/(Rs*factor))));
  Qskeletalmuscle_healthy(klok)=(Psa/(Rosm*O_2))+(Msm/O_2);
  Rogi = (Rs/factor)/(O_2-((Mnv*factor)/(Psa/(Rs/factor))));
  Qgi_healthy(klok)=(Psa/(Rogi*O_2))+(Mnv/O_2);  
  %Qrest(klok) = QAo_healthy(klok)-Qvital_healthy(klok)-Qskeletalmuscle_healthy(klok)-Qgi_healthy(klok);
  SMi_healthy(klok)=SMi;
  SAo_healthy(klok)=SAo;
end

%plot results:
figure(1)
subplot(4,1,1), plot(t_plot,CLV_healthy)
title('Left Ventricular Compliance: Healthy Parasympathetic Response');
subplot(4,1,2), plot(t_plot,PLV_healthy,t_plot,Psa_healthy)
legend('PLV','Psa');
title('Left Ventricular Pressure and Systemic Arterial Pressure: Healthy Parasympathetic Response');
subplot(4,1,3), plot(t_plot,QMi_healthy,t_plot,QAo_healthy)
title('Computer Simulated Blood Flow: Healthy Parasympathetic Response')
legend('Mitral Valve Flow (QMi)', 'Aortic Valve Flow (QAo)')
subplot(4,1,4), plot(t_plot,Qvital_healthy,t_plot,Qskeletalmuscle_healthy,t_plot,Qgi_healthy)
title('Computer Simulated Blood Flow: Healthy Parasympathetic Response')
legend('Vital Organ Blood Flow','Skeletal Muscle Blood Flow','GI Tract Organ Flow')

%left ventricular pressure-volume loop
figure(2)
plot(VLV_healthy(1200:1500),PLV_healthy(1200:1500))
title('PV Loop for Left Ventricle: Healthy Parasympathetic Response');
xlabel('Volume');
ylabel('Pressure');

%%
%%%%%%%%%%%%%%%%diseased%%%%%%%%%%%%%%%%

in_LV_sa
for klok=1:klokmax
  t=klok*dt;
  PLV_old=PLV;
  Psa_old=Psa;
  CLV_old=CLV;
  CLV=CV_now(t,CLVS,CLVD);
  %find self-consistent 
  %valve states and pressures:
  set_SMi_SAo
  %store in arrays for future plotting:
  t_plot(klok)=t;
  CLV_plot(klok)=CLV;
  PLV_plot(klok)=PLV;
  Psa_plot(klok)=Psa;
  VLV_plot(klok)=CLV*PLV+VLVd;
  Vsa_plot(klok)=Csa*Psa+Vsad;
  QMi_plot(klok)=SMi*(PLA-PLV)/RMi;
  QAo_plot(klok)=SAo*(PLV-Psa)/RAo;
  Qvital_plot(klok)=Psa/Rs;
  start = 0.04; %(min)
  grade = 60;
  factor = para(t,start,grade);
  Rosm = (Rs*factor)/(O_2-(Msm/(Psa/(Rs*factor))));
  Qskeletalmuscle_plot(klok)=(Psa/(Rosm*O_2))+(Msm/O_2);
  Rogi = (Rs/factor)/(O_2-((Mnv*factor)/(Psa/(Rs/factor))));
  Qgi_plot(klok)=(Psa/(Rogi*O_2))+(Mnv/O_2);  
  SMi_plot(klok)=SMi;
  SAo_plot(klok)=SAo;
end

%plot results:
figure(3)
subplot(4,1,1), plot(t_plot,CLV_plot)
title('Left Ventricular Compliance: Parasympathetic Response with DCM');
subplot(4,1,2), plot(t_plot,PLV_plot,t_plot,Psa_plot)
legend('PLV','Psa');
title('Left Ventricular Pressure and Systemic Arterial Pressure: Parasympathetic Response with DCM');
subplot(4,1,3), plot(t_plot,QMi_plot,t_plot,QAo_plot)
title('Computer Simulated Blood Flow: Parasympathetic Response with DCM')
legend('Mitral Valve Flow (QMi)', 'Aortic Valve Flow (QAo)')
subplot(4,1,4), plot(t_plot,Qvital_plot,t_plot,Qskeletalmuscle_plot,t_plot,Qgi_plot)
title('Computer Simulated Blood Flow: Parasympathetic Response with DCM')
legend('Vital Organ Blood Flow','Skeletal Muscle Blood Flow','GI Tract Organ Flow')

%left ventricular pressure-volume loop
figure(4)
plot(VLV_plot(1200:1500),PLV_plot(1200:1500))
title('PV Loop for Left Ventricle: Parasympathetic Response with DCM');
xlabel('Volume');
ylabel('Pressure');

%systemic arterial pressure-volume ``loop''
figure(5)
plot(Vsa_plot,Psa_plot)
title('PV "loop" for Systemic Artery: Parasympathetic Response with DCM');
xlabel('Volume');
ylabel('Pressure');
ESP=max(Psa_plot(1200:1500)); %end systolic pressure
EDP=min(Psa_plot(1200:1500)); %end diastolic pressure