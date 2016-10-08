# Terrible N-body_numerical_simulator

This is a very rough N-body simulator I've been working on in MATLAB.  It doesn't require any special libraries, and the most exotic thing it uses is the plot() function.

New particles can be added by creating a new object of type 'body' at the top of grav_n_body.m, and it must also be given all of the attributes listed in body.m (such as mass, radius, position, etc).

## To-do

- Add collision detection.  I'll do this by giving one of the impactors the combined velocity and mass of both impactors, and by then deleting the other impactor.  The first part should be easy, the second part a bit harder.  I need to remove the seocond impator from the 'bodies' array, shift the rest of the 'bodies' left, delete the last empty slod in 'bodies', and figure out how all this will _impact_ acceleration calculations.
- Make a quicker way to set initial conditions.  MATLAB doesn't have any way to set up a GUI, does it?
- Extend simulation to 3-dimensions.  This will take some thought, considering the angles that will need to be calculated.
- Maybe rewrite in Python?
- Increase efficiency to the extent that I can simulate the entire universe
- Solve world hunger
- Be the firts person to walk on Mars
