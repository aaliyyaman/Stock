veri=readtable("asels2.xlsx","Sheet","isyatirim");
veri.Tarih=(1:length(veri.Tarih))';
veri.Properties.VariableNames{1}='TARİH';
veri.Properties.VariableNames{2}='KAPANİS';

veriler=table2array(veri(:,[1,2]));

yuzde=zeros(1,length(veriler)-1)';
for i=2:length(veriler)
    yuzde(i-1)=(veriler(i,2)-veriler(i-1,2))/veriler(i-1,2);
end

yuzdeduzenleme=(1+yuzde);

para=ones(1,length(veriler));

yuzdeduzenleme2=[1;yuzdeduzenleme];
a=find(yuzdeduzenleme2<1,1);
para(a)=veriler(length(veriler)+a);
para(1:a)=para(a);

for i=a+1:length(veriler)
    if yuzdeduzenleme2(i)>1
        if yuzdeduzenleme2(i)>1 && yuzdeduzenleme2(i-1)<=1
            para(i)=para(i-1)*yuzdeduzenleme2(i);
        else
            para(i)=para(i-1);
        end
        
    elseif yuzdeduzenleme2(i)<1
        if yuzdeduzenleme2(i)<1 && yuzdeduzenleme2(i-1)>=1
            para(i)=para(i-1);
        else 
            para(i)=para(i-1)*yuzdeduzenleme2(i);
        end
    else
        para(i)=para(i-1);
    end
end



figure
yyaxis left
plot(veriler(:,2),'b-','LineWidth',2.5)
hold on
plot(para,'g-','LineWidth',2.5)
legend('Tarihsel Veriler','Teorik')
ylabel('Tarihsel Vs. Teorik')
hold on

yyaxis right
plot(yuzdeduzenleme2,'k','LineWidth',1.5)
ylabel('Yuzde Düzenleme')
xlabel('Gün')
hold off







tarihselfiyat=zeros(length(yuzde)+1,1);
tarihselfiyat(1)=veriler(1,2);
for i=1:length(yuzde)
    tarihselfiyat(i+1)=tarihselfiyat(i)*yuzdeduzenleme(i);
end
tarihselfiyat=tarihselfiyat(2:end);

figure;
yyaxis left
plot(tarihselfiyat)
ylabel('Tarihsel Fiyat')
hold on
yyaxis right
plot(yuzdeduzenleme)
ylabel('Yuzde Düzenleme')
xlabel('Gün')



