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

% This function draws the benchmark functions

function func_plot(func_name)

[lb,ub,dim,fobj]=Get_Functions_details(func_name);

switch func_name 
    case 'F1' 
        x=-100:2:100; y=x; %[-100,100]
end    

L=length(x);
f=[];

for i=1:L
    for j=1:L
        f(i,j)=fobj([x(i),y(j)]);
    end
end
        
surfc(x,y,f,'LineStyle','none');

end

