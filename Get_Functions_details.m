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

% This function containts full information and implementations of the benchmark 
% functions in Table 1, Table 2, and other test functins from the literature 

% lb is the lower bound: lb=[lb_1,lb_2,...,lb_d]
% up is the uppper bound: ub=[ub_1,ub_2,...,ub_d]
% dim is the number of variables (dimension of the problem)

function [lb,ub,dim,fobj] = Get_Functions_details(F)


switch F
    case 'F1'
        fobj = @F1;
        lb=-100;
        ub=100;
        dim=30;
                  
end

end

% F1

function o = F1(x)
o=sum(x.^2);
end

