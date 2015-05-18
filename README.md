### Aircraft Ground Motion Model

(c) Juraj Kardos, 2015

This project provides a MATLAB/Simulink implemention of a ground motion model
for a single-aisle passenger aircraft. Such model is required
in order to successfully manage the automation tasks. Automation will play essential
role in increasing throughput of airports in metropolitan areas that will experience raising
numbers of passengers. The model is valid under different operational conditions, such as varying
runway conditions due to the state of the atmosphere at a particular place and time as
regards temperature and precipitation. The model can be adapted to standard concrete runway
surface, considering water contamination during rainfalls or ice and snow runway
contamination during freezing temperatures. The model also assumes varying aircraft parameters such
as the aircraft load and the tire pressure. These parameters influence the interaction of the landing gear
with the runway surface, therefore are essential for high-precision ground motion modeling.

Ground motion model is used as an underlying component for the AutoTaxi controller module,
which is able to regulate the aircraft velocity with respect to the reference value and
automatically steer the aircraft to the predefined target destination based on the provided
reference trajectory. Simulation results were subjected to a comparison with the analytical
solution of the Ackerman drive for a tricycle vehicle and with turn radii specified in
Airplane Characteristics for Airport Planning  issued by Boeing. Obtained results confirmed
high-precision real-time simulation.

**USAGE:**

Run simulation using script:
```
>> run_simulation
```
It initializes the model with aircraft parameters and environmental conditions and
specifies the target trajectory for the aircraft during taxi phase. The script then
calls Simulink model and executes the simulation.


When simulation is finished visualize the aircraft motion:
```
>> render
```

![alt tag](https://raw.github.com/goghino/aw_model/master/trajectory.PNG)
