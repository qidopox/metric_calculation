% Calculate strehl ratio when imaging a volume object
% currentaberration is a 2D matrix defining the pupil wavefront
% referencefluo2 is a normalisation term; it is the intensity when no
% aberration exists in the pupil plane
% mask is a binary mask with the same size as the currentaberration which
% defines the size and shape of the incoming beam.

function [fluorescencemeasure,noofmeasure] = MeasureEmittedFluorescence1(currentaberration,Mask,referencefluo2)

thicknesslayer = linspace(-1,1,round(size(currentaberration,1)/8));

centerofpupil = [round(size(currentaberration,1)/2+1),round(size(currentaberration,2)/2+1)];

defocusratio = 8*pi*(1.0/1.5)^2/2;

fluorescencemeasure = 0;


        for iii = 1:length(thicknesslayer)
            
            thispupillayer = zeros(size(currentaberration,1),size(currentaberration,2));
            for i = 1:size(currentaberration,1)
    for ii = 1:size(currentaberration,2)

            thispupillayer(i,ii) = currentaberration(i,ii)+ defocusratio.*thicknesslayer(iii)*(((i-centerofpupil(1,1))/(centerofpupil(1,1)-1))^2+((ii-centerofpupil(1,2))/(centerofpupil(1,2)-1))^2);
    
    end
            end
    
%             figure(55)
% imagesc(thispupillayer)
% 
currentaberrationforfourier = zeros(size(currentaberration,1)*2,size(currentaberration,2)*2);

currentaberrationforfourier(round(size(currentaberration,1)/2+1):round(size(currentaberration,1)/2*3),round(size(currentaberration,2)/2+1):round(size(currentaberration,2)/2*3)) = exp(1i.*thispupillayer);

currentfocal = fftshift(fft2(currentaberrationforfourier));

% figure(33)
% imagesc(abs(currentfocal))

fluorescencemeasure =fluorescencemeasure+ sum(sum(abs(currentfocal).^4));

        end

        
fluorescencemeasure = fluorescencemeasure/referencefluo2;
% fluorescencemeasure = abs(currentfocal(Middle,Middle));

