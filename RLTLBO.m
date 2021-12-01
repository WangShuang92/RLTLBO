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

function [Leader_score,Leader_pos,Convergence_curve] = RLTLBO(N,T,lb,ub,Dim,fobj)

VarSize = [1 Dim];

Leader_pos=zeros(1,Dim);
Leader_score=inf; %change this to -inf for maximization problems

%Initialize the positions of search agents
Positions=initialization(N,Dim,ub,lb);
fitness=zeros(N,1);
Tea_fitness=zeros(N,1);

% Create Empty Solution
NewPosition = zeros(1,Dim);

Convergence_curve=zeros(1,T);

t=0;% Loop counter

%Initialize the Q-Table and R-Table
q_table = zeros(2,2);
r_table = [-1 1;1 1];

% Algorithm Parameters
lbd = 0.5;
sgm = 0.5;
u = 0.6;
s = 1;
d = 2;

% Main loop
while t<T
    
    for i = 1:N
        % Boundary checking (to bring back the universes inside search
        % space if they go beyoud the boundaries��
        Flag4ub=Positions(i,:)>ub;
        Flag4lb=Positions(i,:)<lb;
        Positions(i,:)=(Positions(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
        fitness(i) = fobj(Positions(i,:));
        
        if fitness(i) < Leader_score
            Leader_score = fitness(i);
            Leader_pos = Positions(i,:);
        end
    end
    
    % Calculate Population Mean
    Mean = mean(Positions,1);
    
    % Select Teacher
    Teacher = 1;
    for i = 2:N
        if fitness(i) < fitness(Teacher)
            Teacher = i;
        end
    end
    %
    A = 1:N;
    A(Teacher) = [];
    m = A(randi(N-1));
    n = A(randi(N-1));
    while m==n
        n = A(randi(N-1));
    end
    for i = 1:N
        TF = randi([1 2]);
        % Teacher phase
        NewPosition = Positions(i,:) + rand(VarSize).*(Positions(Teacher,:)... 
            - TF*Mean + rand*(Positions(m,:)-Positions(n,:)));  % Eq.(1)
        
        Newfitness = fobj(NewPosition);
        if Newfitness<fitness(i)
            Positions(i,:) = NewPosition;
            fitness(i)=Newfitness;
            if fitness(i) < Leader_score
                Leader_score = fitness(i);
                Leader_pos = Positions(i,:);
            end
        end
    end
    
    for i = 1:N
        
        % Learner phase
        if rand()<=0.5
            if (q_table(1,1) >= q_table(1,2))
                % Learning mode 1
                A = 1:N;
                A(i) = [];
                m = A(randi(N-1));
                Step = Positions(i,:) - Positions(m,:);
                if fitness(m) < fitness(i)
                    Step = -Step;
                end
                NewPosition = Positions(i,:) + rand(VarSize).*Step;  % Eq.(2)
                
                Newfitness = fobj(NewPosition);
                if Newfitness<fitness(i)
                    Positions(i,:) = NewPosition;
                    fitness(i)=Newfitness;
                    
                    r_table(1,1) = 1; % reward = 1
                    
                    if fitness(i) < Leader_score
                        Leader_score = fitness(i);
                        Leader_pos = Positions(i,:);
                    end
                else
                    r_table(1,1) = -1; % reward = -1
                end
            else
                % Learning mode 2                
                A = 1:N;
                A(i) = [];
                m = A(randi(N-1));
                if fitness(m) < fitness(i)
                    NewPosition = Positions(i,:) + rand(VarSize).*((1-t/T).*Positions(m,:)...
                        +(t/T).*Positions(Teacher,:)-Positions(i,:));  % Eq.(4)
                else
                    NewPosition = Positions(i,:) + rand(VarSize).*((1-t/T).*Positions(i,:)...
                        +(t/T).*Positions(Teacher,:)-Positions(i,:));  % Eq.(4)
                end
                
                Newfitness = fobj(NewPosition);
                % Comparision
                if Newfitness<fitness(i)
                    Positions(i,:) = NewPosition;
                    fitness(i)=Newfitness;
                    r_table(1,2) = 1;  % reward = 1
                    if fitness(i) < Leader_score
                        Leader_score = fitness(i);
                        Leader_pos = Positions(i,:);
                    end
                else
                    r_table(1,2) = -1;  % reward = -1
                end
                
            end
        else
            if (q_table(2,1) >= q_table(2,2))
                % Learning mode 1
                A = 1:N;
                A(i) = [];
                m = A(randi(N-1));
                Step = Positions(i,:) - Positions(m,:);
                if fitness(m) < fitness(i)
                    Step = -Step;
                end
                NewPosition = Positions(i,:) + rand(VarSize).*Step;  % Eq.(2)
                
                Newfitness = fobj(NewPosition);
                % Comparision
                if Newfitness<fitness(i)
                    Positions(i,:) = NewPosition;
                    fitness(i)=Newfitness;
                    r_table(2,1) = 1;  % reward = 1
                    if fitness(i) < Leader_score
                        Leader_score = fitness(i);
                        Leader_pos = Positions(i,:);
                    end
                else
                    r_table(2,1) = -1;  % reward = -1
                end
            else
                % Learning mode 2
                A = 1:N;
                A(i) = [];
                m = A(randi(N-1));
                
                if fitness(m) < fitness(i)
                    NewPosition = Positions(i,:) + rand(VarSize).*((1-t/T).*Positions(m,:)...
                        +(t/T).*Positions(Teacher,:)-Positions(i,:));  % Eq.(4)
                else
                    NewPosition = Positions(i,:) + rand(VarSize).*((1-t/T).*Positions(i,:)...
                        +(t/T).*Positions(Teacher,:)-Positions(i,:));  % Eq.(4)
                end
                
                Newfitness = fobj(NewPosition);
                % Comparision
                if Newfitness<fitness(i)
                    Positions(i,:) = NewPosition;
                    fitness(i)=Newfitness;
                    r_table(2,2) = 1;  % reward = 1
                    if fitness(i) < Leader_score
                        Leader_score = fitness(i);
                        Leader_pos = Positions(i,:);
                    end
                else
                    r_table(2,2) = -1;  % reward = -1
                end
            end
        end
        q_table = update_q_table(q_table, r_table, lbd, sgm);        
        % ROBL strategy
        Positions_ROBL(i,:) = lb+ub-rand*Positions(i,:);
        if fobj(Positions_ROBL(i,:)) < fobj(Positions(i,:))
            Positions(i,:) = Positions_ROBL(i,:);
        end

    end
    
    t=t+1;
    %Update the convergence curve
    Convergence_curve(t)=Leader_score;
end


