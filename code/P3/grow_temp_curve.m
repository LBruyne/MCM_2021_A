%%% obtain the attributes of grow_rate-temperature curve
clear;
clc;
load("grow_temperature_data.mat");  % read data
[r,c] = size(temperature_data);     
cur_specy = "";
grow_temp_attr_result = ones(34,3);
species_num = 0;

c = colormap(summer());
for i = 1:r       
    if cur_specy ~= table2array(temperature_data(i,1))
        if i ~= 1
            species_num = species_num + 1;
            plot(x, y, 'lineWidth', 1.5, 'DisplayName', cur_specy, 'color', c(floor(species_num*1.88),:));
            xlabel('Temperature(��)', 'FontSize', 14, 'Fontname', "times")
            ylabel('Hyphal extention rate(mm/day)', 'FontSize', 14, 'Fontname', "times")
            legend;
            hold on
            % fit using gaussian distribution
            f = fit( x, y, 'gauss1');
            grow_temp_attr_result(species_num, 1) = f.a1;
            grow_temp_attr_result(species_num, 2) = f.b1;
            grow_temp_attr_result(species_num, 3) = f.c1;
        end
        cur_specy = table2array(temperature_data(i,1));
        x = [];
        y = [];
    end
    x = [x; table2array(temperature_data(i,2))];
    y = [y; table2array(temperature_data(i,3))];
    if i == r 
        species_num = species_num + 1;
        plot(x, y, 'lineWidth', 1.5, 'DisplayName', cur_specy, 'color', c(floor(species_num*1.88),:));
        xlabel('Temperature(��)', 'FontSize', 14, 'Fontname', "times")
        ylabel('Hyphal extention rate(mm/day)', 'FontSize', 14, 'Fontname', "times")
        hold on
        % fit using gaussian distribution
        f = fit( x, y, 'gauss1');
        grow_temp_attr_result(species_num, 1) = f.a1;
        grow_temp_attr_result(species_num, 2) = f.b1;
        grow_temp_attr_result(species_num, 3) = f.c1;
    end    
end
