%______________________________________________________________________________________________________%
%  An Improved Teaching-learning-based Optimization Algorithm with Reinforcement Learning Strategy     %
%  for Solving Optimization Problems (RLTLBO) source codes demo 1.0                                    %
%                                                                                                      %
%  Developed in MATLAB R2016a                                                                          %
%                                                                                                      %
%  Author and programmer: Di Wang, Shuang Wang*, Qingxin Liu, Laith Abualigah, Heming Jia              %
%                                                                                                      %
%         e-Mail: wangshuang14@mails.ucas.ac.cn, wang_shuang9279@163.com                               %
%                                                                                                      %
%  Homepage: https://www.researchgate.net/profile/Shuang-Wang-52                                       %
%______________________________________________________________________________________________________%

% This function updates Q-Table
function q_table = update_q_table(q_table, r_table, lbd, sgm)

for n = 1:size(q_table, 1)
    for m = 1:size(q_table, 2)
        
        temMax = -inf;
        for i = 1:size(q_table,2)
            if q_table(m, i) > temMax
                temMax = q_table(m, i);
            end
        end
        q_table(n,m) = q_table(n,m) + lbd * (  r_table(n,m) + sgm * temMax - q_table(n,m));
    end
end