%calculate the ratio of the area under x versus ref
function y = relativeArea(x,ref)
y=mean(x./ref);