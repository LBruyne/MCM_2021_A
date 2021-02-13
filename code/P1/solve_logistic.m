%%% Hyphal-length extention model
L0 = 1;            % Initial length value
S = 100;           % Theoritical length upper limit
Vg = 1;             % Growth rate
k1 = 0.012;           % Const impact factor
t = 0:0.1:1000;      % Timeline
molecule = S * L0 * exp(k1 * Vg * t);           % Equation molecule
denominator = S - L0 + L0 * exp(k1 * Vg * t);   % Equation denominator
L=molecule ./ denominator;                      % Length

%%% Decomposition model
M1 = 0;
Ve = 0.5;         % Enzyme decomposition efficient const
Vs = 0.1;         % Enzyme secretion efficient const
M0 = ones(1, 10001) * 10000;    % Initial biomass of ground litter and woody fibers
Vd = L * Ve * Vs;               % Decomposition speed
for i = 1:10001
   M1 = M1 + Vd(i) * 0.1;       % Simulate a definite-integral to calculate the decomposed volume
   M0(1,i) = M0(1,i) - M1;      % Leftover biomass
end    

%%% Curve
[ax,h1,h2] = plotyy(t, L, t, M0(1, :));
set(get(ax(1),'Ylabel'),'string','L(t)/mm', 'linewidth', 1.1, 'fontsize', 20, 'fontname', 'times');
set(get(ax(2),'Ylabel'),'string','M(t)/mg', 'linewidth', 1.1, 'fontsize', 20, 'fontname', 'times');
set(ax(1),'ycolor','k','fontsize', 20, 'fontname', 'times');
set(ax(2),'ycolor','k','fontsize', 20, 'fontname', 'times');
set(h1,'color','k','linewidth',2);
set(h2,'color', [29, 191, 151]/255,'linewidth',2);
xlabel('time/day');