%filename:  LV_sa.m
clear all %clear all variables
clf       %and figures
global T TS tauS tauD;
global Csa Rs RMi RAo dt CHECK PLA;
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
  Rosm = (Rs)/(O_2-(Msm/Qvital_plot(klok))); 
  Qskeletalmuscle_plot(klok)=(Psa/(Rosm*O_2))+(Msm/O_2); 
  Ronv = (Rs)/(O_2-(Mnv/Qvital_plot(klok)));
  Qnon_vital_plot(klok)=(Psa/(Ronv*O_2))+(Mnv/O_2);
  SMi_plot(klok)=SMi;
  SAo_plot(klok)=SAo;
end

%plot results:
figure(1)
subplot(4,1,1), plot(t_plot,CLV_plot)
title('Left Ventricular Compliance: DCM');
subplot(4,1,2), plot(t_plot,PLV_plot,t_plot,Psa_plot)
legend('PLV','Psa');
title('Left Ventricular Pressure and Systemic Arterial Pressure: DCM');
subplot(4,1,3), plot(t_plot,QMi_plot,t_plot,QAo_plot)
title('Computer Simulated Blood Flow: DCM')
legend('Mitral Valve Flow (QMi)', 'Aortic Valve Flow (QAo)')
subplot(4,1,4), plot(t_plot,Qvital_plot,t_plot,Qskeletalmuscle_plot,t_plot,Qnon_vital_plot)
title('Computer Simulated Blood Flow: DCM')
legend('Vital Organ Blood Flow','Skeletal Muscle Blood Flow','Non-Vital Organ Flow')

%left ventricular pressure-volume loop
figure(2)
plot(VLV_plot(1200:1500),PLV_plot(1200:1500))
title('PV Loop for Left Ventricle: DCM');
xlabel('Volume');
ylabel('Pressure');
%systemic arterial pressure-volume ``loop''
figure(3)
plot(Vsa_plot,Psa_plot)
title('PV "loop" for Systemic Artery: DCM');
xlabel('Volume');
ylabel('Pressure');
ESP=max(Psa_plot(1200:1500)); %end systolic pressure
EDP=min(Psa_plot(1200:1500)); %end diastolic pressure