function [data]=irregular(Hsig,Tsig,dt,TL)
% [data]=regular(Hmean,Tmean,dt,TL)
% This code generate regular wave elevation with Bredschneider-Mitsuyasu Spectrum.
% Data: April 2017, by WANG YULONG.

mf=1/dt/2;
df=mf/TL*dt;
f=[0.0001:df:mf]';
n=length(f);
S=0.205*(Hsig^2)*(Tsig^-4)*(f.^-5).*exp(-0.75*(Tsig*f).^-4);

WN=randn(2*n,1);
P=fft(WN);
P1=zeros(2*n,1);
P1(1:n)=P(1:n)./abs(P(1:n)).*sqrt(S);
P1(n+1:2*n)=P(n+1:2*n)./abs(P(n+1:2*n)).*flipud(sqrt(S));
plot(f,abs(P1(1:n)).^2)
D=ifft(P1/df);
data=real(D(1:n));
n1=ceil(3*Tsig/dt);
data(1:n1)=data(1:n1).*[0:n1-1]'/(n1-1);

filename = ['irreg_H' num2str(Hsig) '_T' num2str(Tsig) '.wang'];
dlmwrite(filename,data);