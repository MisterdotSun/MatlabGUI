function [xbox,ybox,prect]=getbox

 

if waitforbuttonpress %�ȴ���갴��,������귵��False�����°�������True

    return

end

 

Hf = gcf;      % �õ�������Ĵ���
%Hf = gcbf;     
Ha = gca(Hf);  % �õ������������ϵ

 

AxesPt = get(Ha,'CurrentPoint'); % �õ���һ����������ݵ�������ϵ�е�λ��

FigPt = get(Hf,'CurrentPoint');  % �������CurrentPointֵΪһ��2*3�ľ��󣬵�һ��Ϊ��۲�����

%���ĵ����ά���꣬��2��Ϊ��۲�����Զ�ĵ����ά���ꡣĬ�ϵ��ӽ�View = 90�ȵ�����£������е�

%x��y��������ͬ�ġ�һ������£�ֻ��Ҫȡpos��1�е�ǰ����Ԫ�أ���3��Ԫ��Ϊz�����꣬һ�㲻�á�

 

rbbox([FigPt 0 0],FigPt) % �����Ȧ�����ο�����ɿ�ʱ����

 

AxesPt = [AxesPt;get(Ha,'CurrentPoint')];%�����ʼ�����ֹ��

 

[Xlim,Ylim] = getn(Ha,'Xlim','Ylim');%�õ�һ������Ķ�����Եľ��

 

%xbox = [min(AxesPt(:,1)) max(AxesPt(:,1))]; %�õ��������ο����ǵ�ĺ�����
xbox = round([min(AxesPt(:,1)) max(AxesPt(:,1))]); %�õ��������ο����ǵ�ĺ�����

xbox = [max(xbox(1),Xlim(1)) min(xbox(2),Xlim(2))]; %�㲻���ڱ߽���
 

%ybox = [min(AxesPt(:,2)) max(AxesPt(:,2))];
ybox = [round(min(AxesPt(:,2))) round(max(AxesPt(:,2)))];

ybox = [max(ybox(1),Ylim(1)) min(ybox(2),Ylim(2))];
 

prect = [xbox(1) ybox(1) diff(xbox) diff(ybox)];

