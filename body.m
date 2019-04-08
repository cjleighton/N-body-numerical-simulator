classdef body
    properties
        radius; % Radius property
        mass; % Mass property
        position; % Current position
        new_position; % Position to update particle with
        velocity; % Current velocity
        period; % Orbital period
        acceleration; % Current acceleration experienced by particle
        past; % matrix of past positions. the first row is x, the second row is y, the third row is y
        % accordingly, a column has the x, y, and z coordinates at one moment in time
        prev_position; % the previous location of the particle as used in the stormer-verlet method
    end
end