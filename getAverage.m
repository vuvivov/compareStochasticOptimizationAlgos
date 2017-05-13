function d=getAverage(p)
p1=[p 'SeedMac.csv'];
p2=[p 'SeedMac.csv'];
%p2=[p 'SeedPC.csv'];
d=[importfile(p1);importfile(p2)];
dim=size(d);
% if dim(1)>100
%     dim(1)=100;
% end
d=[ dim(1) mean(d(1:dim(1),:))];