%%% Using L-V model to simulate comptetion in species
%%% With temperature and moisture influence 
clc
clear
load("temp_attr.mat");                      % load temp's attributes
load("mois_attr.mat");                      % load mois's attributes
load("moisture_tolerance_data.mat");        % load moisture tolerance data
participated_species = [1:34];              % all participated species
scaled_mt = table2array(mtdata(:,3));       % scaled moisture tolerance ability
hyphal_extention_rate = table2array(mtdata(:,4));   % Vg for each specy
k1 = 0.015;                                 % Const impact factor
k2 = 1;                                     % Const impact factor 
L0 = 1;                                     % Initial length value
S = 100;                                    % Theoritical length upper limit
T = 10;                                     % Given temperature condition    
H = -1.0;                                   % Given water potential condition    
time_line = 0:0.1:100;                    % Timeline
Ve = 0.58;                                  % Enzyme decomposition efficient const
Vs = 0.1;                                   % Enzyme secretion efficient const
L_species = ones(34, length(time_line(:))) * L0;
V_species = ones(34, length(time_line(:))) * L0 * Ve * Vs;

compete_ability = repmat(scaled_mt', 34, 1);

c = colormap(summer());

index = 0;
for t = time_line(2:end)
    old_L = L_species;
    index = index + 1;
    for specy = participated_species
        sigma = 0;
        for competed_specy = participated_species
            if  competed_specy == specy
                sigma = sigma + old_L(competed_specy, index);
            else
                sigma = sigma + k2 * compete_ability(specy, competed_specy) * old_L(competed_specy, index);
            end
        end    
        
        % calculate dL
        at = grow_temp_attr_result(specy, 1);
        bt = grow_temp_attr_result(specy, 2);
        ct = grow_temp_attr_result(specy, 3);
        ah = grow_mois_attr_result(specy, 1);
        bh = grow_mois_attr_result(specy, 2);
        ch = grow_mois_attr_result(specy, 3);
        T0 = 22;                                % Lab condition temperature
        H0 = -0.5;                              % Lab condition water potential(MPa)
        Ft0 = at * exp(-(((T0 - bt) / ct)^2));
        Fh0 = ah * exp(-(((H0 - bh) / ch)^2));
        Ft = at * exp(-(((T - bt) / ct)^2));
        Fh = ah * exp(-(((H - bh) / ch)^2));
        k3 = k1 / Ft0 / Fh0;
        dL = k3 * hyphal_extention_rate(specy) * old_L(specy, index) * (1 - sigma / S) * Ft * Fh;
        L_species(specy, index+1) = old_L(specy, index) + dL * 0.1;
        V_species(specy, index+1) = L_species(specy, index+1) * Ve * Vs;
    end
end    

for specy = participated_species
   plot(time_line, L_species(specy,:), 'lineWidth', 1.5, 'color', c(floor(specy*1.88),:));
   hold on
end
xlabel('Time(day)', 'FontSize', 14, 'Fontname', "times")
ylabel('Length(mm)', 'FontSize', 14, 'Fontname', "times")

hold off
for specy = participated_species
   plot(time_line, V_species(specy,:), 'lineWidth', 1.5, 'color', c(floor(specy*1.88),:));
   hold on;
end
xlabel('Time(day)', 'FontSize', 14, 'Fontname', "times")
ylabel('Decomposition speed(mg/day)', 'FontSize', 14, 'Fontname', "times")
    
hold off
sum = zeros(1, length(time_line(:)));
for index = 1:length(time_line(:))
    for specy = participated_species
       sum(1,index) = sum(1,index) + L_species(specy, index);
    end    
end
plot(time_line, sum, 'Color', 'k', 'lineWidth', 1.5);
hold on;
xlabel('Time(day)', 'FontSize', 14, 'Fontname', "times")
ylabel('Total length(mm)', 'FontSize', 14, 'Fontname', "times")
S_arr = ones(1, length(time_line(:))) * S;
plot(time_line, S_arr, '--', 'lineWidth', 1.5);