% Function for optimization which finds the contour value which encloses
% 50% of the PDF volume.

function [frac] = pdfvolfract(x,matr)

logs = matr > x;
frac = sumMatrix(matr(logs))./sumMatrix(matr);

