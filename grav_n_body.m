G=6.67*10^(-11); % Gravitational constant
figure; % Create a figure to plot the system on

%% 2-body initial conditions
a=body
a.radius=0.5;
a.mass=1*10^12;
a.position=[-3 0];
a.velocity=[0 10];
b=body;
b.radius=0.5;
b.mass=1*10^13;
b.position=[2 0];
b.velocity=[0 -1];
bodies=[a b];

%% n-body initial conditions
% bodies=[];
% for i=1:10
%     new_body=body;
%     new_body.radius=0.2; % Default radius
%     new_body.mass=1*10^11; % Default mass
%     new_body.position=[randi([-10 10],1,1) randi([-10 10],1,1)]; % Random position
%     new_body.velocity=[randi([-2 2],1,1) randi([-2 2],1,1)]; % Random velocity
%     bodies=[bodies new_body]; % Array of bodies
% end

delta_t=0.01; % Time step
t=0; % Initial time

while 1
    for i=1:length(bodies) % Look at i-th body
        acc_x_vec=[]; % Every body i has different accelerations acting on it
        acc_y_vec=[]; % Thus, we must clear it every time we look at a different body i
        for j=1:length(bodies) % Look at forces that body i feels from body j
            if i ~= j % Exclude body i; nonsensical to find forces between body and itself
                %% Calculate relationship between positions of bodies i and j
                d_x=abs((bodies(j).position(1)-bodies(i).position(1)));
                d_y=abs((bodies(j).position(2)-bodies(i).position(2)));
                d_mag=sqrt(d_x^2+d_y^2); % Magnitude of distance
                theta=atan(d_y/d_x); % Angle between i and j
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
    
    circle(bodies,t); % Plot the system
    t=t+delta_t; % Time step
end