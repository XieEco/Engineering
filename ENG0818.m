%Codes of 'Uncertain cross-sector climate actions could undermine air pollution reduction co-benefits in China's power and passenger car sectors'
%Copyright (c) 2025 Hongyi Xie(FDU), Bin Chen(FDU)and Yutao Wang(FDU)
%All rights reserved. Contect email:xiehyeco@163.com
clear
clc
set(0,'defaultfigurecolor','w') 
YZ=0;
for P=1:9 %car
for C=1:9 %plant
for GRID=1:6%1-NORTH 2-EAST 3-SOUTH 4-CENTRAL 5-NORTHWEST 6-NORTHEAST
for YEAR=2025:5:2050
    clearvars -except P C GRID YEAR YZ YZZ
EE=csvread('input-ELE5.csv');
aa=(GRID-1).*9+P;
if C<3.1
    if YEAR==2025
        bb=1;
    elseif YEAR==2030
        bb=2;
    elseif YEAR==2035
        bb=3;
    elseif YEAR==2040
        bb=4;
    elseif YEAR==2045
        bb=5; 
    else
        bb=6;        
    end
elseif C<6.1
    if YEAR==2025
        bb=7;
    elseif YEAR==2030
        bb=8;
    elseif YEAR==2035
        bb=9;
    elseif YEAR==2040
        bb=10;
    elseif YEAR==2045
        bb=11; 
    else
        bb=12;        
    end
else
    if YEAR==2025
        bb=13;
    elseif YEAR==2030
        bb=14;
    elseif YEAR==2035
        bb=15;
    elseif YEAR==2040
        bb=16;
    elseif YEAR==2045
        bb=17; 
    else
        bb=18;        
    end
end
ESJ(1,1)=EE(aa,bb);
kk=['input-V1-P',num2str(C),'-G',num2str(GRID),'-',num2str(YEAR),'.csv'];
DC=csvread(kk);
[a,b]=size(DC);
YZZ((C-1).*6+GRID,(YEAR-2020)./5)=a;
YZ=YZ+a;
for i=1:a
    DLFPXS(i,:)=DC(i,1)./sum(DC(:,1));
end
FDL(:,1)=DLFPXS(:,1).*ESJ(1,1).*(10^11);
if C==1 || C==2 || C==4
MHDJ=1;%1-LOW, 2-MID, 3-HIGH
elseif C==3 || C==5 || C==6 || C==7 
MHDJ=2;
else
MHDJ=3;
end
for i=1:a
    if MHDJ==1
    C1=352;
    C2=308;
    C3=304;
    C4=290;
    C5=307;
    elseif MHDJ==2
    if YEAR==2035
    C1=295;
    C2=295;
    C3=295;
    C4=281;
    C5=290;
    elseif YEAR==2050
    C1=295;
    C2=295;
    C3=295;
    C4=281;
    C5=290;
    elseif YEAR==2025
    C1=323.5;
    C2=306.5;
    C3=299;
    C4=283;
    C5=298.5;
    elseif YEAR==2030
    C1=295;
    C2=295;
    C3=295;
    C4=281;
    C5=290;    
    elseif YEAR==2040
    C1=295;
    C2=295;
    C3=295;
    C4=281;
    C5=290; 
    elseif YEAR==2045
    C1=295;
    C2=295;
    C3=295;
    C4=281;
    C5=290;     
    end        
    elseif MHDJ==3
    if YEAR==2035
    C1=295;
    C2=295;
    C3=289;
    C4=274;
    C5=286;
    elseif YEAR==2050
    C1=295;
    C2=295;
    C3=289;
    C4=274;
    C5=286;
    elseif YEAR==2025
    C1=323.5;
    C2=307;
    C3=296.5;
    C4=282;
    C5=296.5;
    elseif YEAR==2030
    C1=295;
    C2=295;
    C3=289;
    C4=274.5;
    C5=286;       
    elseif YEAR==2040
    C1=295;
    C2=295;
    C3=289;
    C4=274.5;
    C5=286;       
    else
    C1=295;
    C2=295;
    C3=289;
    C4=274.5;
    C5=286;          
    end        
    else
    end
    if DC(i,6)==1
    MH=C1;    
    elseif DC(i,6)==2
    MH=C2;        
    elseif DC(i,6)==3
    MH=C3;        
    elseif DC(i,6)==4
    MH=C4;    
    elseif DC(i,6)==5
    MH=C5;    
    else
    end
MHL(i,1)=FDL(i,1).*MH;
end
% CO2
CO2(:,1)=MHL(:,1)./(10^7).*2.7725;
%CCUS
CCUS=[0	0	0	0	0	0
0.007136178	0	0	0	0	0
0.119884757	0.179849839	0	0	0.042317609	0.106391857
0.366745045	0.232761985	0	0.162217502	0.218633413	0.106391857
0.373790412	0.204542678	0.014121005	0.236258182	0.278590927	0.111991827
0.243326252	0.119922595	0.01058697	0.112816687	0.186895206	0.052897011
]*10^11;
if YEAR==2025
    jjj=1;
elseif YEAR==2030
    jjj=2;
elseif YEAR==2035
    jjj=3;
elseif YEAR==2040
    jjj=4;
elseif YEAR==2045
    jjj=5;
else
    jjj=6;
end
for i=1:a
    if DC(i,7)==3
if C>6.9
    if sum(CO2(1:i,1))>=CCUS(jjj,GRID)
        CO22(i,1)=CO2(i,1);
    else
        CO22(i,1)=0;
    end
else
    CO22(i,1)=CO2(i,1);
end
    else
    CO22(i,1)=CO2(i,1);
    end
end
%NOx
for i=1:a
if DC(i,1)>299999    
NOXWCL(i,1)=MHL(i,1)/1000*7.21/(10^7);
elseif DC(i,1)>=100000
NOXWCL(i,1)=MHL(i,1)/1000*8.19/(10^7);
else
NOXWCL(i,1)=MHL(i,1)/1000*8.96/(10^7); 
end
end
for i=1:a
if DC(i,3)==1
    NOX(i,1)=NOXWCL(i,1).*0.125;
elseif DC(i,3)==2
    NOX(i,1)=NOXWCL(i,1).*0.22;
else
    NOX(i,1)=NOXWCL(i,1);
end
end
% CO
CO(:,1)=MHL(:,1)./1000.*2./(10^7);
% VOC
VOC(:,1)=MHL(:,1)./1000.*0.04./(10^7);
% SO2
EFSO2(:,1)=2*(1-0.15)*DC(:,9);
SO2WCL(:,1)=EFSO2(:,1)./1000./(10^7).*MHL(:,1);
for i=1:a
if DC(i,4)==2
    if DC(i,5)==1
       SO2(i,1)=SO2WCL(i,1).*0.8.*0.0286; 
    elseif DC(i,5)==2
       SO2(i,1)=SO2WCL(i,1).*0.8.*0.2;         
    elseif DC(i,5)==3
       SO2(i,1)=SO2WCL(i,1).*0.8.*0.4;          
    else
       SO2(i,1)=SO2WCL(i,1).*0.8;          
    end    
else
    if DC(i,5)==1
       SO2(i,1)=SO2WCL(i,1).*0.0286; 
    elseif DC(i,5)==2
       SO2(i,1)=SO2WCL(i,1).*0.2;         
    elseif DC(i,5)==3
       SO2(i,1)=SO2WCL(i,1).*0.4;          
    else
       SO2(i,1)=SO2WCL(i,1);          
    end       
end    
end
% PM
for i=1:a
if DC(i,10)==1
    EFPM25(i,1)=DC(i,8).*(1-0.25).*0.06;
    EFPM10(i,1)=DC(i,8).*(1-0.25).*0.23;
else    
    EFPM25(i,1)=DC(i,8).*(1-0.44).*0.07;
    EFPM10(i,1)=DC(i,8).*(1-0.44).*0.29;    
end    
end
PM25WCL=EFPM25(:,1).*MHL(:,1)./1000./(10^7);
PM10WCL=EFPM10(:,1).*MHL(:,1)./1000./(10^7);
for i=1:a
    if DC(i,5)==1
        if DC(i,4)==1
            PM25(i,1)=0.43.*PM25WCL(i,1);
            PM10(i,1)=PM10WCL(i,1);
        elseif DC(i,4)==2
            PM25(i,1)=0.43.*PM25WCL(i,1).*0.5;
            PM10(i,1)=PM10WCL(i,1).*0.1;            
        else
            PM25(i,1)=0.43.*PM25WCL(i,1).*0.04;
            PM10(i,1)=PM10WCL(i,1).*0.01;            
        end
    else
            if DC(i,4)==1
            PM25(i,1)=PM25WCL(i,1);
            PM10(i,1)=PM10WCL(i,1);
        elseif DC(i,4)==2
            PM25(i,1)=PM25WCL(i,1).*0.5;
            PM10(i,1)=PM10WCL(i,1).*0.1;            
        else
            PM25(i,1)=PM25WCL(i,1).*0.04;
            PM10(i,1)=PM10WCL(i,1).*0.01;            
        end
    end
end

JG=zeros(a,21);
kk=['GRID-',num2str(GRID),'.csv'];
TT=csvread(kk);
JG(1:a,1:3)=TT(1:a,1:3);
JG(:,4)=DLFPXS(:,1);
JG(:,5)=FDL(:,1);
JG(:,6)=MHL(:,1);
JG(:,7)=CO22(:,1);
JG(:,8)=NOXWCL(:,1);
JG(:,9)=NOX(:,1);
JG(:,10)=CO(:,1);
JG(:,11)=VOC(:,1);
JG(:,12)=EFSO2(:,1);
JG(:,13)=SO2WCL(:,1);
JG(:,14)=SO2(:,1);
JG(:,15)=EFPM25(:,1);
JG(:,16)=EFPM10(:,1);
JG(:,17)=PM25WCL(:,1);
JG(:,18)=PM25(:,1);
JG(:,19)=PM10WCL(:,1);
JG(:,20)=PM10(:,1);
JG(:,21)=CO22(:,1)-CO2(:,1);
kkkk=['V',num2str(P),'-P',num2str(C),'-G',num2str(GRID),'-',num2str(YEAR),'.csv'];
csvwrite(kkkk,JG);
save(strcat('V',num2str(P),'-P',num2str(C),'-G',num2str(GRID),'-',num2str(YEAR)))
end
end
end
end
JG1=zeros(81,48);
JG2=zeros(81,48);
JG3=zeros(81,48);
JG4=zeros(81,48);
JG5=zeros(81,48);
JG6=zeros(81,48);
JG7=zeros(81,48);
JG8=zeros(81,48);
JG9=zeros(81,48);
JG10=zeros(81,48);
JG11=zeros(81,48);
JG12=zeros(81,48);
JG13=zeros(81,48);
JG14=zeros(81,48);
JG15=zeros(81,48);
JG16=zeros(81,48);
JG17=zeros(81,48);
JG18=zeros(81,48);
JG19=zeros(81,48);
JG20=zeros(81,48);
JG21=zeros(81,48);
JG22=zeros(81,48);
JG23=zeros(81,48);
JG24=zeros(81,48);
JG25=zeros(81,48);
JG26=zeros(81,48);
JG27=zeros(81,48);
JG29=zeros(81,48);
JG30=zeros(81,48);
JG31=zeros(81,48);
for YEAR=2025:5:2050
for V=1:9 %car
for P=1:9 %plant
for GRID=1:6% 1-NORTH 2-EAST 3-SOUTH 4-CENTRAL 5-NORTHWEST 6-NORTHEAST
clearvars -except V P GRID YEAR JG1 JG2 JG3 JG4 JG5 JG6 JG7 JG8 JG9 JG10 JG11 JG12 JG13 JG14 JG15 JG16 JG17 JG18 JG19 JG20 JG21 JG22 JG23 JG24 JG25 JG26 JG27 JG29 JG30 JG31
kkkk=['V',num2str(V),'-P',num2str(P),'-G',num2str(GRID),'-',num2str(YEAR),'.csv'];
PL=csvread(kkkk);%1-Province 2-Lon 3-Lat 4-DLXS 5-Power 6-Coal 7-CO2 8-NOx0 9-NOx 10-CO 11-VOC 12-EFSO2 13-SO20 14-SO2 15-EFPM25 16-EFPM10 17-PM250 18-PM25 19-PM100 20-PM10 21-CCUS'
[a,b]=size(PL);
for i=1:a
if PL(i,1)==1
    JG1((V-1).*9+P,(YEAR-2020)./5)=JG1((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG1((V-1).*9+P,(YEAR-2020)./5+6)=JG1((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG1((V-1).*9+P,(YEAR-2020)./5+6*2)=JG1((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG1((V-1).*9+P,(YEAR-2020)./5+6*3)=JG1((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG1((V-1).*9+P,(YEAR-2020)./5+6*4)=JG1((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG1((V-1).*9+P,(YEAR-2020)./5+6*5)=JG1((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG1((V-1).*9+P,(YEAR-2020)./5+6*6)=JG1((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG1((V-1).*9+P,(YEAR-2020)./5+6*7)=JG1((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus    
elseif PL(i,1)==2
    JG2((V-1).*9+P,(YEAR-2020)./5)=JG2((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG2((V-1).*9+P,(YEAR-2020)./5+6)=JG2((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG2((V-1).*9+P,(YEAR-2020)./5+6*2)=JG2((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG2((V-1).*9+P,(YEAR-2020)./5+6*3)=JG2((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG2((V-1).*9+P,(YEAR-2020)./5+6*4)=JG2((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG2((V-1).*9+P,(YEAR-2020)./5+6*5)=JG2((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG2((V-1).*9+P,(YEAR-2020)./5+6*6)=JG2((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG2((V-1).*9+P,(YEAR-2020)./5+6*7)=JG2((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus
elseif PL(i,1)==3
    JG3((V-1).*9+P,(YEAR-2020)./5)=JG3((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG3((V-1).*9+P,(YEAR-2020)./5+6)=JG3((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG3((V-1).*9+P,(YEAR-2020)./5+6*2)=JG3((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG3((V-1).*9+P,(YEAR-2020)./5+6*3)=JG3((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG3((V-1).*9+P,(YEAR-2020)./5+6*4)=JG3((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG3((V-1).*9+P,(YEAR-2020)./5+6*5)=JG3((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG3((V-1).*9+P,(YEAR-2020)./5+6*6)=JG3((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG3((V-1).*9+P,(YEAR-2020)./5+6*7)=JG3((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus       
elseif PL(i,1)==4
    JG4((V-1).*9+P,(YEAR-2020)./5)=JG4((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG4((V-1).*9+P,(YEAR-2020)./5+6)=JG4((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG4((V-1).*9+P,(YEAR-2020)./5+6*2)=JG4((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG4((V-1).*9+P,(YEAR-2020)./5+6*3)=JG4((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG4((V-1).*9+P,(YEAR-2020)./5+6*4)=JG4((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG4((V-1).*9+P,(YEAR-2020)./5+6*5)=JG4((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG4((V-1).*9+P,(YEAR-2020)./5+6*6)=JG4((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG4((V-1).*9+P,(YEAR-2020)./5+6*7)=JG4((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus      
elseif PL(i,1)==5
    JG5((V-1).*9+P,(YEAR-2020)./5)=JG5((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG5((V-1).*9+P,(YEAR-2020)./5+6)=JG5((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG5((V-1).*9+P,(YEAR-2020)./5+6*2)=JG5((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG5((V-1).*9+P,(YEAR-2020)./5+6*3)=JG5((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG5((V-1).*9+P,(YEAR-2020)./5+6*4)=JG5((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG5((V-1).*9+P,(YEAR-2020)./5+6*5)=JG5((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG5((V-1).*9+P,(YEAR-2020)./5+6*6)=JG5((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG5((V-1).*9+P,(YEAR-2020)./5+6*7)=JG5((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus      
elseif PL(i,1)==6
    JG6((V-1).*9+P,(YEAR-2020)./5)=JG6((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG6((V-1).*9+P,(YEAR-2020)./5+6)=JG6((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG6((V-1).*9+P,(YEAR-2020)./5+6*2)=JG6((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG6((V-1).*9+P,(YEAR-2020)./5+6*3)=JG6((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG6((V-1).*9+P,(YEAR-2020)./5+6*4)=JG6((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG6((V-1).*9+P,(YEAR-2020)./5+6*5)=JG6((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG6((V-1).*9+P,(YEAR-2020)./5+6*6)=JG6((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG6((V-1).*9+P,(YEAR-2020)./5+6*7)=JG6((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus
elseif PL(i,1)==7
    JG7((V-1).*9+P,(YEAR-2020)./5)=JG7((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG7((V-1).*9+P,(YEAR-2020)./5+6)=JG7((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG7((V-1).*9+P,(YEAR-2020)./5+6*2)=JG7((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG7((V-1).*9+P,(YEAR-2020)./5+6*3)=JG7((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG7((V-1).*9+P,(YEAR-2020)./5+6*4)=JG7((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG7((V-1).*9+P,(YEAR-2020)./5+6*5)=JG7((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG7((V-1).*9+P,(YEAR-2020)./5+6*6)=JG7((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG7((V-1).*9+P,(YEAR-2020)./5+6*7)=JG7((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus
elseif PL(i,1)==8
    JG8((V-1).*9+P,(YEAR-2020)./5)=JG8((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG8((V-1).*9+P,(YEAR-2020)./5+6)=JG8((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG8((V-1).*9+P,(YEAR-2020)./5+6*2)=JG8((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG8((V-1).*9+P,(YEAR-2020)./5+6*3)=JG8((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG8((V-1).*9+P,(YEAR-2020)./5+6*4)=JG8((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG8((V-1).*9+P,(YEAR-2020)./5+6*5)=JG8((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG8((V-1).*9+P,(YEAR-2020)./5+6*6)=JG8((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG8((V-1).*9+P,(YEAR-2020)./5+6*7)=JG8((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus
elseif PL(i,1)==9
    JG9((V-1).*9+P,(YEAR-2020)./5)=JG9((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG9((V-1).*9+P,(YEAR-2020)./5+6)=JG9((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG9((V-1).*9+P,(YEAR-2020)./5+6*2)=JG9((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG9((V-1).*9+P,(YEAR-2020)./5+6*3)=JG9((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG9((V-1).*9+P,(YEAR-2020)./5+6*4)=JG9((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG9((V-1).*9+P,(YEAR-2020)./5+6*5)=JG9((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG9((V-1).*9+P,(YEAR-2020)./5+6*6)=JG9((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG9((V-1).*9+P,(YEAR-2020)./5+6*7)=JG9((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus
elseif PL(i,1)==10
    JG10((V-1).*9+P,(YEAR-2020)./5)=JG10((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG10((V-1).*9+P,(YEAR-2020)./5+6)=JG10((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG10((V-1).*9+P,(YEAR-2020)./5+6*2)=JG10((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG10((V-1).*9+P,(YEAR-2020)./5+6*3)=JG10((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG10((V-1).*9+P,(YEAR-2020)./5+6*4)=JG10((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG10((V-1).*9+P,(YEAR-2020)./5+6*5)=JG10((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG10((V-1).*9+P,(YEAR-2020)./5+6*6)=JG10((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG10((V-1).*9+P,(YEAR-2020)./5+6*7)=JG10((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus
elseif PL(i,1)==11
    JG11((V-1).*9+P,(YEAR-2020)./5)=JG11((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG11((V-1).*9+P,(YEAR-2020)./5+6)=JG11((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG11((V-1).*9+P,(YEAR-2020)./5+6*2)=JG11((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG11((V-1).*9+P,(YEAR-2020)./5+6*3)=JG11((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG11((V-1).*9+P,(YEAR-2020)./5+6*4)=JG11((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG11((V-1).*9+P,(YEAR-2020)./5+6*5)=JG11((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG11((V-1).*9+P,(YEAR-2020)./5+6*6)=JG11((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG11((V-1).*9+P,(YEAR-2020)./5+6*7)=JG11((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus
elseif PL(i,1)==12
    JG12((V-1).*9+P,(YEAR-2020)./5)=JG12((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG12((V-1).*9+P,(YEAR-2020)./5+6)=JG12((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG12((V-1).*9+P,(YEAR-2020)./5+6*2)=JG12((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG12((V-1).*9+P,(YEAR-2020)./5+6*3)=JG12((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG12((V-1).*9+P,(YEAR-2020)./5+6*4)=JG12((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG12((V-1).*9+P,(YEAR-2020)./5+6*5)=JG12((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG12((V-1).*9+P,(YEAR-2020)./5+6*6)=JG12((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG12((V-1).*9+P,(YEAR-2020)./5+6*7)=JG12((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus  
elseif PL(i,1)==13
    JG13((V-1).*9+P,(YEAR-2020)./5)=JG13((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG13((V-1).*9+P,(YEAR-2020)./5+6)=JG13((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG13((V-1).*9+P,(YEAR-2020)./5+6*2)=JG13((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG13((V-1).*9+P,(YEAR-2020)./5+6*3)=JG13((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG13((V-1).*9+P,(YEAR-2020)./5+6*4)=JG13((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG13((V-1).*9+P,(YEAR-2020)./5+6*5)=JG13((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG13((V-1).*9+P,(YEAR-2020)./5+6*6)=JG13((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG13((V-1).*9+P,(YEAR-2020)./5+6*7)=JG13((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus
elseif PL(i,1)==14
    JG14((V-1).*9+P,(YEAR-2020)./5)=JG14((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG14((V-1).*9+P,(YEAR-2020)./5+6)=JG14((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG14((V-1).*9+P,(YEAR-2020)./5+6*2)=JG14((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG14((V-1).*9+P,(YEAR-2020)./5+6*3)=JG14((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG14((V-1).*9+P,(YEAR-2020)./5+6*4)=JG14((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG14((V-1).*9+P,(YEAR-2020)./5+6*5)=JG14((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG14((V-1).*9+P,(YEAR-2020)./5+6*6)=JG14((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG14((V-1).*9+P,(YEAR-2020)./5+6*7)=JG14((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus
elseif PL(i,1)==15
    JG15((V-1).*9+P,(YEAR-2020)./5)=JG15((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG15((V-1).*9+P,(YEAR-2020)./5+6)=JG15((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG15((V-1).*9+P,(YEAR-2020)./5+6*2)=JG15((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG15((V-1).*9+P,(YEAR-2020)./5+6*3)=JG15((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG15((V-1).*9+P,(YEAR-2020)./5+6*4)=JG15((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG15((V-1).*9+P,(YEAR-2020)./5+6*5)=JG15((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG15((V-1).*9+P,(YEAR-2020)./5+6*6)=JG15((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG15((V-1).*9+P,(YEAR-2020)./5+6*7)=JG15((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus
elseif PL(i,1)==16
    JG16((V-1).*9+P,(YEAR-2020)./5)=JG16((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG16((V-1).*9+P,(YEAR-2020)./5+6)=JG16((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG16((V-1).*9+P,(YEAR-2020)./5+6*2)=JG16((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG16((V-1).*9+P,(YEAR-2020)./5+6*3)=JG16((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG16((V-1).*9+P,(YEAR-2020)./5+6*4)=JG16((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG16((V-1).*9+P,(YEAR-2020)./5+6*5)=JG16((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG16((V-1).*9+P,(YEAR-2020)./5+6*6)=JG16((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG16((V-1).*9+P,(YEAR-2020)./5+6*7)=JG16((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus 
elseif PL(i,1)==17
    JG17((V-1).*9+P,(YEAR-2020)./5)=JG17((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG17((V-1).*9+P,(YEAR-2020)./5+6)=JG17((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG17((V-1).*9+P,(YEAR-2020)./5+6*2)=JG17((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG17((V-1).*9+P,(YEAR-2020)./5+6*3)=JG17((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG17((V-1).*9+P,(YEAR-2020)./5+6*4)=JG17((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG17((V-1).*9+P,(YEAR-2020)./5+6*5)=JG17((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG17((V-1).*9+P,(YEAR-2020)./5+6*6)=JG17((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG17((V-1).*9+P,(YEAR-2020)./5+6*7)=JG17((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus
elseif PL(i,1)==18
    JG18((V-1).*9+P,(YEAR-2020)./5)=JG18((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG18((V-1).*9+P,(YEAR-2020)./5+6)=JG18((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG18((V-1).*9+P,(YEAR-2020)./5+6*2)=JG18((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG18((V-1).*9+P,(YEAR-2020)./5+6*3)=JG18((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG18((V-1).*9+P,(YEAR-2020)./5+6*4)=JG18((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG18((V-1).*9+P,(YEAR-2020)./5+6*5)=JG18((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG18((V-1).*9+P,(YEAR-2020)./5+6*6)=JG18((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG18((V-1).*9+P,(YEAR-2020)./5+6*7)=JG18((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus
elseif PL(i,1)==19
    JG19((V-1).*9+P,(YEAR-2020)./5)=JG19((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG19((V-1).*9+P,(YEAR-2020)./5+6)=JG19((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG19((V-1).*9+P,(YEAR-2020)./5+6*2)=JG19((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG19((V-1).*9+P,(YEAR-2020)./5+6*3)=JG19((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG19((V-1).*9+P,(YEAR-2020)./5+6*4)=JG19((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG19((V-1).*9+P,(YEAR-2020)./5+6*5)=JG19((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG19((V-1).*9+P,(YEAR-2020)./5+6*6)=JG19((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG19((V-1).*9+P,(YEAR-2020)./5+6*7)=JG19((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus
elseif PL(i,1)==20
    JG20((V-1).*9+P,(YEAR-2020)./5)=JG20((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG20((V-1).*9+P,(YEAR-2020)./5+6)=JG20((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG20((V-1).*9+P,(YEAR-2020)./5+6*2)=JG20((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG20((V-1).*9+P,(YEAR-2020)./5+6*3)=JG20((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG20((V-1).*9+P,(YEAR-2020)./5+6*4)=JG20((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG20((V-1).*9+P,(YEAR-2020)./5+6*5)=JG20((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG20((V-1).*9+P,(YEAR-2020)./5+6*6)=JG20((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG20((V-1).*9+P,(YEAR-2020)./5+6*7)=JG20((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus
elseif PL(i,1)==21
    JG21((V-1).*9+P,(YEAR-2020)./5)=JG21((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG21((V-1).*9+P,(YEAR-2020)./5+6)=JG21((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG21((V-1).*9+P,(YEAR-2020)./5+6*2)=JG21((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG21((V-1).*9+P,(YEAR-2020)./5+6*3)=JG21((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG21((V-1).*9+P,(YEAR-2020)./5+6*4)=JG21((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG21((V-1).*9+P,(YEAR-2020)./5+6*5)=JG21((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG21((V-1).*9+P,(YEAR-2020)./5+6*6)=JG21((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG21((V-1).*9+P,(YEAR-2020)./5+6*7)=JG21((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus
elseif PL(i,1)==22
    JG22((V-1).*9+P,(YEAR-2020)./5)=JG22((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG22((V-1).*9+P,(YEAR-2020)./5+6)=JG22((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG22((V-1).*9+P,(YEAR-2020)./5+6*2)=JG22((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG22((V-1).*9+P,(YEAR-2020)./5+6*3)=JG22((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG22((V-1).*9+P,(YEAR-2020)./5+6*4)=JG22((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG22((V-1).*9+P,(YEAR-2020)./5+6*5)=JG22((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG22((V-1).*9+P,(YEAR-2020)./5+6*6)=JG22((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG22((V-1).*9+P,(YEAR-2020)./5+6*7)=JG22((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus 
elseif PL(i,1)==23
    JG23((V-1).*9+P,(YEAR-2020)./5)=JG23((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG23((V-1).*9+P,(YEAR-2020)./5+6)=JG23((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG23((V-1).*9+P,(YEAR-2020)./5+6*2)=JG23((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG23((V-1).*9+P,(YEAR-2020)./5+6*3)=JG23((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG23((V-1).*9+P,(YEAR-2020)./5+6*4)=JG23((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG23((V-1).*9+P,(YEAR-2020)./5+6*5)=JG23((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG23((V-1).*9+P,(YEAR-2020)./5+6*6)=JG23((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG23((V-1).*9+P,(YEAR-2020)./5+6*7)=JG23((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus
elseif PL(i,1)==24
    JG24((V-1).*9+P,(YEAR-2020)./5)=JG24((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG24((V-1).*9+P,(YEAR-2020)./5+6)=JG24((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG24((V-1).*9+P,(YEAR-2020)./5+6*2)=JG24((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG24((V-1).*9+P,(YEAR-2020)./5+6*3)=JG24((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG24((V-1).*9+P,(YEAR-2020)./5+6*4)=JG24((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG24((V-1).*9+P,(YEAR-2020)./5+6*5)=JG24((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG24((V-1).*9+P,(YEAR-2020)./5+6*6)=JG24((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG24((V-1).*9+P,(YEAR-2020)./5+6*7)=JG24((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus
elseif PL(i,1)==25
    JG25((V-1).*9+P,(YEAR-2020)./5)=JG25((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG25((V-1).*9+P,(YEAR-2020)./5+6)=JG25((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG25((V-1).*9+P,(YEAR-2020)./5+6*2)=JG25((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG25((V-1).*9+P,(YEAR-2020)./5+6*3)=JG25((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG25((V-1).*9+P,(YEAR-2020)./5+6*4)=JG25((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG25((V-1).*9+P,(YEAR-2020)./5+6*5)=JG25((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG25((V-1).*9+P,(YEAR-2020)./5+6*6)=JG25((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG25((V-1).*9+P,(YEAR-2020)./5+6*7)=JG25((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus
elseif PL(i,1)==26
    JG26((V-1).*9+P,(YEAR-2020)./5)=JG26((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG26((V-1).*9+P,(YEAR-2020)./5+6)=JG26((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG26((V-1).*9+P,(YEAR-2020)./5+6*2)=JG26((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG26((V-1).*9+P,(YEAR-2020)./5+6*3)=JG26((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG26((V-1).*9+P,(YEAR-2020)./5+6*4)=JG26((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG26((V-1).*9+P,(YEAR-2020)./5+6*5)=JG26((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG26((V-1).*9+P,(YEAR-2020)./5+6*6)=JG26((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG26((V-1).*9+P,(YEAR-2020)./5+6*7)=JG26((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus
elseif PL(i,1)==27
    JG27((V-1).*9+P,(YEAR-2020)./5)=JG27((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG27((V-1).*9+P,(YEAR-2020)./5+6)=JG27((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG27((V-1).*9+P,(YEAR-2020)./5+6*2)=JG27((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG27((V-1).*9+P,(YEAR-2020)./5+6*3)=JG27((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG27((V-1).*9+P,(YEAR-2020)./5+6*4)=JG27((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG27((V-1).*9+P,(YEAR-2020)./5+6*5)=JG27((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG27((V-1).*9+P,(YEAR-2020)./5+6*6)=JG27((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG27((V-1).*9+P,(YEAR-2020)./5+6*7)=JG27((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus
elseif PL(i,1)==29
    JG29((V-1).*9+P,(YEAR-2020)./5)=JG29((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG29((V-1).*9+P,(YEAR-2020)./5+6)=JG29((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG29((V-1).*9+P,(YEAR-2020)./5+6*2)=JG29((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG29((V-1).*9+P,(YEAR-2020)./5+6*3)=JG29((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG29((V-1).*9+P,(YEAR-2020)./5+6*4)=JG29((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG29((V-1).*9+P,(YEAR-2020)./5+6*5)=JG29((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG29((V-1).*9+P,(YEAR-2020)./5+6*6)=JG29((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG29((V-1).*9+P,(YEAR-2020)./5+6*7)=JG29((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus      
elseif PL(i,1)==30
    JG30((V-1).*9+P,(YEAR-2020)./5)=JG30((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG30((V-1).*9+P,(YEAR-2020)./5+6)=JG30((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG30((V-1).*9+P,(YEAR-2020)./5+6*2)=JG30((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG30((V-1).*9+P,(YEAR-2020)./5+6*3)=JG30((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG30((V-1).*9+P,(YEAR-2020)./5+6*4)=JG30((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG30((V-1).*9+P,(YEAR-2020)./5+6*5)=JG30((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG30((V-1).*9+P,(YEAR-2020)./5+6*6)=JG30((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG30((V-1).*9+P,(YEAR-2020)./5+6*7)=JG30((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus  
else
    JG31((V-1).*9+P,(YEAR-2020)./5)=JG31((V-1).*9+P,(YEAR-2020)./5)+PL(i,7);%CO2
    JG31((V-1).*9+P,(YEAR-2020)./5+6)=JG31((V-1).*9+P,(YEAR-2020)./5+6)+PL(i,9);%NOx
    JG31((V-1).*9+P,(YEAR-2020)./5+6*2)=JG31((V-1).*9+P,(YEAR-2020)./5+6*2)+PL(i,10);%CO
    JG31((V-1).*9+P,(YEAR-2020)./5+6*3)=JG31((V-1).*9+P,(YEAR-2020)./5+6*3)+PL(i,11);%VOC
    JG31((V-1).*9+P,(YEAR-2020)./5+6*4)=JG31((V-1).*9+P,(YEAR-2020)./5+6*4)+PL(i,14);%SO2
    JG31((V-1).*9+P,(YEAR-2020)./5+6*5)=JG31((V-1).*9+P,(YEAR-2020)./5+6*5)+PL(i,18);%pm2.5
    JG31((V-1).*9+P,(YEAR-2020)./5+6*6)=JG31((V-1).*9+P,(YEAR-2020)./5+6*6)+PL(i,20);%PM10
    JG31((V-1).*9+P,(YEAR-2020)./5+6*7)=JG31((V-1).*9+P,(YEAR-2020)./5+6*7)+PL(i,21);%Ccus   
end
end
end
end
end
end
JG_CHINA=JG1+JG2+JG3+JG4+JG5+JG6+JG7+JG8+JG9+JG10+JG11+JG12+JG13+JG14+JG15+JG16+JG17+JG18+JG19+JG20+JG21+JG22+JG23+JG24+JG25+JG26+JG27+JG29+JG30+JG31;
CAR2=csvread('input-CarEmission.csv');
for i=1:9
CO2_CAR(i,1:7)=CAR2(1,1:7)./10^9;
CO2_CAR(i+9,1:7)=CAR2(2,1:7)./10^9;
CO2_CAR(i+9*2,1:7)=CAR2(3,1:7)./10^9;
CO2_CAR(i+9*3,1:7)=CAR2(4,1:7)./10^9;
CO2_CAR(i+9*4,1:7)=CAR2(5,1:7)./10^9;
CO2_CAR(i+9*5,1:7)=CAR2(6,1:7)./10^9;
CO2_CAR(i+9*6,1:7)=CAR2(7,1:7)./10^9;
CO2_CAR(i+9*7,1:7)=CAR2(8,1:7)./10^9;
CO2_CAR(i+9*8,1:7)=CAR2(9,1:7)./10^9;
NOX_CAR(i,1:7)=CAR2(10,1:7)./10^4;
NOX_CAR(i+9,1:7)=CAR2(11,1:7)./10^4;
NOX_CAR(i+9*2,1:7)=CAR2(12,1:7)./10^4;
NOX_CAR(i+9*3,1:7)=CAR2(13,1:7)./10^4;
NOX_CAR(i+9*4,1:7)=CAR2(14,1:7)./10^4;
NOX_CAR(i+9*5,1:7)=CAR2(15,1:7)./10^4;
NOX_CAR(i+9*6,1:7)=CAR2(16,1:7)./10^4;
NOX_CAR(i+9*7,1:7)=CAR2(17,1:7)./10^4;
NOX_CAR(i+9*8,1:7)=CAR2(18,1:7)./10^4;
CO_CAR(i,1:7)=CAR2(19,1:7)./10^4;
CO_CAR(i+9,1:7)=CAR2(20,1:7)./10^4;
CO_CAR(i+9*2,1:7)=CAR2(21,1:7)./10^4;
CO_CAR(i+9*3,1:7)=CAR2(22,1:7)./10^4;
CO_CAR(i+9*4,1:7)=CAR2(23,1:7)./10^4;
CO_CAR(i+9*5,1:7)=CAR2(24,1:7)./10^4;
CO_CAR(i+9*6,1:7)=CAR2(25,1:7)./10^4;
CO_CAR(i+9*7,1:7)=CAR2(26,1:7)./10^4;
CO_CAR(i+9*8,1:7)=CAR2(27,1:7)./10^4;
VOC_CAR(i,1:7)=CAR2(46,1:7)./10^4;
VOC_CAR(i+9,1:7)=CAR2(47,1:7)./10^4;
VOC_CAR(i+9*2,1:7)=CAR2(48,1:7)./10^4;
VOC_CAR(i+9*3,1:7)=CAR2(49,1:7)./10^4;
VOC_CAR(i+9*4,1:7)=CAR2(50,1:7)./10^4;
VOC_CAR(i+9*5,1:7)=CAR2(51,1:7)./10^4;
VOC_CAR(i+9*6,1:7)=CAR2(52,1:7)./10^4;
VOC_CAR(i+9*7,1:7)=CAR2(53,1:7)./10^4;
VOC_CAR(i+9*8,1:7)=CAR2(54,1:7)./10^4;
SO2_CAR(i,1:7)=CAR2(55,1:7)./10^4;
SO2_CAR(i+9,1:7)=CAR2(56,1:7)./10^4;
SO2_CAR(i+9*2,1:7)=CAR2(57,1:7)./10^4;
SO2_CAR(i+9*3,1:7)=CAR2(58,1:7)./10^4;
SO2_CAR(i+9*4,1:7)=CAR2(59,1:7)./10^4;
SO2_CAR(i+9*5,1:7)=CAR2(60,1:7)./10^4;
SO2_CAR(i+9*6,1:7)=CAR2(61,1:7)./10^4;
SO2_CAR(i+9*7,1:7)=CAR2(62,1:7)./10^4;
SO2_CAR(i+9*8,1:7)=CAR2(63,1:7)./10^4;
PM25_CAR(i,1:7)=CAR2(37,1:7)./10^4;
PM25_CAR(i+9,1:7)=CAR2(38,1:7)./10^4;
PM25_CAR(i+9*2,1:7)=CAR2(39,1:7)./10^4;
PM25_CAR(i+9*3,1:7)=CAR2(40,1:7)./10^4;
PM25_CAR(i+9*4,1:7)=CAR2(41,1:7)./10^4;
PM25_CAR(i+9*5,1:7)=CAR2(42,1:7)./10^4;
PM25_CAR(i+9*6,1:7)=CAR2(43,1:7)./10^4;
PM25_CAR(i+9*7,1:7)=CAR2(44,1:7)./10^4;
PM25_CAR(i+9*8,1:7)=CAR2(45,1:7)./10^4;
end
PM10_CAR=PM25_CAR;
CO2_PLANT(1:81,1)=6400632.76./10^9;
NOX_PLANT(1:81,1)=11726.4445./10^4;
CO_PLANT(1:81,1)=4617.2269./10^4;
VOC_PLANT(1:81,1)=92.343./10^4;
SO2_PLANT(1:81,1)=1500.31692./10^4;
PM25_PLANT(1:81,1)=101.7572./10^4;
PM10_PLANT(1:81,1)=412.6802./10^4;
for i=1:81
CO2_PLANT(i,2:7)=JG_CHINA(i,1:6)./10^9;
NOX_PLANT(i,2:7)=JG_CHINA(i,7:12)./10^4;
CO_PLANT(i,2:7)=JG_CHINA(i,13:18)./10^4;
VOC_PLANT(i,2:7)=JG_CHINA(i,19:24)./10^4;
SO2_PLANT(i,2:7)=JG_CHINA(i,25:30)./10^4;
PM25_PLANT(i,2:7)=JG_CHINA(i,31:36)./10^4;
PM10_PLANT(i,2:7)=JG_CHINA(i,37:42)./10^4;
end
P1(1:81,1:7)=CO2_PLANT(1:81,1:7)+CO2_CAR(1:81,1:7);
P1(1:81,8:14)=NOX_PLANT(1:81,1:7)+NOX_CAR(1:81,1:7);
P1(1:81,15:21)=CO_PLANT(1:81,1:7)+CO_CAR(1:81,1:7);
P1(1:81,22:28)=VOC_PLANT(1:81,1:7)+VOC_CAR(1:81,1:7);
P1(1:81,29:35)=SO2_PLANT(1:81,1:7)+SO2_CAR(1:81,1:7);
P1(1:81,36:42)=PM25_PLANT(1:81,1:7)+PM25_CAR(1:81,1:7);
P1(1:81,43:49)=PM10_PLANT(1:81,1:7)+PM10_CAR(1:81,1:7);
figure %CO2
x=2020:5:2050;
%LOW-MID V1-P4
plot(x,P1(4,1:7),'Color',[76 32 118]./255,'linewidth',2)
hold on
%LOW-HIG V1-P7
plot(x,P1(7,1:7),'Color',[166 149 197]./255,'linewidth',2)
hold on
%MID-LOW V4-P1
plot(x,P1(28,1:7),'Color',[170 64 6]./255,'linewidth',2)
hold on
%MID-MID V4-P4
plot(x,P1(31,1:7),'Color',[228 87 8]./255,'linewidth',2)
hold on
%MID-HIG V4-P7
plot(x,P1(34,1:7),'Color',[248 128 62]./255,'linewidth',2)
hold on
%HIG-LOW V7-P1
plot(x,P1(55,1:7),'Color',[0 112 50]./255,'linewidth',2)
hold on
%HIG-MID V7-P4
plot(x,P1(58,1:7),'Color',[0 176 80]./255,'linewidth',2)
hold on
%HIG-HIG V7-P7
plot(x,P1(61,1:7),'Color',[110 226 159]./255,'linewidth',2)
hold on
%Benchmark V1-P1
plot(x,P1(1,1:7),'-Xk','linewidth',2.5)
hold on
xlim([2020,2050]);
hold on
figure %NOX
x=2020:5:2050;
%LOW-MID V1-P4
plot(x,P1(4,8:14),'Color',[76 32 118]./255,'linewidth',2)
hold on
%LOW-HIG V1-P7
plot(x,P1(7,8:14),'Color',[166 149 197]./255,'linewidth',2)
hold on
%MID-LOW V4-P1
plot(x,P1(28,8:14),'Color',[170 64 6]./255,'linewidth',2)
hold on
%MID-MID V4-P4
plot(x,P1(31,8:14),'Color',[228 87 8]./255,'linewidth',2)
hold on
%MID-HIG V4-P7
plot(x,P1(34,8:14),'Color',[248 128 62]./255,'linewidth',2)
hold on
%HIG-LOW V7-P1
plot(x,P1(55,8:14),'Color',[0 112 50]./255,'linewidth',2)
hold on
%HIG-MID V7-P4
plot(x,P1(58,8:14),'Color',[0 176 80]./255,'linewidth',2)
hold on
%HIG-HIG V7-P7
plot(x,P1(61,8:14),'Color',[110 226 159]./255,'linewidth',2)
hold on
%Benchmark V1-P1
plot(x,P1(1,8:14),'-Xk','linewidth',2.5)
hold on
xlim([2020,2050]);
hold on
figure %CO
x=2020:5:2050;
%LOW-MID V1-P4
plot(x,P1(4,15:21),'Color',[76 32 118]./255,'linewidth',2)
hold on
%LOW-HIG V1-P7
plot(x,P1(7,15:21),'Color',[166 149 197]./255,'linewidth',2)
hold on
%MID-LOW V4-P1
plot(x,P1(28,15:21),'Color',[170 64 6]./255,'linewidth',2)
hold on
%MID-MID V4-P4
plot(x,P1(31,15:21),'Color',[228 87 8]./255,'linewidth',2)
hold on
%MID-HIG V4-P7
plot(x,P1(34,15:21),'Color',[248 128 62]./255,'linewidth',2)
hold on
%HIG-LOW V7-P1
plot(x,P1(55,15:21),'Color',[0 112 50]./255,'linewidth',2)
hold on
%HIG-MID V7-P4
plot(x,P1(58,15:21),'Color',[0 176 80]./255,'linewidth',2)
hold on
%HIG-HIG V7-P7
plot(x,P1(61,15:21),'Color',[110 226 159]./255,'linewidth',2)
hold on
%Benchmark V1-P1
plot(x,P1(1,15:21),'-Xk','linewidth',2.5)
hold on
xlim([2020,2050]);
hold on
figure %VOC
x=2020:5:2050;
%LOW-MID V1-P4
plot(x,P1(4,22:28),'Color',[76 32 118]./255,'linewidth',2)
hold on
%LOW-HIG V1-P7
plot(x,P1(7,22:28),'Color',[166 149 197]./255,'linewidth',2)
hold on
%MID-LOW V4-P1
plot(x,P1(28,22:28),'Color',[170 64 6]./255,'linewidth',2)
hold on
%MID-MID V4-P4
plot(x,P1(31,22:28),'Color',[228 87 8]./255,'linewidth',2)
hold on
%MID-HIG V4-P7
plot(x,P1(34,22:28),'Color',[248 128 62]./255,'linewidth',2)
hold on
%HIG-LOW V7-P1
plot(x,P1(55,22:28),'Color',[0 112 50]./255,'linewidth',2)
hold on
%HIG-MID V7-P4
plot(x,P1(58,22:28),'Color',[0 176 80]./255,'linewidth',2)
hold on
%HIG-HIG V7-P7
plot(x,P1(61,22:28),'Color',[110 226 159]./255,'linewidth',2)
hold on
%Benchmark V1-P1
plot(x,P1(1,22:28),'-Xk','linewidth',2.5)
hold on
xlim([2020,2050]);
hold on
figure %SO2
x=2020:5:2050;
%LOW-MID V1-P4
plot(x,P1(4,29:35),'Color',[76 32 118]./255,'linewidth',2)
hold on
%LOW-HIG V1-P7
plot(x,P1(7,29:35),'Color',[166 149 197]./255,'linewidth',2)
hold on
%MID-LOW V4-P1
plot(x,P1(28,29:35),'Color',[170 64 6]./255,'linewidth',2)
hold on
%MID-MID V4-P4
plot(x,P1(31,29:35),'Color',[228 87 8]./255,'linewidth',2)
hold on
%MID-HIG V4-P7
plot(x,P1(34,29:35),'Color',[248 128 62]./255,'linewidth',2)
hold on
%HIG-LOW V7-P1
plot(x,P1(55,29:35),'Color',[0 112 50]./255,'linewidth',2)
hold on
%HIG-MID V7-P4
plot(x,P1(58,29:35),'Color',[0 176 80]./255,'linewidth',2)
hold on
%HIG-HIG V7-P7
plot(x,P1(61,29:35),'Color',[110 226 159]./255,'linewidth',2)
hold on
%Benchmark V1-P1
plot(x,P1(1,29:35),'-Xk','linewidth',2.5)
hold on
xlim([2020,2050]);
hold on
figure %PM2.5
x=2020:5:2050;
%LOW-MID V1-P4
plot(x,P1(4,36:42),'Color',[76 32 118]./255,'linewidth',2)
hold on
%LOW-HIG V1-P7
plot(x,P1(7,36:42),'Color',[166 149 197]./255,'linewidth',2)
hold on
%MID-LOW V4-P1
plot(x,P1(28,36:42),'Color',[170 64 6]./255,'linewidth',2)
hold on
%MID-MID V4-P4
plot(x,P1(31,36:42),'Color',[228 87 8]./255,'linewidth',2)
hold on
%MID-HIG V4-P7
plot(x,P1(34,36:42),'Color',[248 128 62]./255,'linewidth',2)
hold on
%HIG-LOW V7-P1
plot(x,P1(55,36:42),'Color',[0 112 50]./255,'linewidth',2)
hold on
%HIG-MID V7-P4
plot(x,P1(58,36:42),'Color',[0 176 80]./255,'linewidth',2)
hold on
%HIG-HIG V7-P7
plot(x,P1(61,36:42),'Color',[110 226 159]./255,'linewidth',2)
hold on
%Benchmark V1-P1
plot(x,P1(1,36:42),'-Xk','linewidth',2.5)
hold on
xlim([2020,2050]);
hold on
figure %PM10
x=2020:5:2050;
%LOW-MID V1-P4
plot(x,P1(4,43:49),'Color',[76 32 118]./255,'linewidth',2)
hold on
%LOW-HIG V1-P7
plot(x,P1(7,43:49),'Color',[166 149 197]./255,'linewidth',2)
hold on
%MID-LOW V4-P1
plot(x,P1(28,43:49),'Color',[170 64 6]./255,'linewidth',2)
hold on
%MID-MID V4-P4
plot(x,P1(31,43:49),'Color',[228 87 8]./255,'linewidth',2)
hold on
%MID-HIG V4-P7
plot(x,P1(34,43:49),'Color',[248 128 62]./255,'linewidth',2)
hold on
%HIG-LOW V7-P1
plot(x,P1(55,43:49),'Color',[0 112 50]./255,'linewidth',2)
hold on
%HIG-MID V7-P4
plot(x,P1(58,43:49),'Color',[0 176 80]./255,'linewidth',2)
hold on
%HIG-HIG V7-P7
plot(x,P1(61,43:49),'Color',[110 226 159]./255,'linewidth',2)
hold on
%Benchmark V1-P1
plot(x,P1(1,43:49),'-Xk','linewidth',2.5)
hold on
xlim([2020,2050]);
hold on