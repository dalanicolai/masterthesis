! real_na.zpl
!
! Written by Daniel Nicolai 1/17/2018 (modified 'marginal ray trace' example from Zemax manual)
! Added TIMER function 4/18/96
!
TIMER
!
PRINT "Tracing the marginal ray at primary wavelength!"
n = NSUR()
RAYTRACE 0,0,0,1
na = SINE(ACOS(RAYN(0)))
PRINT "The real NA is ", na
PRINT "The current working distance is ", THIC(0)
CALLSETDBL 1, na			# for use as child macro, sets parent macro (numeric) buffer index position 1  
