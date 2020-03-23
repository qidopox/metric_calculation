% Calculate strehl ratio when imaging a planar object
% currentaberration is a 2D matrix defining the pupil wavefront
% referencefluo2 is a normalisation term; it is the intensity when no
% aberration exists in the pupil plane
% mask is a binary mask with the same size as the currentaberration which
% defines the size and shape of the incoming beam.

function [fluorescencemeasure] =...
    MeasureEmittedFluorescence(currentaberration,mask,referencefluo2)

currentfocal = fftshift(fft2(exp(1i.*currentaberration).*mask))./...
    nnz(mask);

fluorescencemeasure = sum(sum(abs(currentfocal.^4)));

fluorescencemeasure = fluorescencemeasure./referencefluo2;

