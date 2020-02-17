%1. Plot the data

X=[10.4 10.8 11.1 10.2 10.3 10.2 10.7 10.5 10.8 11.2 10.6 11.4];
Y=[7.4 7.6 7.9 7.2 7.4 7.1 7.4 7.2 7.8 7.7 7.8 8.3];
scatter (X,Y) %plots X and Y, they look positively correlated
xlabel('Tail length (cm)')
ylabel('Wing length (cm)')

%2. Calculate R
%By hand:
n = length(X);
sampleMeanX = sum(X)./n;
sampleMeanY = sum(Y)./n;
SSEX = sum((X - sampleMeanX).^2);
SSEY = sum((Y - sampleMeanY).^2);
SCOVXY = sum((X - sampleMeanX).*(Y - sampleMeanY));
rXY = SCOVXY/(sqrt(SSEX)*sqrt(SSEY));
rYX = SCOVXY/(sqrt(SSEY)*sqrt(SSEX));

%Using Matlab:
rMatlab = corrcoef (X,Y);

%Show they're equal
fprintf('rXY = %d = rMatlab = %d.\n',rXY,rMatlab(1,2))
fprintf('rYX = %d = rMatlab = %d.\n',rYX,rMatlab(2,1))

%3. Standard error and 95% confidence intervals
SE = sqrt((1-rXY.^2)/(n-2));
z = 0.5.*log((1+rXY)/(1-rXY));
sz   = sqrt(1/(n-3));
zs   = z+[1 -1].*norminv(0.025).*sz;
CI95 = (exp(2.*zs)-1)./(exp(2.*zs)+1);
disp(sprintf('sem=%.4f, 95 pct CI = [%.4f %.4f]', sr, CI95(1), CI95(2)))

%4. p value for H0: r=0
T = rXY/SE;
p = 1-tcdf(T,n-2); 
disp(sprintf('p=%.4f for H0: r=0', prob))

%5. is r different than r=0.75?
zme   = 0.5*log((1+rXY)/(1-rXY));
zyale = 0.5*log((1+0.75)/(1-0.75));
Z     = (zme-zyale)/sqrt(1/(n-3));
prob2 = 1-tcdf(Z/2,inf);
disp(sprintf('p=%.4f for H0: r=0.75', prob2))

%6. estimate power
v=n-2;
zm=0.5*log((1+rXY)/(1-rXY));

tcrit=tinv(1-0.05/2,n-2);
rcrit=sqrt(tcrit^2/(tcrit^2+(n-2)));
zr=0.5*log((1+rcrit)/(1-rcrit));

Zb=(zm-zr)*sqrt(n-3);
power=normcdf(Zb);
disp(['The power of the test of H0:r=0 is ' num2str(power)])

%calculate power and sample size needed to reject H0 when r>=0.5

Often = 0.01;
rho=0.5; 
AlphaValue=0.05; 
Zb=tinv(1-Often,inf);
Za=tinv(1-AlphaValue/2,inf);
zeta=0.5*log((1+rho)/(1-rho));
SampleSize=round(((Zb+Za)/zeta)^2+3);
disp(['To reject H0:r=0 99% of the time, when r=0.5 and alpha=0.05, we need n>=' num2str(SampleSize)])


