% Parameters
beta = 10; beta_fc = 4; gamma = 6; omega = 5; kappa = 5;
C_SD = 10; C_I = 10; C_FC = 3;

% Initial conditions [S, I, R, SD]
Y0 = [0.99, 0.01, 0, 0.8]; % Initial population distribution

% Time span
tspan = [0 40]; % From day 0 to day 100

% Solve the ODE
[t, Y] = ode45(@(t,Y) SIR_SD_FC(t, Y, beta, beta_fc, gamma, omega, kappa, C_SD, C_I, C_FC), tspan, Y0);

% Colors
rose = [0.961, 0.51, 0.933];
lightBlue = [0.298, 0.69, 0.961];
purple = [0.58, 0.298, 0.961];
pastelGreen = [0.298, 0.961, 0.851];


% Plot the results
figure;
hold on;
plot(t, Y(:,1), 'Color', rose, 'LineWidth', 4);
plot(t, Y(:,2), 'Color', lightBlue, 'LineStyle', '-','LineWidth', 4);
plot(t, Y(:,3), 'Color', purple, 'LineStyle', ':','LineWidth', 4);
plot(t, (1-Y(:,3)-Y(:,4)), 'Color', pastelGreen, 'LineStyle', '--', 'LineWidth', 4);
yline(-1/beta*log(1-C_SD/C_I),'--r','LineWidth',3)
yline(-1/beta_fc*log(1-(C_SD-C_FC)/C_I),'--g','LineWidth',3)
if roots_1 > 0
    yline(roots_1,'-.b','LineWidth',3)
end

hold off;

legend('Susceptible', 'Infected', 'Social Distancing', 'Face Covering');
xlabel('Time');
ylabel('Population Fraction');
%title('SIR Model with Social Distancing and Face Covering');
set(gca,'Fontsize',20)

display(1-Y(end,1)-Y(end,2))
