function IOI_array = IOI_jitter(is_Periodic, n_Target, periodic_IOI, jitter, exclude_Window, total_dur_Exception)
%IOI_jitter: This function generates either a periodic or aperiodic IOI array sequence.
% The total duraction of the aperiodic sequence will always be the same as that of the periodic
% sequence (plus or minus a small window of exception determined by the variable "total_dur_exception")
% 
% Syntax:  IOI_array = IOI_jitter(is_Periodic, n_Target, periodic_IOI)
%
% Input: 
%           is_Periodic:
%             - This requires a boolean value.
%               - 1 = periodic rhythm
%               - 0 = aperiodic rhythm   
%
%           nTarget
%             - This requires a positive integer 
%               - The passed integer indicates how many onsets there are in the rhythmic sequence 
%                 being generated. For example, if you enter "8", then the function will return 
%                 7 IOI values.         
%
%           periodic_IOI
%             - IOI value in seconds from which to generate periodic sequences. 
%               - Thus "0.600" will generate periodic sequences which comprise of a 
%                 sequence of 600ms intervals.
%
%           jitter
%             - A value from 0 to 1. 0 <= jitter => 1
%               - Jitter defines how wide the IOI sampling window should be when sampling aperiodic IOIs.
%                 If jitter = 1 and periodic_IOI = 0.600, aperiodic IOIs will be sampled from a range between 
%                 2 * (jitter * periodic_IOI) positioned either side of the periodic IOI value. 
%                 Thus, aperiodic IOI values will be selected from a range between 0 and 1.200 seconds. 
%                 If jitter is set at 0.6, the sampling range will be set at 2 * (jitter * periodic_IOI) positioned
%                 either side of the periodic IOI value, thus the sampling range will be between 0.24 and 0.960 seconds. 
%
%           exclude_Window
%             - Floating point number defining the minimum time difference (s) allowed between IOI at time t and IOI at time t-1.
%               By setting exclude_Window > 0, it will ensure that you do not get identical back-to-back IOIs by chance during
%               random sequence generation.
%
%           total_dur_Exception
%             - Floating point number defining the maximum allowed time difference in the total sequence duration (s) 
%               between periodic and aperiodic sequences.
%
% Output:
% 
%           IOI_array  
%             - array containing IOI values for the requested onset sequence         
%
% Example:
%
%           [IOI_array = IOI_jitter(is_Periodic, n_Target, periodic_IOI)
%
% m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% Author: David C Greatrex
% Address: CMS, Cambridge University
% Last revision: 12/02/2017

%------------------------------------------
try 

    % check input arguements and set default values if the last 3 arguments are not passed to the function
    if nargin < 6
        total_dur_Exception = 0.010;
    end
    if nargin < 5
        exclude_Window = 0.025;                            
    end
    if nargin < 4
        jitter = 0.5;                      
    end
    if nargin < 3
        disp('WARNING, not enought input arguments. Please read function instructions and try again. Aborting...');
        return
    end
      
    IOI_range = periodic_IOI * jitter;
    n_IOI = n_Target - 1;


    % generate IOI array
    if is_Periodic == 1                   
        IOI_array(1:n_IOI) = periodic_IOI;                   % periodic: return an array of zeros
        return;
    else                                                        % aperiodic: randomly select IOI array    
        lsum = (periodic_IOI * n_IOI)-(total_dur_Exception); % lowest total sequence duration possible
        usum = (periodic_IOI * n_IOI)+(total_dur_Exception); % highest total sequence duration possible
        tMinus1 = 0;
        IOI_array = [];
        while true
            for i = 1:n_IOI                                  % loop until n_target IOIs are found
                
                while true
                    
                    t = periodic_IOI + IOI_range * ( 2 * rand(1,1) - 1 ); % random number between periodic_IOI ± IOI_range
                    
                    if tMinus1 ~= 0

                        isLowbound  = t >= (tMinus1 - exclude_Window);  
                        isHighbound = t <= (tMinus1 + exclude_Window);
                        if (isLowbound && isHighbound)          % resample if IOI value is within IOI exclude window
                            continue
                        else
                            break
                        end
                    else
                        break
                    end
                end

                IOI_array(i) = t;    % update IOI array with value
                tMinus1 = t;
            end

            if (sum(IOI_array) < lsum || sum(IOI_array) > usum)
                continue
            else
                break
            end
        end
    end
    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------