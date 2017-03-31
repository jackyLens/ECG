%% feature extraction function
% input:  single period ECG signal, qrs wave start point, qrs wave end point and the number of qrs waves 
% output: morphological feature
%%
function [feature, wave_num, all_point] = feature_extraction(dat_proc, qrs_on, qrs_off, qrs_num, T, TON_OFF)
[q_peak, r_peak, ~, s_peak] = qrs_extract_v2(dat_proc, qrs_on, qrs_off);
[~, p_on, p1_peak, ~, ~, p_off, ~, ~, ~, t_on, t1_peak, ~, ~, t_off] = pt_extract_v2(dat_proc, qrs_on, q_peak, r_peak, s_peak, qrs_off);
% boundary = [p_on,p1_peak,p_off,q_peak,r_peak,s_peak,t_on,t1_peak,t_off];     % ���ECG�ĵ��ź�������

%------------------------------ ����ton��toff --------------_--------------
if TON_OFF
    all_point = 0;
    q_on = qrs_on;
    s_off = qrs_off;
    p_peak = p1_peak;
    t_peak = t1_peak;

    nom = zeros(qrs_num,1);

    Qpeak_Rpeak = r_peak - q_peak;  % QR����
    Rpeak_Speak = s_peak - r_peak;  % RS����
    Qon_Soff=  s_off - q_on;        % QonSoff, �����������ڲ��ý��й�һ��
    Pon_Poff = zeros(qrs_num,1);    % PonPoff
    Pon_Qon = zeros(qrs_num,1);     % PonQon
    Qon_Toff = zeros(qrs_num,1);    % QonToff
    Pon_Rpeak = zeros(qrs_num,1);   % PonRpeak
    Ppeak_Rpeak = zeros(qrs_num,1); % PpeakRpeak
    Poff_Rpeak = zeros(qrs_num,1);  % PoffRpeak
    Rpeak_Ton = zeros(qrs_num,1);   % RpeakTon
    Rpeak_Tpeak = zeros(qrs_num,1); % RpeakTpeak
    Rpeak_Toff = zeros(qrs_num,1);  % RpeakToff
    Ton_Toff = zeros(qrs_num,1);    % TonToff
    Speak_Tpeak = zeros(qrs_num,1); % SpeakTpeak
    Ppeak_Qpeak = zeros(qrs_num,1); % PpeakQpeak
    Ppeak_Tpeak = zeros(qrs_num,1); % PpeakTpeak
    Pon_Qpeak = zeros(qrs_num,1);   % PonQpeak
    Speak_Toff = zeros(qrs_num,1);  % SpeakToff, ����Ϊ20����������
    Qpeak_Rpeak_amp = zeros(qrs_num,1);   % Qpeak��Rpeak��ֵ��
    Rpeak_Speak_amp = zeros(qrs_num,1);   % Rpeak��Speak��ֵ��, ����Ϊ2����ֵ����
    Speak_Tpeak_grad = zeros(qrs_num,1);  % Speak��Tpeakб��, 1��б������

    for i = 1:qrs_num
        nom(i) = t_off(i) - p_on(i);  % nomһ�㲻����Ϊ0
        Pon_Poff(i) = (p_off(i) - p_on(i))/nom(i);
        Pon_Qon(i) = (q_on(i) - p_on(i))/nom(i);
        Qon_Toff(i) = (t_off(i) - q_on(i))/nom(i);
        Pon_Rpeak(i) = (r_peak(i) - p_on(i))/nom(i);
        Ppeak_Rpeak(i) = (r_peak(i) - p_peak(i))/nom(i);
        Poff_Rpeak(i) = (r_peak(i) - p_off(i))/nom(i);    
        Rpeak_Ton(i) = (t_on(i) - r_peak(i))/nom(i);
        Rpeak_Tpeak(i) = (t_peak(i) - r_peak(i))/nom(i);
        Rpeak_Toff(i) = (t_off(i) - r_peak(i))/nom(i);
        Ton_Toff(i) = (t_off(i) - t_on(i))/nom(i);
        Speak_Tpeak(i) = (t_peak(i) - s_peak(i))/nom(i);
        Ppeak_Qpeak(i) = (q_peak(i) - p_peak(i))/nom(i);
        Ppeak_Tpeak(i) = (t_peak(i) - p_peak(i))/nom(i);
        Pon_Qpeak(i) = (q_peak(i) - p_on(i))/nom(i);
        Speak_Toff(i) = (t_off(i) - s_peak(i))/nom(i);
        if r_peak(i) ~= 0 && q_peak(i) ~= 0
            Qpeak_Rpeak_amp(i) = dat_proc(r_peak(i)) - dat_proc(q_peak(i));
        end
        if s_peak(i) ~= 0 && r_peak(i) ~= 0
            Rpeak_Speak_amp(i) = dat_proc(r_peak(i)) - dat_proc(s_peak(i));
        end
        if t_peak(i) ~= 0 && s_peak(i) ~= 0
            Speak_Tpeak_grad(i) = (dat_proc(t_peak(i)) - dat_proc(s_peak(i))) / (t_peak(i) - s_peak(i));
        end
    end

    % ��ȡ�����ʧ�ܵ��ĵ粨������
    p_on_wrong = find(p_on == 0);  % 2
    p_peak_wrong = find(p_peak == 0); % 2
    p_off_wrong = find(p_off == 0); % 2
    q_on_wrong = find(q_on == 0);  % 0
    q_peak_wrong = find(q_peak == 0);  % 4
    r_peak_wrong = find(r_peak == 0);  % 0
    s_peak_wrong = find(s_peak == 0);  % 1
    s_off_wrong = find(s_off == 0);    % 0

    % T�����ķǳ�����
    t_on_wrong = find(t_on == 0);
    t_peak_wrong = find(t_peak == 0);
    t_off_wrong = find(t_off == 0);
    qr_amp_wrong = find(Qpeak_Rpeak_amp == 0);
    rs_amp_wrong = find(Rpeak_Speak_amp == 0);
    st_grad_wrong = find(Speak_Tpeak_grad == 0);
    % �����ʧ�ܵ��ĵ粨������ֱ��ɾ��
    all_wrong = [p_on_wrong;p_peak_wrong;p_off_wrong;
                 q_on_wrong;q_peak_wrong;r_peak_wrong;s_peak_wrong;
                 s_off_wrong;t_on_wrong;t_peak_wrong;t_off_wrong;
                 qr_amp_wrong;rs_amp_wrong;st_grad_wrong];
    all_wrong = unique(all_wrong);  %��Ҫɾ�����е����

    % ѡ����18����������, 2����ֵ������1��б������, ��22������
    % ��֪QpeakRpeak��RpeakSpeak����QpeakSpeak����
    all_feature = [Qpeak_Rpeak,Rpeak_Speak,Qon_Soff,Pon_Poff,...
                   Pon_Qon,Qon_Toff,Pon_Rpeak,Ppeak_Rpeak,...
                   Poff_Rpeak,Rpeak_Ton,Rpeak_Tpeak,Rpeak_Toff,...
                   Ton_Toff,Speak_Tpeak,Ppeak_Qpeak,Ppeak_Tpeak,...
                   Pon_Qpeak,Speak_Toff,Qpeak_Rpeak_amp,Rpeak_Speak_amp,Speak_Tpeak_grad];

    all_feature(all_wrong,:) = [];
    feature = all_feature;
    wave_num = size(all_feature,1);
else
%---------------------------- ������Ton��Toff ------------------------------
    q_on = qrs_on;
    s_off = qrs_off;
    p_peak = p1_peak;
    t_peak = T;

    all_point = [p_on,p_peak,p_off,q_on,q_peak,r_peak,s_peak,s_off,t_peak];
    % check all_point, the value in the consecutive column should be increasing
    seq_wrong = [];
    for i = 1:size(all_point,1)
        for j = 1:size(all_point,2)-1
            if all_point(i,j+1) < all_point(i,j)
                seq_wrong = [seq_wrong;i];
                break
            end
        end
    end


    nom = zeros(qrs_num,1);

    Qpeak_Rpeak = r_peak - q_peak;  % QR����
    Rpeak_Speak = s_peak - r_peak;  % RS����
    Qon_Soff=  s_off - q_on;        % QonSoff, �����������ڲ��ý��й�һ��
    Pon_Poff = zeros(qrs_num,1);    % PonPoff
    Pon_Qon = zeros(qrs_num,1);     % PonQon
    Qon_Tpeak = zeros(qrs_num,1);    % QonToff
    Pon_Rpeak = zeros(qrs_num,1);   % PonRpeak
    Ppeak_Rpeak = zeros(qrs_num,1); % PpeakRpeak
    Poff_Rpeak = zeros(qrs_num,1);  % PoffRpeak
    % Rpeak_Ton = zeros(qrs_num,1);   % RpeakTon
    Rpeak_Tpeak = zeros(qrs_num,1); % RpeakTpeak
    % Rpeak_Toff = zeros(qrs_num,1);  % RpeakToff
    % Tpeak_Toff = zeros(qrs_num,1);    % TonToff
    Speak_Tpeak = zeros(qrs_num,1); % SpeakTpeak
    Ppeak_Qpeak = zeros(qrs_num,1); % PpeakQpeak
    % Ppeak_Tpeak = zeros(qrs_num,1); % PpeakTpeak
    Pon_Qpeak = zeros(qrs_num,1);   % PonQpeak
    % Speak_Toff = zeros(qrs_num,1);  % SpeakToff, ����Ϊ20����������
    Qpeak_Rpeak_amp = zeros(qrs_num,1);   % Qpeak��Rpeak��ֵ��
    Rpeak_Speak_amp = zeros(qrs_num,1);   % Rpeak��Speak��ֵ��, ����Ϊ2����ֵ����
    Speak_Tpeak_grad = zeros(qrs_num,1);  % Speak��Tpeakб��, 1��б������

    for i = 1:qrs_num
        nom(i) = t_peak(i) - p_peak(i);  % nomһ�㲻����Ϊ0
        Pon_Poff(i) = (p_off(i) - p_on(i))/nom(i);
        Pon_Qon(i) = (q_on(i) - p_on(i))/nom(i);
        Qon_Tpeak(i) = (t_peak(i) - q_on(i))/nom(i);
        Pon_Rpeak(i) = (r_peak(i) - p_on(i))/nom(i);
        Ppeak_Rpeak(i) = (r_peak(i) - p_peak(i))/nom(i);
        Poff_Rpeak(i) = (r_peak(i) - p_off(i))/nom(i);    
    %     Rpeak_Ton(i) = (t_on(i) - r_peak(i))/nom(i);
        Rpeak_Tpeak(i) = (t_peak(i) - r_peak(i))/nom(i);
    %     Rpeak_Toff(i) = (t_off(i) - r_peak(i))/nom(i);
    %     Tpeak_Toff(i) = (t_peak(i) - t_on(i))/nom(i);
        Speak_Tpeak(i) = (t_peak(i) - s_peak(i))/nom(i);
        Ppeak_Qpeak(i) = (q_peak(i) - p_peak(i))/nom(i);
    %     Ppeak_Tpeak(i) = (t_peak(i) - p_peak(i))/nom(i);
        Pon_Qpeak(i) = (q_peak(i) - p_on(i))/nom(i);
    %     Speak_Toff(i) = (t_off(i) - s_peak(i))/nom(i);
        if r_peak(i) ~= 0 && q_peak(i) ~= 0
            Qpeak_Rpeak_amp(i) = dat_proc(r_peak(i)) - dat_proc(q_peak(i));
        end
        if s_peak(i) ~= 0 && r_peak(i) ~= 0
            Rpeak_Speak_amp(i) = dat_proc(r_peak(i)) - dat_proc(s_peak(i));
        end
        if t_peak(i) ~= 0 && s_peak(i) ~= 0
            Speak_Tpeak_grad(i) = (dat_proc(t_peak(i)) - dat_proc(s_peak(i))) / (t_peak(i) - s_peak(i));
        end
    end

    % ��ȡ�����ʧ�ܵ��ĵ粨������
    p_on_wrong = find(p_on == 0);  % 2
    p_peak_wrong = find(p_peak == 0); % 2
    p_off_wrong = find(p_off == 0); % 2
    q_on_wrong = find(q_on == 0);  % 0
    q_peak_wrong = find(q_peak == 0);  % 4
    r_peak_wrong = find(r_peak == 0);  % 0
    s_peak_wrong = find(s_peak == 0);  % 1
    s_off_wrong = find(s_off == 0);    % 0

    % T�����ķǳ�����
    % t_on_wrong = find(t_on == 0);
    % size(t_on_wrong)
    t_peak_wrong = find(t_peak == 0);
    % t_off_wrong = find(t_off == 0);
    % size(t_off_wrong)
    qr_amp_wrong = find(Qpeak_Rpeak_amp == 0);
    rs_amp_wrong = find(Rpeak_Speak_amp == 0);
    st_grad_wrong = find(Speak_Tpeak_grad == 0);
    % �����ʧ�ܵ��ĵ粨������ֱ��ɾ��
    all_wrong = [seq_wrong;p_on_wrong;p_peak_wrong;p_off_wrong;
                 q_on_wrong;q_peak_wrong;r_peak_wrong;s_peak_wrong;
                 s_off_wrong;t_peak_wrong;qr_amp_wrong;rs_amp_wrong;st_grad_wrong];
    all_wrong = unique(all_wrong);  %��Ҫɾ�����е����
    length(all_wrong)
    % ѡ����18����������, 2����ֵ������1��б������, ��22������
    % ��֪QpeakRpeak��RpeakSpeak����QpeakSpeak����
    all_feature = [Qpeak_Rpeak,Rpeak_Speak,Qon_Soff,Pon_Poff,...
                   Pon_Qon,Qon_Tpeak,Pon_Rpeak,Ppeak_Rpeak,...
                   Poff_Rpeak,Rpeak_Tpeak,Speak_Tpeak,Ppeak_Qpeak,...
                   Pon_Qpeak,Qpeak_Rpeak_amp,Rpeak_Speak_amp,Speak_Tpeak_grad];

    all_feature(all_wrong,:) = [];
    feature = all_feature;
    wave_num = size(all_feature,1);
end