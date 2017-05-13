temp=zeros(nSur,nRoad);
for i=1:nRoad
    for j=1:nSur
        temp(j,i)=summarySur(1,1,i,j);
    end
end
csvwrite('summary_tf_p.csv',temp(2:nSur,:));



for i=1:nRoad
    for j=1:nSur
        temp(j,i)=summarySur(2,1,i,j);
    end
end
csvwrite('summary_tfs_p.csv',temp(2:nSur,:));


for i=1:nRoad
    for j=1:nSur
        temp(j,i)=summarySur(1,2,i,j);
    end
end
csvwrite('summary_tf_speedup.csv',temp(2:nSur,:));

for i=1:nRoad
    for j=1:nSur
        temp(j,i)=summarySur(2,2,i,j);
    end
end
csvwrite('summary_tfs_speedup.csv',temp(2:nSur,:));
