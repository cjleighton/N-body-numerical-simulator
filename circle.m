function [] = circle(bodies,t,animation)
    hold on;
    th = 0:pi/50:2*pi;
%     for i=1:length(bodies)
%         xunit=bodies(i).radius*cos(th)+bodies(i).position(1);
%         yunit=bodies(i).radius*sin(th)+bodies(i).position(2);
%         plot(xunit,yunit);
%     end

% Solar system plotting with (rough) automatic visual scaling
    for i=1:length(bodies)
        scaler=3e6/(bodies(i).radius^0.55);
        xunit=scaler*bodies(i).radius*cos(th)+bodies(i).position(1);
        yunit=scaler*bodies(i).radius*sin(th)+bodies(i).position(2);
        plot(xunit,yunit);
    end

%     [x,y,z]=sphere; % Generate a sphere
%     for i=1:length(bodies)
%         x_pos=bodies(i).position(1);
%         y_pos=bodies(i).position(2);
%         surf(x*bodies(i).radius+x_pos,y*bodies(i).radius+y_pos,z*bodies(i).radius); % Plot the sphere
%     end

    title(['Time: ' num2str(t) ' seconds = ' num2str(t/86400) ' days = ' num2str(t/(86400*365.25)) ' years']); % Display elapsed time
    writeVideo(animation, getframe);
    %pause(0.00001); % Required for plot() to briefly display current system
    cla; % Disable this to display past trajectories
end