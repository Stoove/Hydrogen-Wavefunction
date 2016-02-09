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
#
#####################################################################################################
# The package includes
#####################################################################################################
#
# Hwavfn.m
# 	Description goes here
#
# HydrogenWavfnSettings.m
# 	Description goes here
#
# LaguerreGen.m
# 	Script to generate associated Laguerre polynomials
#
# MixedHydrogenPDF2state.m
# 	Description goes here
#
# MixedHydrogenPDS3state.m
# 	Description goes here
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