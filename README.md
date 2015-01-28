### Aircraft Ground Motion Model

(c) Juraj Kardos, 2015

This project provides a MATLAB implemention of ground motion model of a single-aisle passenger aircraft.
Such model is required
in order to successfully manage automation tasks. Automation will play essential
role in increasing throughput of airports in metropolitan areas that will experience raising
numbers of passengers. Model is valid under different operational conditions, such as varying
runway conditions due to the state of the atmosphere at a particular place and time as
regards temperature and precipitation. Model can be adapted to standard concrete runway
surface, considering water contamination during rainfalls or icy and snow-covered runway
conditions during freezing temperatures. Model assumes varying aircraft parameters such
as aircraft load and tire pressure. These parameters inuence the interaction of landing gear
with runway surface, therefore are essential for high-precision ground motion modeling.

Ground motion model is used as underlying component for controller module, which is able to regulate
aircraft velocity with respect to reference value and automatically steer aircraft to the
predefined target destination. 

**USAGE:**

Initialize model using script thats specifies aircraft parameters and environmental conditions:
```
>> parameters
```

Run simulation using Simulink interface or by executing
```
>> tspan=0:0.1:100;
>> sim('aero_ground_model',tspan);
```

When simulation is finished visualize aircraft motion:
```
>> render
```

![alt tag](https://raw.github.com/goghino/aw_model/master/trajectory.PNG)