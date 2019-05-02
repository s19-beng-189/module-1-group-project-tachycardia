%filename:  LV_sa.m
clear all %clear all variables
clf       %and figures
global T TS tauS tauD;
global Csa Rs RMi RAo dt CHECK PLA;
in_LV_sa
for klok=1:1300
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
  Rs_plot(klok) = Rs;
end

in_LV_sa_new
for klok=1301:klokmax
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
  Rs_plot(klok) = Rs;
end

Ro
Rs
max(Qs_plot)
min(Qs_plot)
%plot results:
figure(1)
subplot(2,1,1),plot(t_plot,PLV_plot,t_plot,Psa_plot)
legend('PLV','Psa','Location','east');
title({'Left Ventricular Pressure and Systemic Arterial Pressure:','Blood Clot'});
subplot(2,1,2),plot(t_plot,Qs_plot)
title('Pulsatile Blood Flow: Blood Clot')
legend('Systemic Arterial Flow','Location','southeast')
%left ventricular pressure-volume loop
figure(2)
plot(VLV_plot(2500:3000),PLV_plot(2500:3000))
hold on
plot(VLV_plot(800:1300),PLV_plot(800:1300))
title('PV loop for left ventricle: Blood Clot');
xlabel('Volume');
ylabel('Pressure');
hold off