%match the quantiles of two arrays x&y;pq is the cum-probability of quantiles;y is the benchmark;x and y are sorted;
function p = qqMatch(x,y,pq)
% x
% y
l=length(y);
if l==length(pq)
    p=x;
    for i=1:length(x)
        if x(i)<y(1)
            p(i)=pq(1)-(pq(2)-pq(1));
        elseif x(i)>y(l)
            p(i)=pq(l)+(pq(l)-pq(l-1));

        else
            temp=0;
            for j=2:l
                if y(j-1)<=x(i)&&x(i)<y(j)
%                     i
%                     j
%                     [y(j-1)
%                     x(i)
%                     y(j)]
                    p(i)=pq(j-1);
                    temp=1;
                    break;
                end
            end
            if temp==0&&x(i)==y(l)
                p(i)=pq(l);
            end
        end
    end
else
    p=nan;
end