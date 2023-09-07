%% Uncomment this to run the function and get wcs
% File output_wcoherGenzel.mat contains output
thetaband = [6 12];
samplingRate = 1250;
[filtHPC, IND] = removeArtefacts(HPC, 1250, [8 8], [2 0.1]);
[filtPFC, pfcIND] = removeArtefacts(PFC, 1250, [10 10], [2 0.1]);

% figure
% tiledlayout(2,2)
% nexttile
% plot(PFC)
% title("PFC")
% nexttile
% plot(filtPFC)
% title("filtPFC")
% nexttile
% plot(HPC)
% title("HPC")
% nexttile
% plot(filtHPC)
% title("filtHPC")
% 
LFPtheta = bandPassFSignal(filtHPC, samplingRate, thetaband);
thetaPhase = angle(hilbert(LFPtheta));
[sample, ThetaTS] = lu_wcsthetaextract(filtHPC, filtPFC, LFPtheta, thetaPhase, samplingRate, [1;300]);

%% Uncomment this to plot; load output mat file first
selection = 200;


figure
tiledlayout(4, 10, 'TileSpacing', 'compact', 'Padding', 'compact')
for i=1:10
nexttile(i)
plot(sample(:, selection+i));
title(string(selection+i))

nexttile(i+10)
plot(LFPOutput2{selection+i});
title("LFPOutput2")

nexttile(i+20)
plot(LFPOutput1{selection+i});
title("LFPOutput1")

nexttile(i+30)
% imagesc(transpose(real(reshaped(:,:,selection+i))))
imagesc('XData', transpose(PhaseBin), 'CData', transpose(real(reshaped(:,:,selection+i))))
% imagesc(real(reshaped))
set(gca, 'YDir', 'normal')
end

%%
reshaped = reshape(sample, Div(1), Div(2), []);
reshaped(:,:) = reshaped(:,:).*2;
% figure
% imagesc(real(reshaped(:,:,200)))
% figure
% imagesc(transpose(real(reshaped(:,:,200))))
% set(gca, 'YDir', 'normal')
