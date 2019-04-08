% This function is an alternative to circle.m. It plots the semimajor axes
% of simulated solar system bodies. In real-life, the asteroid density
% falls off near the integer orbital resonances of Jupiter and I wanted to
% see if I could replicate those results (the simulation is too slow for
% that behavior to emerge, though)

function [a_mat] = semimajor_analysis(animation,a_vec,t) % a_vec is a vector of semimajor axes of asteroids
    a_vec_planet=a_vec(2:6)/(1.496e9); % semimaj axes of planets
    a_vec=a_vec(7:length(a_vec)); % semimaj axes of asteroids
    a_vec=floor(a_vec/(1.496e9)); % convert and round to nearest whole centi-AU 
    %% Discretize semimajor axes into bins
    a_mat=zeros(2,701); % first row: counter. second row: centi-AU
    a_mat(2,:)=linspace(0,700,701);
    for i=1:length(a_vec) % look through a_vec
        for j=1:length(a_mat) % when a match in a_mat is found, increment a_mat
            if a_vec(i)==a_mat(2,j)
                a_mat(1,j)=a_mat(1,j)+1;
            end
        end
    end
    hold on;
    bar(a_mat(2,:),a_mat(1,:)); % plot asteroid density
    plot(a_vec_planet,ones(length(a_vec_planet)),'o','Color','red'); % plot planets
    xlabel('centi-AU'); ylabel('Asteroids per 0.01 AU bin'); title(['Time: ' num2str(t/(86400*365.25)) ' years']);
    %pause(0.000000001);
    writeVideo(animation, getframe(gcf));
    clf('reset');
    %xlim([150 350]);
end