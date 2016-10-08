function [] = circle(bodies,t)
    hold on;
    th = 0:pi/50:2*pi;
    for i=1:length(bodies)
        xunit=bodies(i).radius*cos(th)+bodies(i).position(1);
        yunit=bodies(i).radius*sin(th)+bodies(i).position(2);
        plot(xunit,yunit);
    end
%     [x,y,z]=sphere; % Generate a sphere
%     for i=1:length(bodies)
%         x_pos=bodies(i).position(1);
%         y_pos=bodies(i).position(2);
%         surf(x*bodies(i).radius+x_pos,y*bodies(i).radius+y_pos,z*bodies(i).radius); % Plot the sphere
%     end
    
    title(['Time (s): ' num2str(t)]); % Display elapsed time
    
    pause(0.00001); % Required for plot() to briefly display current system
    cla; % Disable this to display past trajectories
end