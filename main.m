initialization
 addpath('/Users/shangweixie/Documents/MATLAB/package/%tightfig');
slash='/';
dir0='/Users/shangweixie/desktop/Sukanto/xswResults/';
nRoad=10;nSur=11;
roadNameShow=2;
surNameShow=2;
roadName=cell(nRoad,3);initSol=zeros(nRoad,1);
i=1;roadName{i,1}='alignmentiteration1';roadName{i,2}='A';initSol(i)=203399.2878;
i=i+1;roadName{i,1}='bluff_road';roadName{i,2}='B';initSol(i)=8431.913549;
i=i+1;roadName{i,1}='DiamondRoadalign1';roadName{i,2}='C';initSol(i)=17036.20274;
i=i+1;roadName{i,1}='DividedHgwy';roadName{i,2}='D';initSol(i)=18964151.78;
i=i+1;roadName{i,1}='HartRdoptimal';roadName{i,2}='E';initSol(i)=41540.81589;
i=i+1;roadName{i,1}='MaxgradeFBC';roadName{i,2}='F';initSol(i)=31253.04302;
i=i+1;roadName{i,1}='northcr_low_volume';roadName{i,2}='G';initSol(i)=1598.637093;
i=i+1;roadName{i,1}='NorthernHgwy';roadName{i,2}='H';initSol(i)=241285.8801;
i=i+1;roadName{i,1}='redCap';roadName{i,2}='I';initSol(i)=46777.95833;
i=i+1;roadName{i,1}='spur3demo';roadName{i,2}='J';initSol(i)=8288.112585;
surName=cell(nSur,3);
i=1;surName{i,1}='true';surName{i,2}='org';
i=i+1;surName{i,1}='sur0';surName{i,2}='const';
i=i+1;surName{i,1}='sur1';surName{i,2}='=true';
i=i+1;surName{i,1}='prep';surName{i,2}='preOff';
i=i+1;surName{i,1}='skip2';surName{i,2}='skip2';
i=i+1;surName{i,1}='skip4';surName{i,2}='skip4';
i=i+1;surName{i,1}='term2';surName{i,2}='term2';
i=i+1;surName{i,1}='term4';surName{i,2}='term4';
i=i+1;surName{i,1}='dEarthmove';surName{i,2}='noEM';
i=i+1;surName{i,1}='dp10';surName{i,2}='DP';
i=i+1;surName{i,1}='greedy07';surName{i,2}='grd';

for i=1:nSur
    surName{i,3}=num2str(i-1);
end


% i=i+1;surName{i,1}='greedy08';surName{i,2}='greedy.8';


resampleSize=10^3;
nSeed=100;
tcut=75;
nt=1000;%10^3 looks good enough
scale=[.1:.1:1 2:10];
scaleSelect=[1:9 (2:10)+9];
lambdaTry=[.01:.01:.99 1:100];
scaleOne=10;
scaleShow=[2:10];
greyScale=.75;
pQuantile=.01:.01:1;
pQuantileSelect=[50 90]+1;
confIntSelect=[10 90]+1;
reliable=[10 95]+1;
pLambda=[51 ;1];%
%pLambda=[51 96;.5 .5];
lambdaBd=[.01 100];
targetP=.5;
relativeAreaScale=zeros(length(scale),length(pQuantile));
relativeAreaSur=zeros(length(pQuantile),1);
qqScale=relativeAreaScale;
qqSur=relativeAreaSur;
axisExtra=.01;
ciF=zeros(nt*scale(length(scale)),length(pQuantile));
ciF2=ciF;
summaryScale=zeros(nRoad,length(scale));
summarySur=zeros(2,2,nRoad,nSur);


resample=zeros(resampleSize,nt*scale(length(scale)));
h=zeros(nSur,4);
lambdaUniq=zeros(nRoad,nSur-1,length(lambdaTry));
%START
for i=1:nRoad
    for l=[3 2]
        fig1=figure;fig1.Position=round([110 110 figMax(2)/2*(figDef(1)/figDef(2)) figMax(2)/2]/figOverSize);hold;%scatter%2by1
        fig2=figure;fig2.Position=round([110 110 figMax(2)/2*(figDef(1)/figDef(2)) figMax(2)/2]/figOverSize);hold;%%2by1
        fig3=figure;fig3.Position=round([110 110 figMax(2)/2*(figDef(1)/figDef(2)) figMax(2)/2]/figOverSize);hold;%%2by1
        fig4=figure;fig4.Position=round([110 110 figMax(2)/2*(figDef(1)/figDef(2)) figMax(2)/2]/figOverSize);hold;%%2by1
        fig5=figure;fig5.Position=round([110 110 figMax(2)/2*(figDef(1)/figDef(2)) figMax(2)/2]/figOverSize);hold;%%qq%2by1
% %         
%         figure;hold;%scatter
%         figure;hold;
%         figure;hold;
%         figure;hold;
%         figure;hold;%qq
        for j=1:nSur
            %read data
            dir=[dir0 surName{j,1} slash];
            temp1=[dir roadName{i,1}]
            data=importfile([temp1 'SeedPC.csv']);
            temp=size(data);
            if temp(1)<nSeed
                data=[data;importfile([temp1 'SeedMac.csv'])];
            end
            data=data(1:nSeed,1:3);
            %set t
            if j==1
                temp=sort(data(:,l));
                t=(1:(nt*scale(length(scale))))/nt*sum(temp(1:tcut));
                %t=(1:(nt))/nt*sum(temp(1:tcut));
                %tMax=nt;
                tMax=length(t);
            else
                tMax=nt;
            end
            %scatter raw data
            figure(1);
            if j==1
                scatter(data(:,l),data(:,1),111,'MarkerEdgeColor',[1 1 1]*greyScale);  
            else
                scatter(data(:,l),data(:,1));  
            end
%             %verify
%             if j==1
%                 figure(1+l);
%                 temp=zeros(nSeed,1);
%                 temp(1)=data(1,k);
%                 for kk=1:nSeed
%                     if kk>1
%                         temp(kk)=temp(kk-1)+data(kk,k);
%                     end
%                 end
%                 plot(temp,data(:,1));
%                 plot([1 1]*t(length(t)),[min(data(:,1)) max(data(:,1))]);
%             end
            %boostrap
            for k=1:resampleSize
                temp3=initSol(i);
                kk=1;
                while kk<=tMax
                    temp=datasample(1:nSeed,1);
                    temp2=data(temp,l)+t(kk);
                    temp3=min(temp3,data(temp,1));
                    while kk<=tMax&& t(kk)<=temp2 
                        resample(k,kk)=temp3;
                        kk=kk+1;
                    end
                end
            end
            if j==1    
                for k=1:(nt*scale(length(scale)))
                    ciF(k,:)=quantile(resample(:,k),pQuantile);
                end
                for kk=1:3
                    figure(kk+1);
                    if kk<3
                        h(j,kk)=plot(t(1:nt),ciF(1:nt,50),'Color',[1 1 1]*greyScale,'LineWidth',3); 
                        fill([t(1:nt),fliplr(t(1:nt))],[ciF(1:nt,confIntSelect(1))',fliplr(ciF(1:nt,confIntSelect(2))')],1,'facecolor',[1 1 1]*greyScale,'edgecolor','none', 'facealpha', .3);
                    else
                        h(j,kk)=plot(t(1:nt),ciF(1:nt,50),'Color',[0 0 1],'LineWidth',3); 
                        fill([t(1:nt),fliplr(t(1:nt))],[ciF(1:nt,confIntSelect(1))',fliplr(ciF(1:nt,confIntSelect(2))')],1,'facecolor',[0 0 1],'edgecolor','none', 'facealpha', .3);
                    end
                    xlim([0 t(nt)]);
%                     for k=1:length(scaleShow)
%                         plot(t((1:nt)*scaleShow(k))/scaleShow(k),ciF((1:nt)*scaleShow(k),pQuantileSelect(kk)),':','Color',[1 1 1]*.1); 
%                     end
                end    
            else
                for k=1:nt
                    ciF2(k,:)=quantile(resample(:,k),pQuantile);
                end
                for kk=1:2
                    figure(kk+1);
                    h(j,kk)=plot(t(1:nt),ciF2(1:nt,pQuantileSelect(kk)),'Color',squeeze(colRand(j,:))); 
                end
                kk=kk+1;
                if j==3&&i==1
                    figure(kk+1);
                    h(2,kk)=plot(t(1:nt),ciF2(1:nt,pQuantileSelect(1)),'Color',[1 0 0],'LineWidth',3);
                    fill([t(1:nt),fliplr(t(1:nt))],[ciF2(1:nt,confIntSelect(1))',fliplr(ciF2(1:nt,confIntSelect(2))')],1,'facecolor',[1 0 0],'edgecolor','none', 'facealpha', .3);
                end 
            end
            %qq match
            figure(5);
            if j==1
                for k=1:length(scale)
                    for kk=1:length(pQuantile)
                        temp=round((1:nt)*scale(k));
                        if temp(1)==0
                            for kkk=1:length(temp)
                                if temp(kkk)>0
                                    break;
                                end
                                temp(kkk)=1;
                            end
                        end
                        relativeAreaScale(k,kk)=relativeArea(ciF(temp,kk),ciF(1:nt,50));
                    end
                end
                for k=1:length(scale)
                    qqScale(k,:)=qqMatch(relativeAreaScale(k,:),relativeAreaScale(scaleOne,:),pQuantile);
                    summaryScale(i,k)=qqMatch(targetP,qqScale(k,:),pQuantile);
                end
                h(j,4)=plot(qqScale(scaleOne,:),qqScale(scaleOne,:),'Color',[1 1 1]*greyScale,'LineWidth',3);
                plot(qqScale(scaleOne,:),qqScale(scaleOne,:),'Color',[1 1 1]*greyScale,'LineWidth',3);
%                 plot([0 1],[.1 .1],'--','Color',[1 1 1]*greyScale,'LineWidth',3);
%                 plot([0 1],[.5 .5],'--','Color',[1 1 1]*greyScale,'LineWidth',3);
%                 plot([.5 .5],[0 1],'--','Color',[1 1 1]*greyScale,'LineWidth',3);
%                 plot([.9 .9],[0 1],'--','Color',[1 1 1]*greyScale,'LineWidth',3);
%                 for k=scaleSelect
%                     plot(pQuantile,qqScale(k,:),':','Color',[1 1 1]*.1);
%                 end
            else
                for k=1:length(pQuantile)
                    relativeAreaSur(k)=relativeArea(ciF2(((1:nt)),k),ciF(1:nt,50));
                end
                qqSur=qqMatch(relativeAreaSur,relativeAreaScale(scaleOne,:),pQuantile);
                summarySur(l-1,1,i,j)=qqMatch(targetP,qqSur,pQuantile);
                h(j,4)=plot(pQuantile(reliable(1):reliable(2)),qqSur(reliable(1):reliable(2)),'Color',squeeze(colRand(j,:)));
                %summary table: match scale
                %TODO: lambda reliable t interval
                summarySur(l-1,2,i,j)=fmincon(@(z) lambdaLSQ(z,ciF(1:nt,:),ciF2(1:nt,:),pLambda),1,[1;-1],[lambdaBd(2);-lambdaBd(1)]);
                for k=1:length(lambdaTry)
                    lambdaUniq(i,j-1,k)=lambdaLSQ(lambdaTry(k),ciF(1:nt,:),ciF2(1:nt,:),pLambda);
                end
            end
        end
        %save fig
        if l==2
            temp='tf';
        else
            temp='tfs';
        end
        figure(1);
        legend(surName{:,surNameShow},'Location','Best');title(['Problem ' roadName{i,roadNameShow}]);xlabel('t');ylabel('f');
        %tightfig;
        saveas(figure(1),['fig\' temp '_scatter' '_R' num2str(i)],'pdf');close;pause(1) 
        for k=1:2
            figure(k+1);
            legend(h(:,k),surName{:,surNameShow},'Location','Best');title(['Problem ' roadName{i,roadNameShow}]);xlabel('\tau');ylabel('\Gamma');
            %tightfig;
            saveas(figure(k+1),['fig\' temp '_Band' num2str(pQuantileSelect(k)-1) '%' '_R' num2str(i)],'pdf');close; pause(1)
        end
        k=k+2;
        figure(k);
        if i==1
            legend(h(1:2,3),surName{[1 3],surNameShow},'Location','Best');title(['Problem ' roadName{i,roadNameShow}]);xlabel('\tau');ylabel('\Gamma');
            saveas(figure(k),['fig\' 'basic'],'pdf');
        end
        close;pause(1)
        k=k+1;
        figure(k);
        %tightfig;
        legend(h(:,4),surName{:,surNameShow},'Location','Best');title(['Problem ' roadName{i,roadNameShow}]);axis([-axisExtra,inf,-axisExtra,inf]);xlabel('Alternative CDF');ylabel('Baseline CDF');
        saveas(figure(k),['fig\' temp '_PP' '_R' num2str(i)],'pdf');close;pause(1) 
    end
end
% summary;
figure;%tightfig;
for i=1:9
    subplot(3,3,i);hold;
    for j=1:(nSur-1)
        temp=max(lambdaUniq(i,j,:));
        lambdaUniq(i,j,:)=lambdaUniq(i,j,:)/temp;
        temp=lambdaTry;
        for k=1:length(temp)
            temp(k)=lambdaUniq(i,j,k);
        end
        loglog(log(lambdaTry),temp);
        if i>6
            xlabel('ln(\lambda)');
        end
        title(['Problem ' roadName{i,roadNameShow}]);
    end
end
saveas(figure(1),['fig\' 'lambda'],'pdf');close;pause(1);



























