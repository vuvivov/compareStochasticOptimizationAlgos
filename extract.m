nCase=2;
nProb=10;


%dir0='/Users/shangweixie/Dropbox/Sukanto/xswResults/';
dir0='C:\Users\xs\Dropbox\Sukanto\xswResults\';

dir=[dir0 'true\'];
data=getProbSet(dir);

dir=[dir0 'greedy07\'];
data=[data;getProbSet(dir)];


dir0='C:\Users\xs\Dropbox\Sukanto\xswResults\';

data2=data;


for i=1:nCase
        data2(((i-1)*(nProb+1)+1):((i-1)*(nProb+1)+nProb),:)=data2(((i-1)*(nProb+1)+1):((i-1)*(nProb+1)+nProb),:)./data(1:nProb,:);
        data2(((i-1)*(nProb+1)+nProb+1),:)=mean(data2(((i-1)*(nProb+1)+1):((i-1)*(nProb+1)+nProb),:));
end

data3=data2-1;

dim=size(data);
csvwrite([dir0 'z_summary\result.csv'],[zeros(1,dim(2)) ;data ;zeros(1,dim(2)) ;data2;zeros(1,dim(2)) ;data3]);