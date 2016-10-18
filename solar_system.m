function [bodies,G,delta_t,sim_timespan] = solar_system()
    %% System formation
    delta_t=1*60*60*24*1; % Time step (currently 1 day at a time)
    sim_timespan=60*60*24*(365.25*11.862615); % Time to run simulation for (number in parenthesis represents days)
    G=6.67e-11; % Gravitational constant
    lim=9e11; % Geometric limits of plotting (meters)
    axis([-lim lim -lim lim]);
    
    star=body; % Sun
    star.radius=6.957e8;
    star.mass=1.988e30;
    star.position=[0 0];
    star.velocity=[0 0];
    star.acceleration=[0 0];
    % <body>.acceleration currently unnecessary. May become necessary if I
    % reincorporate combined accelerations into collision detection
    
    mercury=body; % Mercury
    mercury.radius=2.4397e6;
    mercury.mass=3.3011e23;
    mercury.position=[6.982e10 0];
    % Mercury has a non-negligible eccentricity.
    mercury.velocity=[0 sqrt(G*star.mass*(2/mercury.position(1)-1/(5.7909e10)))];
    mercury.acceleration=[0 0];
    
    venus=body; % Venus
    venus.radius=6.0519e6;
    venus.mass=4.867e24;
    venus.position=[1.082e11 0];
    venus.velocity=[0 sqrt(G*star.mass/venus.position(1))];
    venus.acceleration=[0 0];
    
    earth=body; % Earth
    earth.radius=6.371e6;
    earth.mass=5.972e24;
    earth.position=[1.496e11 0];
    earth.velocity=[0 sqrt(G*star.mass/earth.position(1))];
    earth.acceleration=[0 0];
    
    mars=body; % Mars
    mars.radius=3.386e6;
    mars.mass=6.417e23;
    mars.position=[2.492e11 0];
    % Mars has a non-negligible eccentricity.
    mars.velocity=[0 sqrt(G*star.mass*(2/mars.position(1)-1/(2.279e11)))];
    mars.acceleration=[0 0];
    
    jupiter=body; % Jupiter
    jupiter.radius=6.99e7;
    jupiter.mass=1.9e27;
    jupiter.position=[7.784e11 0];
    jupiter.velocity=[0 sqrt(G*star.mass/jupiter.position(1))];
    jupiter.acceleration=[0 0];
    
    bodies=[star mercury venus earth mars jupiter]; % Set up planets
    
    for i=1:1:30 % Belt 1 generation (just beyond Mars)
        new_body=body;
        new_body.radius=5e5;
        new_body.mass=5e19;
        theta=randi([0 360],1,1); % Random angle to place body along
        d_mag=randi([(2.3e11)*100 (4.5e11)*100],1,1)/100; % Distance range along which body can be placed
        new_body.position=[d_mag*cosd(theta) d_mag*sind(theta)]; % Place body
        v_x=sqrt(G*star.mass/d_mag)*cosd(theta+90); % Set circular velocity
        v_y=sqrt(G*star.mass/d_mag)*sind(theta+90); % Set circular velocity
        % Consider: add/subtract small random velocity to v_x and v_y to
        % generate eccentric asteroid trajectories
        new_body.velocity=[v_x v_y];
        new_body.acceleration=[0 0];
        bodies=[bodies new_body];
    end
    for i=1:1:30 % Belt 2 generation (Surrounding Jupiter)
        new_body=body;
        new_body.radius=5e5;
        new_body.mass=5e19;
        theta=randi([0 360],1,1);
        d_mag=randi([(7.5e11)*100 (8.1e11)*100],1,1)/100; % Belt distance range
        new_body.position=[d_mag*cosd(theta) d_mag*sind(theta)];
        v_x=sqrt(G*star.mass/d_mag)*cosd(theta+90);
        v_y=sqrt(G*star.mass/d_mag)*sind(theta+90);
        new_body.velocity=[v_x v_y];
        new_body.acceleration=[0 0];
        bodies=[bodies new_body];
    end
end