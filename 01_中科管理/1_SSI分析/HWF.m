function [t ym w F1 f1]=HWF(y,dt)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       y     ==> output data              
%       dt    ==> sampling interval        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[N l]=size(y);if (N<l);y=y';[N l]=size(y);end
t=0:dt:(N-1)*dt;
w=0:1/((N-1)*dt):1/dt;
for k=1:l
    ym(:,k)=y(:,k)-mean(y(:,k));
    f1(:,k)=fft(ym(:,k))*dt;
    F1(:,k)=abs(f1(:,k));
end
    
    
