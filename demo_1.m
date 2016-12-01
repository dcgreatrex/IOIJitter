% Example of how to use the computeIOIArray function.


%--------------------------------------------------------------------
% Basic
%--------------------------------------------------------------------

% 1. define input parameters for the computeIOIArray function.
% read the function instructions for requirements for each parameter.

is_Periodic     	= 0;		% do you want a periodic (1) or aperiodic (0) IOI sequence?
n_Targets      		= 15;		% how many onsets are their in your sequence (large numbers > 50 will take a very long time to compute)
periodic_IOI   		= 0.500;	% what is the default IOI (in seconds) for periodic sequences?
jitter		    	= 0.5;		% how much temporal jitter do you want for aperiodic sequences? Pick a value 
								% between 0 and 1. Read README and function instructions for further details.
exclude_Window		= 0.025;	% what is the minimum time difference (in seconds) between any two succeeding IOIs in aperiodic sequences?
total_dur_exception = 0.010;	% aperiodic sequences will be generated to have the same duration as periodic sequences. Define what window of
								% accuracy (in seconds) you require the total duration between periodic and aperiodic to be. 

% 2. Run the computeIOIArray function. The IOI values for the sequence are returned as a value array which needs to be saved.

IOI_result = IOI_jitter(is_Periodic, n_Targets, periodic_IOI, jitter, exclude_Window, total_dur_exception);  

% 3 print the generated IOI array values to the matlab terminal.
disp(IOI_result)