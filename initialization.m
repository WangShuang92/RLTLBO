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

% This function initialize the first population of search agents
function X=initialization(N,Dim,UB,LB)

B_no= size(UB,2); % numnber of boundaries

if B_no==1
    X=rand(N,Dim).*(UB-LB)+LB;
end

% If each variable has a different lb and ub
if B_no>1
    for i=1:Dim
        Ub_i=UB(i);
        Lb_i=LB(i);
        X(:,i)=rand(N,1).*(Ub_i-Lb_i)+Lb_i;
    end
end