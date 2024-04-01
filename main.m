%% Calling 42 C code through Matlab interface
% Rayan Mazouz, Marco Quadrelli
% Verification: Orbits and Attitude

clc; clear; close;

% Call 42
output = system('./42 InOut');


% Save
% for Irun=1:Nrun,
% % Compute initial attitude
% CRN = TRIAD(tvn(Irun,:),svn,[0 0 1],[1 0 0]);
% qrn = C2Q(CRN);
% % Write target to file
% Outdata = [TrgRA(Irun) TrgDec(Irun)];
% save -ascii ./MOMBIAS/TargetRaDec.inp Outdata
% % Write initial attitude to file
% line = sprintf('%f %f %f %f ! Quaternion\n', qrn(1),qrn(2),qrn(3),qrn(4));
% OverwriteLineInFile('./MOMBIAS/GLAST.inp',21,line);
% % Run 42 for three days.
% system('./42 MOMBIAS');
% % Record pointing histogram.
% load ./MOMBIAS/AngleToGo.42
% [HistCount(Irun,:),HistAng(Irun,:)] = hist(AngleToGo,20);
% end