library(rgl)

block <- function(m, x, y, width, height, value, theta, t) {
	if (t > 10)
		return(m)

	x = pmax(pmin(x, dim(m)[1]), 1)
	y = pmax(pmin(y, dim(m)[2]), 1)
	xmax = pmax(pmin(x + width, dim(m)[1]), 1)
	ymax = pmax(pmin(y + height, dim(m)[2]), 1)

	m[x:xmax, y:ymax] = value

	# continuation of main line
	if (runif(n = 1) < 0.9) {
		theta_deriv = theta + runif(1, min = -0.5, max = 0.5)
		r = dim(m)[1] * 0.05
		
		x_deriv = x + cos(theta) * r
		y_deriv = y + sin(theta) * r
		value_deriv = value * runif(1, min = 0.8, max = 1.2)

		m = block(m, x_deriv, y_deriv, width, height, value_deriv, theta_deriv, t + 1)
		}

	# create orthogonal series
	if (runif(n = 1) < 0.5) {
		theta_deriv = theta + sample(c(-1,1), size = 1) * 3.14 / 2 + runif(1, min = -0.3, max = 0.3)
		r = dim(m)[1] * 0.05
		
		x_deriv = x + cos(theta) * r
		y_deriv = y + sin(theta) * r
		value_deriv = value * runif(1, min = 0.8, max = 1.2)

		m = block(m, x_deriv, y_deriv, width, height, value_deriv, theta_deriv, t + 2)
		}
	return(m)
	}

seed <- function(xdim, ydim) {
	mat = matrix(nrow = xdim, ncol = ydim, data = rnorm(n = xdim * ydim, mean = 0.3, sd = 0.1))

	seed_count = 20
	for (i in 1:seed_count) {
		mat = block(mat, sample(1:xdim, size = 1), sample(1:ydim, size = 1), xdim * 0.05, ydim * 0.05, runif(n = 1), runif(n = 1, min = -3.14, max = 3.14), 1)
		}

	return(mat)
	}

blur_lines <- function(mat) {
	xmax = dim(mat)[1]
	ymax = dim(mat)[2]
	xinds = (1 : xmax) + sample(-1:1, replace = TRUE, size = xmax)
	yinds = (1 : ymax) + sample(-1:1, replace = TRUE, size = ymax)

	xinds = 1 + (xinds + xmax) %% xmax
	yinds = 1 + (yinds + ymax) %% ymax

	mat = 0.5 * (mat + mat[xinds, yinds])

	return(mat)
	}

blur_adj <- function(mat) {
	inds = which(mat != 0, arr.ind = TRUE)
	inds = inds + sample(-1:1, replace = TRUE, size = prod(dim(inds)))
	inds[,1] = 1 + (inds[,1] + dim(mat)[1]) %% dim(mat)[1]
	inds[,2] = 1 + (inds[,2] + dim(mat)[2]) %% dim(mat)[2]

	m2 = matrix(nrow = dim(mat)[1], ncol = dim(mat)[2], data = mat[inds])

	return((mat + m2) * 0.5)
	}

m = seed(256, 256)
par(mfrow = c(1,3))
image(m, col = terrain.colors(20))

for (i in 1:10)
	m = blur_lines(m)
image(m, col = terrain.colors(20))

for (i in 1:10)
	m = blur_adj(m)
image(m, col = terrain.colors(20))

surf3d <- function(mat) {
	# ?surfac3d
	# http://127.0.0.1:22736/library/rgl/html/surface3d.html
	z = mat * 50
	x <- 1 : nrow(mat)
	y <- 1 : ncol(mat)
	zlim <- range(y)
	colorlut <- terrain.colors(zlim[2] - zlim[1] + 1) # height color lookup table
	col <- colorlut[ z * 5 - zlim[1] + 1 ] # assign colors to heights for each point
	open3d()
	surface3d(x, y, z, color = col, back = "lines")
	}

surf3d(m)