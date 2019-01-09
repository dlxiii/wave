function [KR, A_in,A_ref, SP1,SP2, n_min,n_max] = reflection_wave(etai,etar,dl,h,dt,g_min,g_max,p_flag)

N = length(etai);   % Length of wave array.
T = N * dt;         % 
f = 1 / T;
n = 1 : N;          % number of data
t = dt * (n - 1);   % time

C1 = fft(etai,N) / (N/2);
C2 = fft(etar,N) / (N/2);

SP1 = C1.*conj(C1);
SP2 = C2.*conj(C2);

A1 = real(C1(1 : (N/2)));
B1 = imag(C1(1 : (N/2)));
A2 = real(C2(1 : (N/2)));
B2 = imag(C2(1 : (N/2)));

k(1) = 0;
for count = 1 : (N/2) - 1
    omega(count) = 2 * pi * count / T;
    [k(count+1),L]=wavenumber(T/count,h);
end

lcd = 2*abs(sin(k.*dl));
nume1 = (A2'-A1'.*cos(k.*dl)-B1'.*sin(k.*dl)).^2;
nume2 = (B2'+A1'.*sin(k.*dl)-B1'.*cos(k.*dl)).^2;
nume3 = (A2'-A1'.*cos(k.*dl)+B1'.*sin(k.*dl)).^2;
nume4 = (B2'-A1'.*sin(k.*dl)-B1'.*cos(k.*dl)).^2;

for a = 1:(N/2);
    if lcd(a) ~= 0;
        A_in(a)  = sqrt(nume3(a) + nume4(a)) ./ lcd(a);
        A_ref(a) = sqrt(nume1(a) + nume2(a)) ./ lcd(a);
    else
        A_in(a)  = NaN;
        A_ref(a)  = NaN;
    end
end

% eliminate outbound frequency components
L_min = dl/g_max;
L_max = dl/g_min;
k_min = 2*pi/L_min;
k_max = 2*pi/L_max;
w_min = sqrt(9.8*k_min*tanh(k_min*h));
w_max = sqrt(9.8*k_max*tanh(k_max*h));
f_min = k_min/(2*pi);
f_max = k_max/(2*pi);
n_min = round(f_max/f);
n_max = round(f_min/f);
clear B_in B_ref
B_in =  A_in(n_min:n_max);
B_ref = A_ref(n_min:n_max);

%
E_in = nansum( (B_in.^2) / 2);
E_ref = nansum( (B_ref.^2)/ 2);

KR = sqrt(E_ref ./ E_in);

% --- plot test
if p_flag == 1
    K = 1:kn_max;
    clf;
    subplot(211)
    plot(t,eta1,t,eta2);
    semilogx(K,SP1(1:15000),'b-');
    semilogx(K,SP1(1:15000),'g-');
    subplot(212)
    semilogx(K,A_in,K,A_ref);
    hold on
    semilogx([K(n_min) K(n_min)],[0 max(A_in)],'k--');
    semilogx([K(n_max) K(n_max)],[0 max(A_in)],'k--');
    hold off
end