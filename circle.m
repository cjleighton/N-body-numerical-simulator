function [] = circle(bodies,t,animation)
    hold on;
    th = 0:pi/50:2*pi;
    for i=1:length(bodies)
        xunit=bodies(i).radius*cos(th)+bodies(i).position(1);
        yunit=bodies(i).radius*sin(th)+bodies(i).position(2);
        plot(xunit,yunit);
    end

    title(['Time: ' num2str(t) ' seconds = ' num2str(t/86400) ' days = ' num2str(t/(86400*365.25)) ' years']); % Display elapsed time
    writeVideo(animation, getframe);
    %pause(0.00001); % Required for plot() to briefly display current system
    cla; % Disable this to display past trajectories
end