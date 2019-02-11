# R_demos
Data processing in R

# Terrain gen

Using spotty noise and the vectorized recursive function "block" within r_terrain_demo.R, we can create heightmaps in R. Then we can pass a blurring kernel over the spotty terrain several times, transforming it from a spotty discrete surface into a blurry one.

![Kernel 1](https://github.com/johnasharifi/R_demos/blob/master/terrain_kernel_1.png)

The R graphics libary (RGL) can be used to display the 2D heightmap as a 3D surface.

![Kernel 4](https://github.com/johnasharifi/R_demos/blob/master/terrain_kernel_4.png)

# Sufficiently-blue noise

Occasionally it is useful to have a group of points which are not overlapping, but are otherwise random. See ![Wikipedia: blue noise](https://en.wikipedia.org/wiki/Colors_of_noise#Blue_noise). While there are very complicated implementations of blue noise out there, they are often unnecessarily difficult for applications outside statistics research.

We can use an equation like
<a href="https://www.codecogs.com/eqnedit.php?latex=Given&space;xscale,&space;yscale,&space;Uniform&space;Distribution&space;U\\&space;p(x,y)&space;=&space;\begin{cases}&space;&&space;\text{&space;x&space;}&space;=&space;(i&space;&plus;&space;U(-0.5,&space;0.5)&space;)&space;*&space;xscale\\&space;&&space;\text{&space;y&space;}&space;=&space;(j&space;&plus;&space;U(-0.5,&space;0.5)&space;)&space;*&space;yscale&space;\end{cases}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?Given&space;xscale,&space;yscale,&space;Uniform&space;Distribution&space;U\\&space;p(x,y)&space;=&space;\begin{cases}&space;&&space;\text{&space;x&space;}&space;=&space;(i&space;&plus;&space;U(-0.5,&space;0.5)&space;)&space;*&space;xscale\\&space;&&space;\text{&space;y&space;}&space;=&space;(j&space;&plus;&space;U(-0.5,&space;0.5)&space;)&space;*&space;yscale&space;\end{cases}" title="Given xscale, yscale, Uniform Distribution U\\ p(x,y) = \begin{cases} & \text{ x } = (i + U(-0.5, 0.5) ) * xscale\\ & \text{ y } = (j + U(-0.5, 0.5) ) * yscale \end{cases}" /></a>

to give a grid of points in 2D (or with a few easy changes, 3D) space.

Then using our knowledge of graph theory we can draw a few edges between nodes/points.

![Blue noise edges](https://github.com/johnasharifi/R_demos/blob/master/blue_noise_1.png)
