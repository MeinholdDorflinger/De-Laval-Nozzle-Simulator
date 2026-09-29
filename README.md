# Quasi-1D-De-Laval-Nozzle-Simulator
Numerical solver to model 1D compressible flow through a custom parabolic converging-diverging nozzle. Utilizes the Area-Mach relation to compute and distribute subsonic-to-supersonic flow transitions through the nozzle throat. Generates distributions for temperature, pressure, velocity, and mass flow rate. Evaluates thrust, exit Mach, and ideal area/pressure ratios, which are desirable for engine performance.

• Defines two opposing (positive and negative) parabolic functions that map out the converging-diverging De Laval Nozzle. The nozzle throat radius can be altered in the equation by changing h ( y=cx^2 + h ). The nozzle can be altered to be either symmetrical or asymmetrical by changing the domain of x-values used ( centered on the origin ).

• Areas along the nozzle are found by using the y-values as the radius and solving for area = pi*r^2

• Necessary constants are then defined by no specific measure: Gamma, R, inlet temperature/pressure, and ambient pressure.

• In order to find Mach distributions, the Mach-Area relation is utilized and solved for with MATLAB's fzero function.

• Rearranging the Mach-Area relation allows us to find temperature and pressure distributions.

• Velocity is then found by multiplying M*a, where "a" is the local speed of sound.

• To ensure validity, we can perform a Continuity Verification, where we find the mass flow rate throughout the nozzle. In conjunction with the Law of Conservation of Mass, the mass flow rate must be constant throughout, displaying a graph with y equal to a constant.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Example

- The first step is to define the x-axis limits. A domain ending in different values gives us an asymmetrical nozzle, such as [-2, 3] 
- Defining our opposing parabolic functions is the second step. In this example, we use y_top = (1/23.5)*x^2+1 and y_bottom = -(1/23.5)*x^2+1
- Our constants Gamma, R, initial temp., initial pressure, and ambient pressure are defined as 1.4, 287 J/(kg*k), 3000 K, 1000000 Pa, and 101325 Pa, respectively.
- The script then solves for and plots the following outputs provided at the bottom:

  (Note: the subsonic-to-supersonic transition occurs at x=0, the same point as the nozzle throat.)
- The script then numerically outputs the following:

  Inlet Pressure (Pascals): 1000000 

  Ambient Pressure (Pascals): 101325 

  Inlet Temperature (K): 3000 

  Gamma: 1.40 

  Outlet vs Throat Area Ratio = 1.91   

  Outlet vs Ambient Pressure = 1.00

  Force (N): 3943530.52 

  Exit Mach: 2.15 
<img width="1355" height="869" alt="De_Laval_Nozzle_Subplots" src="https://github.com/user-attachments/assets/20e03d0e-e671-40ff-a869-8158c57fea74" />
