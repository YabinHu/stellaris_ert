function stellaris_customcode(buildInfo)
% Add startup_ccs.c to list of source files
% TODO: what is user wants to provide his own?... How to extend this
% file anyway? Seems i have to generate it dynamically via TLC.
% Or get rid of it by registering timer interrupt with driverlib functions.
% Don't add this file for SIL
if ~i_isSIL(buildInfo)
    buildInfo.addSourceFiles('startup_ccs.c',getpref('stellaris','TargetRoot'),'CustomCode');
end

makertwArgs = buildInfo.BuildArgs;

for i=1:length(makertwArgs)
    if strcmp(makertwArgs(i).DisplayLabel,'EXT_MODE')
        externalMode = str2double(makertwArgs(i).Value);
    end
end

% See comments in stellaris_main.tlc as to why i'm doing this
if (externalMode == 1)
    buildInfo.addSourceFiles('ext_main.c',getpref('stellaris','TargetRoot'),'CustomCode');
end
end

function isSIL = i_isSIL(buildInfo)
buildOpts = rtwprivate('get_makertwsettings',buildInfo.ModelName,'BuildOpts');
isSIL = buildOpts.XilInfo.IsSil;
end
