function [bodies,G,delta_t,sim_timespan] = random_particles()
    %% n-body initial conditions
    delta_t=0.01; % Time step
    sim_timespan=30; % Time to run simulation for (seconds)
    G=6.67e-11; % Gravitational constant
    axis([-15 15 -10 10]); % Dimensions of system
    bodies=[];
    for i=1:2
        new_body=body;
        new_body.radius=0.2;
        new_body.mass=1e12;
        new_body.position=[randi([-10 10],1,1) randi([-10 10],1,1)]; % Random position
        new_body.velocity=[randi([-0 0],1,1) randi([-0 0],1,1)]; % Random velocity
        new_body.acceleration=[0 0];
        bodies=[bodies new_body]; % Array of bodies
    end
end