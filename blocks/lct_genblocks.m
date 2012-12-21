%% GPIO Write
% Populate legacy_code structure with information
GPIOWrite = legacy_code('initialize');
GPIOWrite.SFunctionName = 'sfun_GPIOWrite';
GPIOWrite.HeaderFiles = {'gpiolct.h'};
GPIOWrite.SourceFiles = {'gpiolct.c'};
GPIOWrite.OutputFcnSpec = 'GPIOWrite(uint32 p1, uint8 u1, uint8 u2)';
% Support calling from within For-Each subsystem
GPIOWrite.Options.supportsMultipleExecInstances = true;
%% GPIO Read
GPIORead = legacy_code('initialize');
GPIORead.SFunctionName = 'sfun_GPIORead';
GPIORead.HeaderFiles = {'gpiolct.h'};
GPIORead.SourceFiles = {'gpiolct.c'};
GPIORead.OutputFcnSpec = 'int32 y1 = GPIORead(uint32 p1, uint8 u1)';
GPIORead.Options.supportsMultipleExecInstances = true;
%% GPIO Setup
GPIOSetup = legacy_code('initialize');
GPIOSetup.SFunctionName = 'sfun_GPIOSetup';
GPIOSetup.HeaderFiles = {'gpiolct.h'};
GPIOSetup.SourceFiles = {'gpiolct.c'};
GPIOSetup.StartFcnSpec = 'GPIOSetup(uint32 p1, uint32 p2, uint8 p3)';
GPIOSetup.Options.supportsMultipleExecInstances = true;
%% Push Buttons
Buttons = legacy_code('initialize');
Buttons.SFunctionName = 'sfun_Buttons';
Buttons.HeaderFiles = {'buttonslct.h'};
Buttons.SourceFiles = {'buttonslct.c'};
Buttons.StartFcnSpec = 'ButtonsInit()';
Buttons.OutputFcnSpec = 'uint8 y1 = ButtonsRead(uint8 y2[1])';
%% Put multiple registration files together
def = [GPIOWrite(:);GPIORead(:);GPIOSetup(:);Buttons(:)];
%% Legacy Code Tool
% Generate, compile and link S-function for simulation
legacy_code('generate_for_sim', def);
% Generate TLC file for Code Generation
legacy_code('sfcn_tlc_generate', def);
% Generate according Simulink Block
%legacy_code('slblock_generate', def);
% Generate rtwmakecfg.m file to automatically set up some build options
legacy_code('rtwmakecfg_generate', def);