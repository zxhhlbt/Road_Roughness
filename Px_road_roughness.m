Gq0=64e-6;
n0=0.1;    % �ο��ռ�Ƶ��n0
n_min=0.011;
n_max=2.83;
m=200;    %�ռ�Ƶ��m�ȷ�
delta_n=(n_max-n_min)/m;
T=10;
time=linspace(0,T,m);
V=40;    %�ٶ�
sita=unifrnd(0,2*pi,1,m);    % ����[0,2*pi]�������

f=zeros(size(sita));
n=zeros(size(sita));
w=zeros(size(sita));
Gq=zeros(size(sita));
Q=zeros(size(sita));
Z=zeros(size(sita));

for k=1:m
   n(k)=n_min+(k-1)*delta_n;  % Ƶ��
      w(k)=2*pi/T*(k-1);         % ��Ƶ�ʣ�w=2*pi*f
      Gq(k)=Gq0.*(n(k)./n0).^(-2);   % �������ܶ�Gq(n)=Gq0.*(n/n0).^(-w)������w=2;
end

w(k)=2*pi/T*(k-1);
for l=1:length(time)
    for k=1:m
      n(k)=n_min+(k-1)*delta_n;  % ÿ��С���������Ƶ��
      w(k)=2*pi/T*(k-1);         % ��Ƶ�ʣ�w=2*pi*f
      Gq(k)=Gq0.*(n(k)./n0).^(-2);   % ÿ��С��������Ƶ�ʴ���Ӧ�Ĺ������ܶ�ֵ
      Q(k)=sqrt(2*Gq(k)*delta_n)*sin(2*pi*n(k)*V*time(l)+sita(k));%���λ�Ƽ���
      f(k)=V*n(k);   %ת��Ϊʱ��Ƶ��
    end
    Z(l)=sum(Q);
end

figure(1)
subplot(211);
plot(time,Z,'r');    % ʱ���ź�
xlabel('ʱ��t');ylabel('·�治ƽ��Z');grid on;  

subplot(212);
loglog(f,Gq,'r');    % �����׺���
xlabel('Ƶ�� Hz');ylabel('�������ܶ� PSD');hold on;grid on;
y=(abs(fft(Z))).^2/m; %ʱ���ź�FFT�任�õ��Ĺ����׺���
loglog(f,y,'b');