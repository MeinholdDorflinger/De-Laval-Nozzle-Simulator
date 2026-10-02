# Quasi-1D-De-Laval-Nozzle-Simulator
Numerical solver to model 1D compressible flow through a custom parabolic converging-diverging nozzle. Utilizes the area-Mach relation to compute Mach number distributions as well as calculate temperature, pressure, velocity, mass flow rate, and total thrust.

**Nozzle Geometry**

 - The nozzle is defined by two opposing parabolic functions:

                                 y_top = 1/25 * x.^2 + 1
                              y_bottom = -1/25 * x.^2 - 1
 - The throat is located at x = 0, with the throat radius being obtained from the upper parabolic y-value
 - Asymmetry/Symmetry can be chosen by altering the domain of x-values so that the magnitude of the ends of the domain aren't equal to each other, since the throat of the nozzle is centered about x = 0
  
    Asymmetric:  

        x=-2:0.2:3 ---- Differing magnitude of end values (-2/3)

   Symmetric:

       x=-2:0.2:2 ---- Equal magnitude of end values (-2/2)

**Area Distribution**

 - The cross-sectional area across the nozzle can be calculated with:

                           Area = pi.*radius.^2
 - The ratio of cross-sectional area at any point on the nozzle with the area of the throat can be found with:

                           Area./Area_throat

**Mach Number**

 - Mach number is obtained by using the area-Mach relation, which is found using MATLAB's fzero function
 - Subsonic values are found at any point from the inlet to just before the throat
 - Supersonic values are achieved after passing through the nozzle throat, meaning at x = 0 is when Mach equals 1

**Thermodynamic Properties**

 - Initial values must be provided, such as:

       Gamma = 1.4
   
       R = 287.0 J/(Kg*K)
     
       Stagnation Temperature = 3000 K

       Stagnation Pressure = 1 MPa

       Ambient Pressure = 101.325 kPa

 - Utilizing the above, we can determine the distribution of these Thermodynamic Properties:

       Pressure = Inlet_Pressure * (1 + ((gamma-1)/2).*Mach.^2).^(-gamma/(gamma-1)) ---- Pascals

       Temperature = Inlet_Temperature * (1 + ((gamma-1)/2).*Mach.^2).^(-1)         ---- Kelvin

       Velocity = Mach. * sqrt(gamma.*R.*T)                                         ---- Meters per second

       Density = Pressure./(R.*Temperature)                                         ---- kg/m^3

       Mass Flow Rate = Density.*Area.*Velocity                                     ---- kg/s

**Continuity Verification**

 - Using the distribution of Mass Flow Rate that we evaluated, we can conduct a validation check. Conservation of Mass requires that the Mass Flow Rate remain steady throughout the nozzle.

 - This is confirmed by having a **ṁ** distribution with no slope

**Performance Outputs**

 - Running the script outputs both numerical values and distributions:

   Example:

       Exit Mach 2.15 

       Exit Pressure 101.33 kPa 

       Ambient Pressure 101.33 kPa 
  
       Expansion Condition: Ideally Expanded 

       Momentum Thrust 3943.52 kN 

       Pressure Thrust 0.01 kN 

       Total Thrust 3943.53 kN 


<img width="1347" height="873" alt="Figure_1" src="https://github.com/user-attachments/assets/2f7c097e-50e7-4f46-9494-562814b2641e" />


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Assumptions**

 - This is a Quasi-1D De Laval Nozzle Simulator. The main assumption is that all flow properties vary only along the x-axis (1D), and all changes are completely uniform for the entire cross-section
 - It also assumes:

    No Heat Transfer

    No Friction
   
    Ideal Gas
   
    Steady Flow
