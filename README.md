# N-body numerical simulator
## Configured to simulate the solar system
This is something I did for fun that I started working on it three or four years ago (egads) around the time of my freshman year in college and haven't done much on it in the last year and a half.
## Running the simulation
* Launch script is `main.m`, which is the actual core of the simulation
* `solar_system.m` is just a setup script that creates a column vector of the bodies to be simulated
* `body.m` is a class that defines the attributes of the bodies
* `semimajor_analysis.m` can be used to analyze the distribution of semimajor axes of the simulated bodies
* `circle.m` plots and renders the animation as a video
* Runs fine in MATLAB 2018b (probably Octave too)
## Implementation details
This uses the Stormer-Verlet integration scheme, which I chose because it's really easy to implement. At each timestep, accelerations between every body in the system are calculated and the integrator is used to step positions forward, and that's the high-level gist of it.
## [Demonstration on YouTube](https://www.youtube.com/watch?v=R6IAjGgqdCs)
## Issues
* By nature of how simple and "brute force" this is, performance is bad and it's not well-suited to simulating anything for millions of years, which is where interesting solar system dynamics start to happen.
* Related: it's not very stable. If you look near the end of the YouTube video linked above, you'll see that the orbits of the inner planets (especially Mercury) have wandered a bit.
