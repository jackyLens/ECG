% һ������(hea,atr,dat)����65w�������㣬���Ը�����Ҫ�Լ�ѡ����Ҫ��������Ŀ,����4096����10�����壬����9����������
% ������洢�ھ���TIME�У����Ը�����Ҫ�Լ�ת�������1,2,...,SAMPLES2READ
% ��ѹֵ�洢��M�У������ж�ͨ��������M�Ĵ�СΪSAMPLES2READ*2,����ֻѡ�õ���ͨ����Ҳ����������ѡ,��ʱѡ��MILL����
function [VOLTAGE,fs] = MIT_BIH_rdata(i,PATH)

SAMPLES2READ=65536*8;
% VOLTAGE = zeros(SAMPLES2READ,2);


HEADERFILE = strcat(num2str(i),'.hea');      % .hea ��ʽ��ͷ�ļ������ü��±���
DATAFILE = strcat(num2str(i),'.dat');         % .dat ��ʽ��ECG ���ݣ�ÿ�����ֽڴ洢��������һ����12bit
fprintf('$> WORKING ON %s ...\n', HEADERFILE);
%------ LOAD HEADER DATA --------------------------------------------------
%------ ����ͷ�ļ����� -----------------------------------------------------
%
% ʾ�����ü��±��򿪵�117.hea �ļ�������
%
%      117 2 360 650000        % ��һ����117Ϊ����id���ڶ�����2Ϊ�ź�ͨ����Ŀ����������360Ϊ���ݲ���Ƶ��
%      117.dat 212 200 11 1024 839 31170 0 MLII  % �ź�ͨ����ĿΪ2����˺��滹����������
%      117.dat 212 200 11 1024 930 28083 0 V2    % ÿ���ź�ͨ���У���һ����������212Ϊ��ʽ����
%      # 69 M 950 654 x2                         % �ڶ�����������200Ϊÿ���ź�������200ADCunits/Mv
%      # None                                    % ��������������11Ϊ�������ȣ�λ�ֱ��ʣ�ADC11λ
%                                                % ���ĸ���������1024ΪECG�ź������Ӧ������ֵ
%                                                % �������������839/930Ϊ�źŵĵ�һ������ֵ
%-------------------------------------------------------------------------

% ���¾���117.hea, 117.atr��117.datΪ��
%     fprintf(1,'$> WORKING ON %s ...\n', HEADERFILE); % ��Matlab�����д�����ʾ��ǰ����״̬
% 
% ��ע������ fprintf �Ĺ��ܽ���ʽ��������д�뵽ָ���ļ��С�
% ���ʽ��count = fprintf(fid,format,A,...)
% ���ַ���'format'�Ŀ����£�������A��ʵ�����ݽ��и�ʽ������д�뵽�ļ�����fid�С��ú���������д�����ݵ��ֽ��� count��
% fid ��ͨ������ fopen ��õ������ļ���ʶ����fid=1����ʾ��׼��������������Ļ��ʾ����fid=2����ʾ��׼ƫ�
%
signalh= fullfile(PATH, HEADERFILE);    % ͨ������ fullfile ���ͷ�ļ�������·��, ����MIT_BIH_ECG_database\100.hea
fid1=fopen(signalh,'r');    % ��ͷ�ļ������ʶ��Ϊ fid1 ������Ϊ'r'--��ֻ����
z= fgetl(fid1);             % ��ȡͷ�ļ��ĵ�һ�����ݣ��ַ�����ʽ, ��ȡ����Ϊ117 2 360 650000, fgetl()��ÿ�ζ�1��, �ڶ��ε��ö��ڶ���
A= sscanf(z, '%*s %d %d %d',[1,3]); % ���ո�ʽ '%*s %d %d %d' ת�����ݲ�������� A ��, ֻ�����%d����
nosig= A(1);    % �ź�ͨ����Ŀ
sfreq=A(2);     % ���ݲ���Ƶ��
fs = sfreq;
clear A;        % ��վ��� A ��׼����ȡ��һ������
for k=1:nosig           % ��ȡÿ��ͨ���źŵ�������Ϣ
    z= fgetl(fid1);     % ����һ������
    A= sscanf(z, '%*s %d %d %d %d %d',[1,5]);
    dformat(k)= A(1);           % �źŸ�ʽ; ����ֻ����Ϊ 212 ��ʽ
    gain(k)= A(2);              % ÿ mV ��������������
    bitres(k)= A(3);            % �������ȣ�λ�ֱ��ʣ�
    zerovalue(k)= A(4);         % ECG �ź������Ӧ������ֵ
    firstvalue(k)= A(5);        % �źŵĵ�һ������ֵ (����ƫ�����)
end;
        
fclose(fid1);
clear A;
% ͷ�ļ����ݶ�ȡ��ϣ�����nosig, sfreq, dformat, gain, bitres, zerovalue��firstvalue��

%------ LOAD BINARY DATA --------------------------------------------------
%------ ��ȡ ECG �źŶ�ֵ���� ----------------------------------------------
%
if dformat~= [212,212], error('this script does not apply binary formats different to 212.'); end;  % ��ʽ�������Ϊ����212
signald= fullfile(PATH, DATAFILE);            % ���� 212 ��ʽ�� ECG �ź�����, 'MIT_BIH_ECG_database\117.dat'
fid2=fopen(signald,'r');

% fread(fid,size,precision)�Զ�������ʽ���ļ��ж�ȡ������,
% size��Ϊ[M,N], �ѱ���ֱ�Ӷ���M��N�еľ�������д�����
A= fread(fid2, [3, SAMPLES2READ*5], 'uint8')';  % matrix with 3 rows, each 8 bits long, = 2*12bit
fclose(fid2);
% ͨ��һϵ�е���λ��bitshift����λ�루bitand�����㣬���ź��ɶ�ֵ����ת��Ϊʮ������
M2H= bitshift(A(:,2), -4);        %�ֽ���������λ����ȡ�ֽڵĸ���λ
M1H= bitand(A(:,2), 15);          %ȡ�ֽڵĵ���λ����1111�����룬��ȡĩ��λ
PRL=bitshift(bitand(A(:,2),8),9);     % sign-bit   ȡ���ֽڵ���λ�����λ�������ƾ�λ
PRR=bitshift(bitand(A(:,2),128),5);   % sign-bit   ȡ���ֽڸ���λ�����λ����������λ
M( : , 1)= bitshift(M1H,8)+ A(:,1)-PRL;
M( : , 2)= bitshift(M2H,8)+ A(:,3)-PRR;
if M(1,:) ~= firstvalue
    disp('$> inconsistency in the first bit values');
end;
% plot(M(1:65536*8,1),'b')

% switch nosig
% case 2
%     M( : , 1)= (M( : , 1)- zerovalue(1))/gain(1);
%     M( : , 2)= (M( : , 2)- zerovalue(2))/gain(2);
% case 1
%     M( : , 1)= (M( : , 1)- zerovalue(1));
%     M( : , 2)= (M( : , 2)- zerovalue(1));
%     M=M';
%     M(1)=[];
%     sM=size(M);
%     sM=sM(2)+1;
%     M(sM)=0;
%     M=M';
%     M=M/gain(1);
% otherwise  % this case did not appear up to now!
%     % here M has to be sorted!!!
%     disp('Sorting algorithm for more than 2 signals not programmed yet!');
% end;
clear A M1H M2H PRR PRL;
fprintf(1,'$> LOADING DATA FINISHED\n');

DISPLAY = 0;
%------ DISPLAY DATA --------------------------------------------------
if DISPLAY
    NUMBER = 1:SAMPLES2READ;
    figure; clf, box on, hold on
    % ������һ��ͨ�����ź�
    size(M)
    plot(NUMBER, M(1:SAMPLES2READ,1),'r');
    % ���˫ͨ�����ѵڶ���Ҳ������
    if nosig==2
        plot(NUMBER, M(1:SAMPLES2READ,2),'b');
    end;
    xlim([NUMBER(1), NUMBER(end)]);
    xlabel('Time / s'); ylabel('Voltage / mV');
    string=['ECG signal ',DATAFILE];
    title(string);
    grid on
    hold off
end
% ---------------------------------------------------------------------
    
%------ STORE DATA ----------------------------------------------------

VOLTAGE = M(1:SAMPLES2READ,:);
fprintf('$> %s FINISHED\n', HEADERFILE);