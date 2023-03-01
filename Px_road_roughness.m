Gq0=64e-6;
n0=0.1;    % 参考空间频率n0
n_min=0.011;
n_max=2.83;
m=200;    %空间频域m等分
delta_n=(n_max-n_min)/m;
T=10;
time=linspace(0,T,m);
V=40;    %速度
sita=unifrnd(0,2*pi,1,m);    % 产生[0,2*pi]内随机数

f=zeros(size(sita));
n=zeros(size(sita));
w=zeros(size(sita));
Gq=zeros(size(sita));
Q=zeros(size(sita));
Z=zeros(size(sita));

for k=1:m
   n(k)=n_min+(k-1)*delta_n;  % 频率
      w(k)=2*pi/T*(k-1);         % 角频率，w=2*pi*f
      Gq(k)=Gq0.*(n(k)./n0).^(-2);   % 功率谱密度Gq(n)=Gq0.*(n/n0).^(-w)，其中w=2;
end

w(k)=2*pi/T*(k-1);
for l=1:length(time)
    for k=1:m
      n(k)=n_min+(k-1)*delta_n;  % 每个小区间的中心频率
      w(k)=2*pi/T*(k-1);         % 角频率，w=2*pi*f
      Gq(k)=Gq0.*(n(k)./n0).^(-2);   % 每个小区建中心频率处对应的功率谱密度值
      Q(k)=sqrt(2*Gq(k)*delta_n)*sin(2*pi*n(k)*V*time(l)+sita(k));%随机位移激励
      f(k)=V*n(k);   %转化为时间频率
    end
    Z(l)=sum(Q);
end

figure(1)
subplot(211);
plot(time,Z,'r');    % 时域信号
xlabel('时间t');ylabel('路面不平度Z');grid on;  

subplot(212);
loglog(f,Gq,'r');    % 功率谱函数
xlabel('频率 Hz');ylabel('功率谱密度 PSD');hold on;grid on;
y=(abs(fft(Z))).^2/m; %时域信号FFT变换得到的功率谱函数
loglog(f,y,'b');