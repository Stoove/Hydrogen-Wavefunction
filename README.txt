#####################################################################################################
# README file for Hydrogen-Wavefunction
#####################################################################################################
#
#####################################################################################################
# Author: Stoove (stoove@live.com)
#####################################################################################################
#
#####################################################################################################
# Description
#####################################################################################################
#
# A project I started as part of my PhD, which aims to develop a set of tools allowing the user to plot
# arbitrary superpositions of Hydrogen wavefunctions, which are important for many reasons.
#
# This package could be used as a learning tool for Physics students, with examples of:
# 	- Spherical harmonics and their applications to real atoms.
# 	- Superposition states (from quantum mechanics) and their real tangible effects.
# 	- Examples of computational techniques in Physics and Mathematics, such as the calculation of 
# 	  Laguerre polynomials and spherical harmonics.
# 	- Good coding practice and tricks in Matlab
#
#
#####################################################################################################
# Development Aims
#####################################################################################################
#
# (1) Add text support for arbitrary nlm combinations (currently doesn't support -ive m except -1)
#	**FINISHED!**
# 
# (2) Tidy up functionality of the script files which do one specific things. Make them callable 
#     functions.
#
# (3) Allow scripts to take arguments for the superposition coefficients and basis states
#
# (4) Implement a superposition plotting function to be called in all scripts, replacing the plotting
#     code.
#
# (5) Implement a GUI which allows the user to define the basis states more simply.
#
# (6) Upload Compute_Ylm.m to complete functionality of package. (Dependency of Hwavfn.m)!
#
# (7) Write more general version of MixedHydrogenPDF2state.m which allows an arbitrary number of
#     states and the corresponding relative phase factors.
#
#
#####################################################################################################
# The package includes
#####################################################################################################
#
# Hwavfn.m
# 	Function which calculates the Hydrogen orbital wavefunctions based on the inputs in params.
#	Params must be a struct, and its field reflect values of various constants. See file header for
#	full requirements, or use HydrogenWavfnSettings.m to generate a params struct with the default
#	values.
#
# HydrogenWavfnSettings.m
# 	Function to set up the settings for input into Hwavfn.m in a quick and easy way. Sets up
#	default settings in a struct with the appropriate field names, and calculates nlm quantum
#	numbers for you if you give it the appropriate notation string. Works out the x-y-z arguments
#	for the appropriate plane which you request.
#	
#	Note :: nlm notation strings
#	The 'orbital' string uses standard notation to specify the quantum numbers of the state
#	which you are interested in plotting. The numbers are in the order n, l, m, which
#	correspond to: principal quantum number (n); angular momentum quantum number (l);
#	magnetic quantum number (m).
#	(n) - Positive integer, cannot be zero
#	(l) - Letter (lower case). s=0, p=1, d=2, f=3, then g onwards are indexed in order.
#		l should be between 0 and n.
#	(m) - Integer. Signed or unsigned. For +-1, it is acceptable to write only the + or -.
#		m should be in the range -l to +l
#
# nlmStringParse.m
#	Function to parse an nlm notation string (see above) and return the quantum numbers for the
#	state. Sanitizes inputs using regular expressions, returns appropriate warnings/errors about
#	formatting of the argument.
#
# LaguerreGen.m
# 	Script to generate associated Laguerre polynomials
#
# MixedHydrogenPDF2state.m
# 	Simple function to calculate the probability density function for a 50-50 superposition between
#	two wavefunctions, which have a relative phase factor given in input Theta. Requires cell array
#	of nlm identifier strings (see note on HydrogenWavfnSettings.m, above).
#
# MixedHydrogenPDF3state.m
# 	Simple function to calculate the probability density function for a 50-25-25 superposition between
#	three wavefunctions, which have a relative phase factor given in inputs Theta, phi. Requires cell array
#	of nlm identifier strings (see note on HydrogenWavfnSettings.m, above).
#
# pdfvolfract.m
# 	Function to calculate the PDF volume fraction with more than or equal to the argument x. Used
#	for finding the 50% probability shell (red contour).
#
# PlotMixedOrbitals.m
# 	Description goes here
#
# PlotPureOrbital.m
# 	Description goes here
#
# spharm.m
# 	Function to calculate the spherical harmonics. Based on a script from the Matlab community,
#	but improved to calculate the -m cases correctly!
#
# teststruc.m
# 	Function to check the presence and type of arguments in a settings struct against defaults.
#	Useful for ensuring default settings are set without relying on user to type all settings.
#
# ThreeOrbitalThetaScan.m
# 	Description goes here
#
# TwoOrbitalThetaScan.m
# 	Description goes here
#
#
#
#
#
#