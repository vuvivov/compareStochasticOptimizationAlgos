function l = lambdaLSQ(lambda,x,y,p)
sx=size(x);
sp=size(p);
l=0;
%interpolate
for i=1:sp(2)
    if lambda<1
        m=max(x(:,p(1,i)));
        x(:,p(1,i))=interp1(1:sx(1),x(:,p(1,i)),(1:sx(1))*lambda);
        for j=1:length(x(:,p(1,i)))
            x(j,p(1,i))=min(x(j,p(1,i)),m);
        end
    elseif lambda>1
        m=max(y(:,p(1,i)));
        y(:,p(1,i))=interp1(1:sx(1),y(:,p(1,i)),(1:sx(1))/lambda);
        for j=1:length(y(:,p(1,i)))
            y(j,p(1,i))=min(y(j,p(1,i)),m);
        end
    end
    l=l+sum((x(:,p(1,i))-y(:,p(1,i))).^2)*p(2,i);
end

