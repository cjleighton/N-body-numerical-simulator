function [] = circle(bodies,t)
    hold on;
    th = 0:pi/50:2*pi;
    for i=1:length(bodies)
        xunit=bodies(i).radius*cos(th)+bodies(i).position(1);
        yunit=bodies(i).radius*sin(th)+bodies(i).position(2);
        plot(xunit,yunit);
    end
    axis([-15 15 -15 15]); % Dimensions of system
    title(['Time (s): ' num2str(t)]); % Display elapsed time
    
    pause(0.00001); % Required for plot() to briefly display current system
    %clf('reset'); % Re-enable this to display past trajectories
end