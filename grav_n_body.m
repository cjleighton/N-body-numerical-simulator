r=0.1; % universal radius
G=6.67*10^(-1); % gravitational constant
%figure('units','normalized','outerposition',[0 0 1 1])
figure;

a=body;
a.mass=100;
a.position=[-6 0];
a.velocity=[0 8];

b=body;
b.mass=5000;
b.position=[2 0];
b.velocity=[0 -0.8];
bodies=[a b]; % list of 'body' objects

% randomizer
% bodies=[];
% for i=1:10
%     Int=randi([-10 10],1,1);
%     a=body;
%     a.mass=randi([500 1000],1,1);
%     a.position=[randi([-20 20],1,1) randi([-20 20],1,1)];
%     a.velocity=[randi([-3 3],1,1) randi([-3 3],1,1)];
%     %a.velocity=[0 0];
%     a.acceleration=[0 0];
%     bodies=[bodies a];
% end

delta_t=0.01; % time step
t=0; % initial time
%i2j_acc_x=0;
%i2j_acc_y=0;

while 1
    for i=1:length(bodies) % NUM OF BODIES
        acc_x_vec=[]; % for each new i-th body, we must clear our vector of X accelerations
        acc_y_vec=[];
        for j=1:length(bodies)
            if i ~= j % we don't want to find the (seemingly infinite) force between a particle and itself
                %% calculate two vectors, one for X and one for Y, of forces
                %% acting on particle i from each particle j
                %% calculate distances and angles between i and j
                d_x=(bodies(j).position(1)-bodies(i).position(1));
                d_y=(bodies(j).position(2)-bodies(i).position(2));
                d_mag=sqrt(d_x^2+d_y^2);
                theta=atan(d_y/d_x); % angle formed by i and j positions
                %% fix signs
                if bodies(i).position(1)>bodies(j).position(1)
                    theta=-theta;
                end
                if bodies(i).position(2)>bodies(j).position(2)
                    theta=-theta;
                end
                %% calculate the accelerations in X and Y from object i to j
                a_abs=(G*bodies(j).mass)/(d_mag^2); % magnitude of acc vector from i to j
                i2j_acc_x=a_abs*cos(theta);
                i2j_acc_y=a_abs*sin(theta);
                %% fix signs
                if bodies(i).position(1)>bodies(j).position(1) % FIX SIGNS
                    i2j_acc_x=-i2j_acc_x;
                end
                if bodies(i).position(2)>bodies(j).position(2)
                    i2j_acc_y=-i2j_acc_y;
                end
                %% add calculated force to appropriate vector
                acc_x_vec=[acc_x_vec i2j_acc_x];
                acc_y_vec=[acc_y_vec i2j_acc_y];
            end
        end
        %% for current particle i, sum up X and Y forces acting
        %% on it by all particles j=1:length(bodies). that's the net acceleration
        bodies(i).acceleration(1)=sum(acc_x_vec);
        bodies(i).acceleration(2)=sum(acc_y_vec);
        %% calculate new velocity and position
        bodies(i).velocity=(bodies(i).acceleration.*delta_t)+bodies(i).velocity;
        bodies(i).position=(bodies(i).velocity.*delta_t)+bodies(i).position; % CALCULATE NEW POSITION FOR PARTICLE i BASED ON ACCELERATIONS FOUND
    end
    circle(bodies,r,t);%,bodies(3).position(1),bodies(3).position(2),r); % PLOT THE SYSTEM
    t=t+delta_t;
end