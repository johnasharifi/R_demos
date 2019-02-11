dim = 60
xscale = 10
yscale = 10

# dim x 2 matrix of point coordinates

# blue-enough noise: grid of x,y coordinates offset by random sample 
# for x between 0 and mean-distance-between-adjacent-x-cells and
# for y between 0 and mean-distance-between-adjacent-y-cells

points = expand.grid(1:dim, 1:dim)
points = cbind(	(points[,1] + runif(dim * dim, -0.5, 0.5)) * xscale, 
			(points[,2] + runif(dim * dim, -0.5, 0.5)) * yscale)

# adjacents: ith point to i+(-1/1/-dim/dim)th point
points_count = dim(points)[1]
edge_origins = sample(1:points_count, size = points_count, replace = TRUE)
edge_termini = edge_origins + sample(c(-1,1, -dim, dim), size = points_count, replace = TRUE)
dx = edge_termini - edge_origins
oob = edge_termini < 1 | edge_termini > points_count | (edge_origins %% dim == 0) | (edge_termini %% dim == 0 & dx < 0)
edge_termini[oob] = edge_origins[oob]

plot(points)
edge_map = cbind(points[edge_origins,], points[edge_termini, ])
segments(edge_map[,1], edge_map[,2], edge_map[,3], edge_map[,4])

dsq = (edge_map[,1] - edge_map[,3])^2 + (edge_map[,2] - edge_map[,4])^2
dist_xy = sqrt(dsq)
par(mfrow = c(3,1))
hist(edge_map[,1] - edge_map[,3])
hist(edge_map[,2] - edge_map[,4])
hist(dist_xy)
