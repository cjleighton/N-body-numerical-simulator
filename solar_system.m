% This function generates the celestial bodies to be simulated.

function [bodies] = solar_system()
    G=6.674e-11; % Gravitational constant
    
    % Transformation from perifocal to cartesian. O=RAAN, o=AoP, i=inclination (all deg)
    Q= @(O,o,i) [-sind(O)*cosd(i)*sind(o)+cosd(O)*cosd(o) -sind(O)*cosd(i)*cosd(o)-cosd(O)*sind(o) sind(O)*sind(i);
                cosd(O)*cosd(i)*sind(o)+sind(O)*cosd(o) cosd(O)*cosd(i)*cosd(o)-sind(O)*sind(o) -cosd(O)*sind(i);
                sind(i)*sind(o) sind(i)*cosd(o) cosd(i)];
    
    %% Sun
    star=body;
    star.radius=6.957e8;
    star.mass=1.988e30;
    star.position=[0 0 0];
    star.velocity=[0 0 0];
    star.acceleration=[0 0 0];
    star.prev_position=star.position;
    
    mu=G*star.mass; % standard gravitational parameter of the sun
    %% Mercury
    h_me=2.713e15; % specific angular momentum, m^2/s
    e_me=0.20563069; % eccentricity
    O_me=48.33167; % RAAN, degrees
    o_me=77.45645; % AoP, degrees
    i_me=7.00487; % inclination, degrees
    theta_me=0; % initial true anomaly, degrees
    % equations (4.45), (4.46)
    r_me_peri=(h_me^2)/(mu*(1+e_me*cosd(theta_me)))*[cosd(theta_me); sind(theta_me); 0]; % perifocal location
    v_me_peri=(mu/h_me)*[-sind(theta_me); e_me+cosd(theta_me); 0];
    mercury=body;
    mercury.radius=2.4397e6;
    mercury.mass=3.3011e23;
    mercury.position=(Q(O_me,o_me,i_me)*r_me_peri)';
    mercury.velocity=(Q(O_me,o_me,i_me)*v_me_peri)';
    mercury.acceleration=[0 0 0];
    mercury.past=[];
    mercury.period=2*pi*sqrt((5.7909e10)^3/mu);
    mercury.prev_position=mercury.position;
    
    %% Venus
    h_ve=3.789e15; % specific angular momentum, m^2/s
    e_ve=0.00677323; % eccentricity
    O_ve=76.68069; % RAAN, degrees
    o_ve=131.53298; % AoP, degrees
    i_ve=3.39471; % inclination, degrees
    theta_ve=0; % initial true anomaly, degrees
    r_ve_peri=(h_ve^2)/(mu*(1+e_ve*cosd(theta_ve)))*[cosd(theta_ve); sind(theta_ve); 0]; % perifocal location
    v_ve_peri=(mu/h_ve)*[-sind(theta_ve); e_ve+cosd(theta_ve); 0];
    venus=body;
    venus.radius=6.0519e6;
    venus.mass=4.867e24;
    venus.position=(Q(O_ve,o_ve,i_ve)*r_ve_peri)';
    venus.velocity=(Q(O_ve,o_ve,i_ve)*v_ve_peri)';
    venus.acceleration=[0 0 0];
    venus.past=[];
    venus.period=2*pi*sqrt((1.08209e11)^3/mu);
    venus.prev_position=venus.position;
    
    %% Earth
    h_ea=4.455e15; % specific angular momentum, m^2/s
    e_ea=0.01671022; % eccentricity
    O_ea=-11.26064; % RAAN, degrees
    o_ea=102.94719; % AoP, degrees
    i_ea=0.00005; % inclination, degrees
    theta_ea=0; % initial true anomaly, degrees
    r_ea_peri=(h_ea^2)/(mu*(1+e_ea*cosd(theta_ea)))*[cosd(theta_ea); sind(theta_ea); 0]; % perifocal location
    v_ea_peri=(mu/h_ea)*[-sind(theta_ea); e_ea+cosd(theta_ea); 0];
    earth=body; % Earth
    earth.radius=6.371e6;
    earth.mass=5.972e24;
    earth.position=(Q(O_ea,o_ea,i_ea)*r_ea_peri)';
    earth.velocity=(Q(O_ea,o_ea,i_ea)*v_ea_peri)';
    earth.acceleration=[0 0 0];
    earth.past=[];
    earth.period=2*pi*sqrt((1.49598e11)^3/mu);
    earth.prev_position=earth.position;
    
    %% Mars
    h_ma=5.476e15; % specific angular momentum, m^2/s
    e_ma=0.09341233; % eccentricity
    O_ma=49.57854; % RAAN, degrees
    o_ma=336.0484; % AoP, degrees
    i_ma=1.85061; % inclination, degrees
    theta_ma=0; % initial true anomaly, degrees
    r_ma_peri=(h_ma^2)/(mu*(1+e_ma*cosd(theta_ma)))*[cosd(theta_ma); sind(theta_ma); 0]; % perifocal location
    v_ma_peri=(mu/h_ma)*[-sind(theta_ma); e_ma+cosd(theta_ma); 0];
    mars=body; % Mars
    mars.radius=3.386e6;
    mars.mass=6.417e23;
    mars.position=(Q(O_ma,o_ma,i_ma)*r_ma_peri)';
    mars.velocity=(Q(O_ma,o_ma,i_ma)*v_ma_peri)';
    mars.acceleration=[0 0 0];
    mars.past=[];
    mars.period=2*pi*sqrt((2.279366e11)^3/mu);
    mars.prev_position=mars.position;
    
    %% Jupiter
    h_ju=1.015e16; % specific angular momentum, m^2/s
    e_ju=0.04839266; % eccentricity
    O_ju=100.55615; % RAAN, degrees
    o_ju=14.75385; % AoP, degrees
    i_ju=1.30530; % inclination, degrees
    theta_ju=0; % initial true anomaly, degrees
    r_ju_peri=(h_ju^2)/(mu*(1+e_ju*cosd(theta_ju)))*[cosd(theta_ju); sind(theta_ju); 0]; % perifocal location
    v_ju_peri=(mu/h_ju)*[-sind(theta_ju); e_ju+cosd(theta_ju); 0];
    jupiter=body; % Jupiter
    jupiter.radius=6.99e7;
    jupiter.mass=1.9e27;
    jupiter.position=(Q(O_ju,o_ju,i_ju)*r_ju_peri)';
    jupiter.velocity=(Q(O_ju,o_ju,i_ju)*v_ju_peri)';
    jupiter.acceleration=[0 0 0];
    jupiter.past=[];
    jupiter.period=2*pi*sqrt((7.78412027e11)^3/mu);
    jupiter.prev_position=jupiter.position;
    
    bodies=[star mercury venus earth mars jupiter]; % Set up planets
    
    %% Asteroids (to be rewritten)
%     peak_gen=100; % The region over which the most asteroids are generated will contain this many asteroids
%     for r_min=2e11:0.5e11:11e11 % r_min now represents the minimum range for random generation
%         for j=1:1:uint8(peak_gen*exp(-(0.000000000005*r_min-2.6)^2)) % The distribution of asteroid density as a function of r
%             % -1.7 (above) represents half of the peak (i.e. -1.7 corresponods to a peak density at 3.4e11 meters)
%             new_body=body;
%             new_body.radius=5e5;
%             new_body.mass=5e19;
%             theta=randi([0 360],1,1); % Random angle to place body along
%             d_mag=randi([(r_min)*100 (r_min+0.5e11)*100],1,1)/100; % Distance range along which body can be placed
%             new_body.position=[d_mag*cosd(theta) d_mag*sind(theta) randi([-2e10 2e10],1,1)]; % Place body
%             v_rand=randi([-1000 1000],1,1); % Potential random variations in velocity
%             v_x=sqrt(G*star.mass/d_mag)*cosd(theta+90)+v_rand; % Set circular velocity
%             v_y=sqrt(G*star.mass/d_mag)*sind(theta+90)+v_rand; % Set circular velocity
%             v_z=randi([-1e3 1e3],1,1); % Set circular velocity
%             new_body.velocity=[v_x v_y v_z];
%             new_body.past=[];
%             new_body.acceleration=[0 0 0];
%             new_body.prev_position=new_body.position;
%             jupiter.period=2*pi*sqrt((d_mag)^3/mu);
%             bodies=[bodies new_body];
%         end
%     end

    %% Asteroids (constant density)
        %for j=1:1:100 % generate 1000 asteroids
        for j=2*1.496e11:4e9:5*1.496e11
            new_body=body;
            new_body.radius=5e5;
            new_body.mass=5e19;
            theta=randi([0 360],1,1); % Random angle to place body along
            %d_mag=randi([2*1.496e11 3.5*1.496e11],1,1); % place asteroids between 2 and 3.5 AU
            d_mag=j;
            new_body.position=[d_mag*cosd(theta) d_mag*sind(theta) randi([-1e10 1e10],1,1)]; % Place body
            v_rand=randi([-1000 1000],1,1); % Potential random variations in velocity
            v_x=sqrt(G*star.mass/d_mag)*cosd(theta+90)+v_rand; % Set circular velocity
            v_y=sqrt(G*star.mass/d_mag)*sind(theta+90)+v_rand; % Set circular velocity
            v_z=randi([-1e3 1e3],1,1); % Set circular velocity
            new_body.velocity=[v_x v_y v_z];
            new_body.past=[];
            new_body.acceleration=[0 0 0];
            new_body.prev_position=new_body.position;
            new_body.period=2*pi*sqrt((d_mag)^3/mu);
            %% comment next line to disable asteroid generation
            %bodies=[bodies new_body];
        end

    custom=body; % Spacecraft
    custom.radius=6e7;
    custom.mass=1000;
    %custom.position=input('Enter position as [x y z]: ');
    custom.position=[1.425e11 -1.533e11 -2.732e9];
    %custom.velocity=input('Enter velocity as [x y z]: ');
    custom.velocity=[20.7094e3 11.4453e3 1.9682e3];
    custom.acceleration=[0 0 0];
    custom.past=[];
    custom.period=bodies(3).period; % just set to earth's period initially
    custom.prev_position=custom.position;
    bodies=[bodies custom];
end