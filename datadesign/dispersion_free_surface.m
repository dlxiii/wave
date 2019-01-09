function mroots = dispersion_free_surface(alpha,N,h)
% mroots = dispersion_free_surface(alpha,N,h)
% calculates positive imaginary and N first positive real solutions of alpha = k*tanh(k h)

% Modified by Y. WANG @TUMSAT @June, 2016.
% Codes from https://www.math.auckland.ac.nz/~meylan/code/dispersion/dispersion_free_surface.m

% for complex alpha. 
% It uses three methods - homotopy for starting with alpha =1
% guess with linear expansion and a linear expansion.
% The first roots is positive imaginary 
% and the next are the first N positive real ordered from smallest. 


% maincode
% ------------------------------------------------------------
% If the value for h is not given the default value is h = 1;
% it would be easy to write a much faster program for only real alpha
if nargin == 2
    h = 1;
else
    alpha = h*alpha; % scale the dimensionless alpha to dimensionless wavenumber 
end


% ------------------------------------------------------------
%first of all we calculate the root for alpha = 1;
mroots = zeros(1,N+1);

% the N = 0 case does not involve any of the special methods and is treated separately.
if N ==0; 
    count = 0;
    mroots(count+1) = homotopy(alpha,count);
else
    count = 0;
    mroots(count+1) = homotopy(alpha,count);
    count = count + 1;
    
    while 0 <= 1
        % first of all we calculate the root for alpha = 1;
        mroots(count+1) = homotopy(alpha,count);
        
        if abs(mroots(count + 1) - (1i*count*pi + alpha/(1i*count*pi))) < 0.01
            % Now we can use the close guess
            
            while 0 <=1
                mroots(count + 1) = oneroot(alpha,1i*count*pi + alpha/(1i*count*pi));
                % abs(mroots(count + 1) - (i*count*pi + alpha/(i*count*pi)))
                
                if abs(mroots(count + 1) - (1i*count*pi + alpha/(1i*count*pi))) < 1e-8
                    % Now we can work the rest out easily
                    mroots(count+1:N+1) = 1i*(count:N)*pi + alpha./(1i*(count:N)*pi);
                    count = N;
                    break
                end
                
                if count ==N
                    break
                end
                count = count + 1;
            end
            
        end
        
        if count == N
            break
        end
        count = count +1;
    end
    
end

mroots = -1i/h*mroots;
% mroots(1) = -mroots(1);


% subcode 01
% calculates the Nth root using the homotopy method to give a guess value.
function mroot = homotopy(alpha,N)
% mroot = homotopy(alpha,N)
% calculates the Nth root using the homotopy method

% ------------------------------------------------------------
% give a rough value of the root firstly
if N == 0;
   mroot = oneroot(1,1);
else
   mroot = oneroot(1,1i*N*pi);
end

% ------------------------------------------------------------
% set up the steps before approching the root
% assume an arbitrarily small value of step
step =0.05;
if abs(alpha) < 1
    alphastep = ([1:-step:abs(alpha),abs(alpha)]);
else
    alphastep = ([1:step:abs(alpha),abs(alpha)]);
end

% approch the root based on the rough walue by changing alpha
% moots_n = oneroot(alpha_n,mroot_n-1)
for k=2:length(alphastep)
        mroot = oneroot(alphastep(k),mroot);
end

% ------------------------------------------------------------
% in case of a complex phase angle is not zero 
% because in which root will be same when use the method above
if angle(alpha) > 0
    alphastep = abs(alpha)*exp(1i*[0:pi/30:angle(alpha),angle(alpha)]);
else
    alphastep = abs(alpha)*exp(1i*[0:-pi/30:angle(alpha),angle(alpha)]);
end

% same like above
for k=2:length(alphastep)
   mroot = oneroot(alphastep(k),mroot);
end
  
% subcode 02
% calculates the root of a function defined in f using the Newton-Raphson method.
function out = oneroot(alpha,guess)
% out = oneroot(alpha,guess)
%calculates the root nearest the root guess.

ans1 = guess+1;
out = guess;
while abs(ans1 - out) > 1e-9
    ans1 = out;
    out = ans1 - f(ans1,alpha)/difff(ans1);
end

% subcode 03
% calculate the function of f
function out = f(z,alpha)
% out = f(z,alpha)
% calculate the function of 

out = z*tanh(z) - alpha;

% subcode 04
% calculate the dirivative function of f
function out = difff(z)
% out = difff(z)
% calculate the dirivative function of 

out = tanh(z) + z*sech(z).^2;