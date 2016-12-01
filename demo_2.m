%--------------------------------------------------------------------
% Example of using IOI_jitter.m during an experiment
%--------------------------------------------------------------------

% A new IOI array is generated dynamcially before the start of each trial.

% 1. imagine your experiment has 100 trials.
t = 100;

% 2. 50% of trials are periodic and 50% are aperiodi
p = t/2;
ap = t/2;

% 2.1 generate a randomised list of peridoicity values to feed the algorithm on each trial.
ix = randperm(t);
A = [ones(1,p),zeros(1,ap)]
p = A(ix)

% 3. define IOI sequence characteristics for each trial 
n_Targets      		= 20;		% how many onsets are their in your sequence (large numbers > 50 will take a very long time to compute)
periodic_IOI   		= 0.400;	% what is the default IOI (in seconds) for periodic sequences?
jitter		    	= 0.6;		% how much temporal jitter do you want for aperiodic sequences? Pick a value 
					% between 0 and 1. Read README and function instructions for further details.
exclude_Window		= 0.025;	% what is the minimum time difference (in seconds) between any two succeeding IOIs in aperiodic sequences?
total_dur_exception   = 0.010;		% aperiodic sequences will be generated to have the same duration as periodic sequences. 
					% Define what window of accuracy (in seconds) you require the total duration between periodic and aperiodic to be. 

% 4 Start trial loop
for i = 1:t

  % 4.1 print trial number
  disp(['Starting trial ', num2str(i)])

  
  % 4.2 load periodicity flag for trial i
  is_Periodic = p(i);
  if is_Periodic == 1
    disp(['This trial requires generating a periodic IOI sequence for ', num2str(n_Targets), ' onset events, with a periodic IOI rate of ', num2str(periodic_IOI), ' seconds.'])
  else
  	disp(['This trial requires generating an aperiodic IOI sequence for ', num2str(n_Targets), ' onset events, with a periodic IOI rate of ', num2str(periodic_IOI), ' seconds.'])
  end  	

  % 4.3 generate a sequence of IOI values that fit your requirements for that trial
  IOI_result = IOI_jitter(is_Periodic, n_Targets, periodic_IOI, jitter, exclude_Window, total_dur_exception);  

  % 4.4 display the generated IOI array
  disp(IOI_result)

  % 4.5
  % DO SOMETHING WITH THE IOI VALUES
  % ...
  %

end
