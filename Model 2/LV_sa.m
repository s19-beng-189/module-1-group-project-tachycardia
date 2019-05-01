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
  Qs_plot(klok)=(Psa/(Ro*O_2))+(M/O_2);
  SMi_plot(klok)=SMi;
  SAo_plot(klok)=SAo;
end

%plot results:
figure(1)
subplot(3,1,1), plot(t_plot,CLV_plot)
title('Left Ventricular Compliance: Compensated Exercise with DCM');
subplot(3,1,2), plot(t_plot,PLV_plot,t_plot,Psa_plot)
legend('PLV','Psa');
title('Left Ventricular Pressure and Systemic Arterial Pressure: Compensated Exercise with DCM');
subplot(3,1,3), plot(t_plot,QMi_plot,t_plot,QAo_plot,t_plot,Qs_plot)
title('Computer Simulated Pulsatile Blood Flow: Compensated Exercise with DCM')
legend('Mitral Valve Flow (QMi)', 'Aortic Valve Flow (QAo)','Systemic Arterial Flow (Qs)')
%left ventricular pressure-volume loop
figure(2)
plot(VLV_plot(1200:1500),PLV_plot(1200:1500))
title('PV Loop for Left Ventricle: Compensated Exercise with DCM');
xlabel('Volume');
ylabel('Pressure');
%systemic arterial pressure-volume ``loop''
figure(3)
plot(Vsa_plot,Psa_plot)
title('PV "loop" for Systemic Artery: Compensated Exercise with DCM');
xlabel('Volume');
ylabel('Pressure');
ESP=max(Psa_plot(1200:1500)); %end systolic pressure
EDP=min(Psa_plot(1200:1500)); %end diastolic pressure