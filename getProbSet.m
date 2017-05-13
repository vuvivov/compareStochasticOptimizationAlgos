function d=getProbSet(dir)
d=getAverage([dir 'alignmentiteration1']);

% %%skip8 only
% %d=[d;getAverage([dir 'bluff_road'])];
% d=[d;getAverage([dir 'DiamondRoadalign1'])];
% d=[d;getAverage([dir 'DividedHgwy'])];
% d=[d;getAverage([dir 'HartRdoptimal'])];
% %d=[d;getAverage([dir 'MaxgradeFBC'])];
% %d=[d;getAverage([dir 'northcr_low_volume'])];
% d=[d;getAverage([dir 'NorthernHgwy'])];
% d=[d;getAverage([dir 'redCap'])];
% d=[d;getAverage([dir 'spur3demo'])];

% %%term only
% d=[d;getAverage([dir 'bluff_road'])];
% d=[d;getAverage([dir 'DiamondRoadalign1'])];
% d=[d;getAverage([dir 'DividedHgwy'])];
% d=[d;getAverage([dir 'HartRdoptimal'])];
% d=[d;getAverage([dir 'MaxgradeFBC'])];
% % d=[d;getAverage([dir 'northcr_low_volume'])];
% % d=[d;getAverage([dir 'NorthernHgwy'])];
% d=[d;getAverage([dir 'redCap'])];
% d=[d;getAverage([dir 'spur3demo'])];

%%full
d=[d;getAverage([dir 'bluff_road'])];
 d=[d;getAverage([dir 'DiamondRoadalign1'])];
d=[d;getAverage([dir 'DividedHgwy'])];
d=[d;getAverage([dir 'HartRdoptimal'])];
d=[d;getAverage([dir 'MaxgradeFBC'])];
d=[d;getAverage([dir 'northcr_low_volume'])];
d=[d;getAverage([dir 'NorthernHgwy'])];
d=[d;getAverage([dir 'redCap'])];
d=[d;getAverage([dir 'spur3demo'])];

d=[d;mean(d)];