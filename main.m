figure('units','normalized','position',[0 0.02 0.55 1]); % Create a figure to plot the system on
view([1 -1 1]); % Viewing angle
axis([-8.2e11 8.2e11 -8.2e11 8.2e11 -8.2e11 8.2e11]);

[bodies]=solar_system(); % Star system scenario
% In order to accelerate the simulation, we can exclude the influence of
% small bodies on large bodies, e.g. ignore the pull of asteroids on
% planets and only consider how planets and the Sun influence asteroids
massive_index=1:6; % bodies(1:massive_index) have significant mass:

t=0; % Initial time
delta_t=3*86400; % Time step, seconds
sim_timespan=1*bodies(6).period; % period of jupiter, sec
G=6.67e-11; % Gravitational constant

animation=VideoWriter('animation.avi'); % Set an output video to write to
open(animation);

while t<sim_timespan
    semimaj_vec=[]; % store semimajor axes of bodies at time t
    for i=1:length(bodies) % Look at i-th body
        acc_vec=[]; % store all of the accelerations acting on body i
        bodies(i).past=[bodies(i).position(:) bodies(i).past]; % most recent positions FIRST in matrices
        if length(bodies(i).past)==uint32(0.95*bodies(i).period/delta_t)
            bodies(i).past(:,uint32(0.95*bodies(i).period/delta_t))=[];
        end
        %% calculate accelerations, velocities, and positions
        for j=massive_index
            if i ~= j % Exclude body i; nonsensical to find forces between body and itself
                %% Calculate relationship between positions of bodies i and j
                d=bodies(i).position(:)-bodies(j).position(:); % x, y, z components of distance between particles
                d_mag=norm(d); % magnitude of distance
                %% Calculate accelerations body i experiences toward body j
                i2j_acc=-G*bodies(j).mass*d/d_mag^3; % x, y, z components of acceleration
                %% Create vector of all forces acting on body i from all other particles, from j=1:length(bodies)
                acc_vec=[acc_vec i2j_acc];
            end
        end
        %% Sum the vectors to find the total acceleration body i experiences in the X and Y
        bodies(i).acceleration=[sum(acc_vec(1)) sum(acc_vec(2)) sum(acc_vec(3))]; % Vector form; accelerations in X and Y directions
        %% Calculate new velocities and positions: Stormer-Verlet method
        if t==0 bodies(i).new_position=bodies(i).position+bodies(i).velocity*delta_t+0.5*bodies(i).acceleration*(delta_t^2);
        else bodies(i).new_position=2*bodies(i).position-bodies(i).prev_position+bodies(i).acceleration*(delta_t^2);
        end
        %% The next chunk is just for semimajor axis analysis
        velocity_i=(bodies(i).position-bodies(i).prev_position)/delta_t;
        semimaj=-G*bodies(1).mass/(2*(norm(velocity_i)^2/2-G*bodies(1).mass/norm(bodies(i).position)));
        semimaj_vec=[semimaj_vec semimaj];
        bodies(i).period=2*pi*sqrt(semimaj^3/(G*bodies(1).mass));
        %% Save the previous location so it can be reused in integrating the next location
        bodies(i).prev_position=bodies(i).position; % save the .prev_location before updating .position
    end
    %% Update the positions of all particles
    for k=2:length(bodies) % start at 2: don't move the sun
        bodies(k).position=bodies(k).new_position;
    end
    %% Standard orbit plotting
    circle(bodies,t,animation,delta_t,sim_timespan,massive_index); % Plot the system
    %% Alternatively: Semimajor axis analysis and plotting
    %a_mat=semimajor_analysis(animation,semimaj_vec,t);
    %% Increment time forward
    t=t+delta_t; % Time step
    if mod(t,delta_t*10)==0 % Display a timestamp every ten delta_ts
        disp(['time: ' num2str(t/86400) ' days']);
    end
end
close(animation);