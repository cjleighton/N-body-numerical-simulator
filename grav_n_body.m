figure('units','normalized','position',[0 0.02 0.55 1]); % Create a figure to plot the system on

%[bodies,G,delta_t,sim_timespan]=figure_eight(); % Figure eight scenario
%[bodies,G,delta_t,sim_timespan]=random_particles(); % Randomized particles scenario
[bodies,G,delta_t,sim_timespan]=solar_system(); % Star system scenario

t=0; % Initial time
animation=VideoWriter('animation.avi'); % Set an output video to write to
open(animation);

while t<sim_timespan
    for i=1:1:length(bodies) % Look at i-th body
        acc_x_vec=[]; % Every body i has different accelerations acting on it
        acc_y_vec=[]; % Thus, we must clear it every time we look at a different body i
        for j=1:length(bodies) % Look at forces that body i feels from body j
            if (i ~= j & bodies(j).position(1)<(10^99)) % Exclude body i; nonsensical to find forces between body and itself
                %% Calculate relationship between positions of bodies i and j
                d_x=abs((bodies(j).position(1)-bodies(i).position(1)));
                d_y=abs((bodies(j).position(2)-bodies(i).position(2)));
                d_mag=sqrt(d_x^2+d_y^2); % Magnitude of distance
                theta=atan(d_y/d_x); % Angle between i and j
                %% Check for collisions
                if d_mag<((bodies(i).radius+bodies(j).radius)) % A collision has ocurred between particles i and j
                    % I should probably calculate the combined particle's
                    % acceleration as a function of the accelerations
                    % acting on the two constituent bodies, but that will
                    % take some thought and restructuring.
                    bodies(i).velocity=(bodies(i).mass.*bodies(i).velocity+bodies(j).mass.*bodies(j).velocity)./(bodies(i).mass+bodies(j).mass); % Calculate combined body's velocity
                    bodies(i).position=(bodies(i).mass.*bodies(i).position+bodies(j).mass.*bodies(j).position)./(bodies(i).mass+bodies(j).mass); % Calculate combined body's position
                    bodies(i).mass=bodies(i).mass+bodies(j).mass; % Calculate combined body's mass
                    bodies(i).radius=(bodies(i).radius^3+bodies(j).radius^3)^(1/3); % Calculate combined body's radius
                    % The commented section doesn't work, but should be the
                    % basis for cleanly removing particle j from the bodies
                    % array (rather than just moving particle j far, far
                    % away as I do on the 3 lines following the commented
                    % section.
%                     for k=j:1:length(bodies)-1;
%                         bodies(k)=bodies(k+1);
%                     end
%                     bodies(length(bodies))=[];
                    bodies(j).position=[10^99 10^99]; % Crudely move body j very, ver far away
                    bodies(j).velocity=[100 100]; % Set it to move away from the system
                    bodies(j).mass=0; % Set its mass to zero
                else % There's no collision between i and j; proceed to calculate acceleration between particles i and j
                    %% Calculate accelerations body i experiences toward body j
                    a_abs=(G*bodies(j).mass)/(d_mag^2); % Magnitude of acceleration i feels toward j
                    i2j_acc_x=(a_abs*cos(theta)); % Acceleration in X direction
                    i2j_acc_y=(a_abs*sin(theta)); % Acceleration in Y direction
                    %% Fix signs
                    % There's likely a better solution to this. Will investigate.
                    if bodies(i).position(1)>bodies(j).position(1)
                        i2j_acc_x=-i2j_acc_x;
                    end
                    if bodies(i).position(2)>bodies(j).position(2)
                        i2j_acc_y=-i2j_acc_y;
                    end
                    %% Create vector of all forces acting on body i from all other particles, from j=1:length(bodies)
                    acc_x_vec=[acc_x_vec i2j_acc_x];
                    acc_y_vec=[acc_y_vec i2j_acc_y];
                end
            end
        end
        % We're in the root level of the i for loop
        %% Sum the vectors to find the total acceleration body i experiences in the X and Y
        bodies(i).acceleration=[sum(acc_x_vec) sum(acc_y_vec)]; % Vector form; accelerations in X and Y directions
        %% Calculate new velocities and positions
        bodies(i).velocity=(bodies(i).acceleration.*delta_t)+bodies(i).velocity; % Calculate the new velocity of body i
        bodies(i).new_position=(bodies(i).velocity.*delta_t)+bodies(i).position; % Calculate the new position; don't update .position yet
    end
    %% Update the positions of all particles
    % We can only do this after calculating the forces on every particle.
    % Actually updating the position of particle A while we're still
    % calculating forces causes the forces that are found to be acting on
    % all subsequent particles to be wrong, since particle A has been
    % moved. Within a single timestamp, particles shouldn't be moved; Only
    % when we change the timestamp should they actually be moved, and then
    % they should all be moved at once.
    for k=1:length(bodies)
        bodies(k).position=bodies(k).new_position;
    end
    circle(bodies,t,animation); % Plot the system
    t=t+delta_t; % Time step
end
close(animation);