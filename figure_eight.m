function [bodies,G,delta_t,sim_timespan] = figure_eight()
    % 3-body initial conditions
    delta_t=0.01; % Time step
    sim_timespan=20; % Time to run simulation for (seconds)
    G=1; %Change G to G=1 for this situation
    axis([-1.5 1.5 -1 1]); %Change axes for this situation
    a=body;
    a.radius=0.05;
    a.mass=1;
    a.position=[-0.97000436 0.24308753];
    a.velocity=-0.5.*[0.93240737 0.86473146];
    a.acceleration=[0 0];
    
    b=body;
    b.radius=0.05;
    b.mass=1;
    b.position=-a.position;
    b.velocity=a.velocity;
    b.acceleration=[0 0];
    
    c=body;
    c.radius=0.05;
    c.mass=1;
    c.position=[0 0];
    c.velocity=-2.*a.velocity;
    c.acceleration=[0 0];
    bodies=[a b c]; % Array of bodies