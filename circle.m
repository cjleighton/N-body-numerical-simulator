% This function is generates a 3D animation of the simulation.

function [] = circle(bodies,t,animation,delta_t,sim_timespan,massive_index)
    hold on;
    [x_sphere y_sphere z_sphere] = sphere;
    plot_list=[]; % list of plot() items
    for i=1:length(bodies)
        if i<=massive_index(length(massive_index)) % Massive body
            %% Plot body
            scaler=5e7/(bodies(i).radius^0.7);
            r=bodies(i).radius*scaler;
            plot_list=[plot_list surf(x_sphere*r+bodies(i).position(1), y_sphere*r+bodies(i).position(2), z_sphere*r+bodies(i).position(3))];
            %% Plot the orbital path
            if i>1 & length(bodies(i).past(1,:))>1% skip the sun
                p_len=length(bodies(i).past(1,:));
                trail_inc=1;
                plot_list=[plot_list plot3(bodies(i).past(1,1:trail_inc:p_len), bodies(i).past(2,1:trail_inc:p_len), bodies(i).past(3,1:trail_inc:p_len),'Color',[0.2 0.2 0.2])];
            end
        else % Small body (asteroid)
            plot_list=[plot_list plot3(bodies(i).position(1),bodies(i).position(2),bodies(i).position(3),'.','Color',[0.5 0.5 0.5])];
            %% option to plot asteroid orbital paths
            p_len=length(bodies(i).past(1,:));
            plot_list=[plot_list plot3(bodies(i).past(1,1:5:p_len), bodies(i).past(2,1:5:p_len), bodies(i).past(3,1:5:p_len),'Color',[0.2 0.2 0.2])];
        end
    end
    % tracked=4; % track earth
    % axis([bodies(tracked).position(1)-8.2e11 bodies(tracked).position(1)+8.2e11 bodies(tracked).position(2)-8.2e11 bodies(tracked).position(2)+8.2e11 bodies(tracked).position(3)-8.2e11 bodies(tracked).position(3)+8.2e11]);
    grid on;
    title(['Time: ' num2str(t/86400) ' days = ' num2str(t/(86400*365.25)) ' years. \Deltat (s) = ' num2str(delta_t)]); % Display elapsed time
    % view([1 -1 asin(t/sim_timespan)/(pi/2)]);
    % pause(0.00000001);
    writeVideo(animation, getframe(gcf));
    if (t+delta_t)<sim_timespan % Don't delete the model at the end
        delete(plot_list);
    end
end