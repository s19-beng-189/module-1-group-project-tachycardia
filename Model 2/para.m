function factor = para(t,start,grade)
%filename: CV_now.m
global T TS tauS tauD;
if(t>start)
  factor = grade^(t);
  if (factor < 1)
      factor = 1;
  elseif(factor > 2)
      factor = 2;
  end
else
  factor = 1;
end
