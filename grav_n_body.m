G=6.67e-11; % Gravitational constant
figure; % Create a figure to plot the system on
zlim([-10 10]);
axis([-15 15 -10 10]); % Dimensions of system

%% 3-body initial conditions
G=1; %Change G to G=1 for this situation
axis([-1.5 1.5 -1 1]); %Change axes for this situation
a=body;
a.radius=0.1;
a.mass=1;
a.position=[-0.97000436 0.24308753];
a.velocity=-0.5.*[0.93240737 0.86473146];
b=body;
b.radius=0.1;
b.mass=1;
b.position=-a.position;
b.velocity=a.velocity;
c=body;
c.radius=0.1;
c.mass=1;
c.position=[0 0];
c.velocity=-2.*a.velocity;
bodies=[a b c]; % Array of bodies

%% n-body initial conditions
% bodies=[];
% for i=1:10
%     new_body=body;
%     new_body.radius=0.2; % Default radius
%     new_body.mass=1*10^11; % Default mass
%     new_body.position=[randi([-10 10],1,1) randi([-10 10],1,1)]; % Random position
%     new_body.velocity=[randi([-0 0],1,1) randi([-2 2],1,1)]; % Random velocity
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
                
                if d_mag<(bodies(i).radius+bodies(j).radius)
                    %Collision detected
                end
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