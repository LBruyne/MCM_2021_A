clear
clc
%%% Different fungi's hyphal-length extention model
%%% Based on each fungi's Vg examined in lab condition.
load("decomp_grow_data_22.mat");
L0 = 1;                 % Initial length value
S = 100;                % Theoritical length upper limit
Vg = decomp_grow_data(:,1)';            
                        % Different growth rate for each kind of fungi in
                        % 22¡æ lab condition
decomp_rate_lab = decomp_grow_data(:,2)';
                        % Real decomposition rate for each kind of fungi in
                        % 22¡æ lab condition
k1 = 0.015;             % Const impact factor
Ve = 0.58;         % Enzyme decomposition efficient const
Vs = 0.1;         % Enzyme secretion efficient const

c = colormap(summer());

decomp_rate_model = [];
species_num = 0;
for V = Vg
    t = 0:0.1:122;                                  % Timeline
    molecule = S * L0 * exp(k1 * V * t);            % Equation molecule
    denominator = S - L0 + L0 * exp(k1 * V * t);    % Equation denominator
    L = molecule ./ denominator;                    % Length
    Vd = L * Ve * Vs;                               % Decomposition speed
    M0 = 675;                                       % In the lab, wood blocks weigh 675mg
    M1 = 0;
    for i = 1:length(t)
        M1 = M1 + Vd(i) * 0.1;       % Simulate a definite-integral to calculate the decomposed volume
    end    
    decomp_rate_model = [decomp_rate_model, M1 / M0 * 100];
    species_num = species_num + 1;
    plot(t, Vd, 'lineWidth', 1.5, 'color', c(floor(species_num*1.88),:));
    xlabel('Time(day)', 'FontSize', 14, 'Fontname', "times")
    ylabel('Decomposition speed(mg/day)', 'FontSize', 14, 'Fontname', "times")
    hold on;
end
