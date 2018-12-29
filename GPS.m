% 某GPS网如下。对其进行间接平差:
% n = 72 t = 42, r = 30

% 已知点：X(1,:) = [100000 200000 20]; % P1
% 观测基线向量信息： table gps1

[filename,pathname,filter] = uigetfile('*.xlsx','选择gps数据文件');
if filter == 0
    return
end

% 读取数据文件
str = fullfile(pathname,filename);
Data = xlsread(str);
[row,cross]=size(Data);
X0 = zeros(1,row);

% 初值
X0(1)=1000000;
X0(2)=X0(1)+Data(2,3);
X0(3)=X0(2)+Data(5,3);
X0(4)=X0(1)-Data(1,3);
X0(5)=X0(2)+Data(2,3);
X0(6)=X0(5)-Data(11,3);
X0(7)=X0(6)-Data(14,3);
X0(8)=X0(4)-Data(8,3);
X0(9)=X0(8)-Data(17,3);
X0(10)=X0(9)+Data(20,3);
X0(11)=X0(7)+Data(15,3);
X0(12)=X0(9)+Data(18,3);
X0(13)=X0(9)-Data(19,3);
X0(14)=X0(10)+Data(21,3);


Y0=zeros(1,row);
Y0(1)=2000000;
Y0(2)=Y0(1)+Data(2,4);
Y0(3)=Y0(2)+Data(5,4);
Y0(4)=Y0(1)-Data(1,4);
Y0(5)=Y0(2)+Data(2,4);
Y0(6)=Y0(5)-Data(11,4);
Y0(7)=Y0(6)-Data(14,4);
Y0(8)=Y0(4)-Data(8,4);
Y0(9)=Y0(8)-Data(17,4);
Y0(10)=Y0(9)+Data(20,4);
Y0(11)=Y0(7)+Data(15,4);
Y0(12)=Y0(9)+Data(18,4);
Y0(13)=Y0(9)-Data(19,4);
Y0(14)=Y0(10)+Data(21,4);


Z0=zeros(1,row);
Z0(1)=0;
Z0(2)=Z0(1)+Data(2,5);
Z0(3)=Z0(2)+Data(5,5);
Z0(4)=Z0(1)-Data(1,5);
Z0(5)=Z0(2)+Data(2,5);
Z0(6)=Z0(5)-Data(11,5);
Z0(7)=Z0(6)-Data(14,5);
Z0(8)=Z0(4)-Data(8,5);
Z0(9)=Z0(8)-Data(17,5);
Z0(10)=Z0(9)+Data(20,5);
Z0(11)=Z0(7)+Data(15,5);
Z0(12)=Z0(9)+Data(18,5);
Z0(13)=Z0(9)-Data(19,5);
Z0(14)=Z0(10)+Data(21,5);



% 平差：
v = rand(72,39);
l = rand(39,1);

for i=1:row
  v(3*i-2, 3*Data(i,1)-2)=-1;
  v(3*i-2, 3*Data(i,2)-2)=1;
  v(3*i-1, 3*Data(i,1)-1)=-1;
  v(3*i-1, 3*Data(i,2)-1)=1;
  v(3*i, 3*Data(i,1))=-1;
  v(3*i, 3*Data(i,2))=1; 


l(3*i-2, 1)=Data(i,3)-X0(Data(i,2))-X0(Data(i,1));
l(3*i-1,1)=Data(i,4)-Y0(Data(i,2))-Y0(Data(i,1));
l(3*i,1)=Data(i,5)-Z0(Data(i,2))-Z0(Data(i,1)); 
end

% 计算x
v(:,1) = [];
v(:,1) = [];
v(:,1) = [];
P = eye(72);
x=inv(v'*P*v)*v'*P*l;
x
