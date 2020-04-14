! Set up an array to hold 2D data
SYSP 100, 1	# defines the system property field height (that is set by the SYSP 103 command below)

SURP 0, 3, 31.2760		# Set initial working distance to pu object in focus
SYSP 103, 1, 0.0		# Set initial field height
CALLMACRO REAL_NA.ZPL	# Obtain real NA with custom macro

maxval = 1.0			# Maximum value for the array (or legend)

NZ = 41
NY = 37

ZHALFRANGE = 0.01
YRANGE = 0.2

DECLARE Z, DOUBLE, 2, NZ, NY
FOR i, 1, NZ, 1
	SURP 0, 3, 31.2760-ZHALFRANGE+(i-1)*(2*ZHALFRANGE/(NZ-1))# scan a little bit over the focal region in longitudinal direction

	FOR j, 1, NY, 1
		SYSP 103, 1, (j-1)*YRANGE/(NY-1)		# SYSP 103 is sets the y-field height
		
		
		GETZERNIKE 8,1,1,1,1				# Produces vector containing the Strehl ratio
				
		IF (VEC1(6) > 0.8)
			Z(i, j) = 1.0
		ELSE
			Z(i, j) = VEC1(6)		# retrieve the value of the Strehl ratio from the vector
		ENDIF

!		FORMAT 16.6
!		PRINT i, j, THIC(0), FLDY(1), VEC1(6)
	NEXT j
NEXT i

! Define settings for data plot

title$ = "Plot of XY data"		# Plot title
comment1$ = "This is a simple test"	# Plot comment line #1
comment2$ = "to determine if the"	# Plot comment line #2
comment3$ = "PLOT2D keyword is"		# Plot comment line #3
comment4$ = "working correctly"		# Plot comment line #4
comment5$ = "NA = " + $STR(CALD(1))	# Plot comment line #5
rmin = 0.0				# Minimum plot value
rmax = maxval				# Maximum plot value
distyp = 5				# Display type


! Plot the data

PLOT2D NEW				# Initialize a new plot
PLOT2D TITLE, title$			# Place the title on the plot
PLOT2D COMM1, comment1$			# Place the comments on the plot
!PLOT2D COMM2, comment2$
!PLOT2D COMM3, comment3$
!PLOT2D COMM4, comment4$
PLOT2D COMM5, comment5$
PLOT2D RANGE, rmin, rmax		# Define the data range to be plotted
PLOT2D DISPLAYTYPE, distyp		# Define the data display type
PLOT2D CONTOURINTERVAL, "0.1"
PLOT2D DATA, Z			# Plot the data to a 2D plot using the defined display type
PLOT2D GO				# Generate the plot

! Release memory associated with array variable

RELEASE Z

END