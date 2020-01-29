
quanta = 10;                   % number of available quanta
pRelease = 0.2;               % release probabilty 
k = 0:10;                     % possible values of k (measured events)
probabilities = binopdf(k,quanta,pRelease) % probabilities of obtaining those values of k, given numer of available quanta and release prob