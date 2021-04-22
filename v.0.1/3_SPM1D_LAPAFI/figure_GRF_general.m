clc;clear;close all;
load('meanSD_elderly_LAPAFI.mat');
figure()
plot(meanSD_elderly_LAPAFI(5).mean_GRF_R{1, 1}, 'LineWidth',2,'Color',[0.9,0.53,0.07]);
hold on;
plot(meanSD_elderly_LAPAFI(5).mean_GRF_R{1, 2}, 'LineWidth',2,'Color',[	0.52, 0.05, 0.47]);
hold on;
plot(meanSD_elderly_LAPAFI(5).mean_GRF_R{1, 3}, 'LineWidth',2,'Color',[0.05 0.52 0.14]);
hold on;
ylabel("$\bf\frac{GRF(N)}{Weight(N)}$",'interpreter','latex')
xlabel("% Stance Phase")
