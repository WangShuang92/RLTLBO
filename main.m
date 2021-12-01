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

clear all 
clc
close all
Solution_no=30;  % Number of search agents
F_name='F1';  % Name of the test function
M_Iter=500;  % Maximum number of iterations 

% Load details of the selected benchmark function
[LB,UB,Dim,F_obj]=Get_Functions_details(F_name); 

[Best_FF,Best,conv]=RLTLBO(Solution_no,M_Iter,LB,UB,Dim,F_obj);

 % Plot test function and convergence curve
 figure('Position',[454   445   694   297]);
 subplot(1,2,1);
 func_plot(F_name);
 title('Parameter space')
 xlabel('x_1');
 ylabel('x_2');
 zlabel([F_name,'( x_1 , x_2 )'])
 
 subplot(1,2,2);
 semilogy(conv,'Color','r','linewidth',1.5)

 title(F_name)
 xlabel('Iteration');
 ylabel('Best Score');
 axis tight
 legend('RLTLBO');

% Display the optimal solution
 display(['The best solution obtained by RLTLBO is  ', num2str(Best)]);
 display(['The best optimal values by RLTLBO is : ', num2str(Best_FF)]);



