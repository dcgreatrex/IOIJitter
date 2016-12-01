#IOI_jitter.m
# IOI temporal jitter algorithm generates a sequence of either periodic or aperiodic IOI values based on a range of predefined criteria.
*Author: David Greatrex, University of Cambridge.  
*Date: 01/12/2016 -- Language: Matlab. -- Modifications:

##Overview:
The algorithm generates a sequence of IOI values based on a number of predefined criteria.
It can be used to generate both periodic IOI sequences and aperidic IOI sequences.
Aperiodic sequences are defined by number of events and amount of temporal jitter (randomly sampled variance).
Controls ensure that back-to-back IOIs that are very similar to one another do not appear in the aperiodic sequence.
Aperiodic sequences are always the same total duration as periodic counterparts, plus or minus a user defined window of error.

##Instructions:
1. Save the main function directory locally on your harddrive.
2. Open Matlab and set the working directory to that of the saved directory.
3. Open the file "demo_1.m". Look at the code and read instructions to understand the example.
4. Type 'demo_1' into the matlab terminal and press enter.
5. Look at the output.
6. Open the file "demo_2.m". Look at the code and read instructions to understand the example.
7. Type 'demo_2' into the matlab terminal and press enter.
8. Look at the output.
9. You should now be ready to incorporate this into your own experimental code.

##Algorithm description:
The presentation timing of stimulus onsets are determined using the temporal jitter procedure described by Goupell et al. (2009) and brown et al. (2011). 
For each trial, the inter-onset interval (IOI) is drawn randomly from a uniform distribution centered at a nominal IOI of (periodic_IOI) ms, with a dispersion equal to 2i times the nominal IOI. 
The parameter i thus defines the degree of temporal jitter, with i = 0 corresponding to temporal isochrony (no jitter) and i = 1 to maximal jitter (individual IOIs ranging from 0 to 2*nominal IOI).
Temporal presentation of the sequence can either be periodic or aperiodic. 
Periodic sequences are generated with i = 0 and aperiodic sequences with i = jitter (0< i <=1). 
This means that aperiodic IOIs are randomly selected from a range between nominal IOI - (nominal IOI * jitter) and nominal IOI - (nominal IOI * jitter), whereas periodic IOIs are always nominal IOI. 
In order to reduce the likelihood of metrically related IOIs occurring in the aperiodic condition, aperiodic IOIs are resampled if their value fall within (exclude window)ms of the preceding IOI in the sequence.
Importantly, resampling also ensures that the total duration of the aperiodic sequence is always the same as the total duration of the periodic sequence, with a variability of (total_dur_Exception) ms.

##References:

* [Goupell, M. J., Laback, B., and Majdak, P. (2009). Enhancing sensitivity to interaural time differences at high modulation rates by introducing temporal jitter. The Journal of the Acoustical Society of America, 126(5):2511–2521](http://scitation.aip.org/content/asa/journal/jasa/126/5/10.1121/1.3206584)

* [Brown, A. D. and Stecker, G. C. (2011). Temporal weighting functions for inter- aural time and level differences. ii. the effect of binaurally synchronous temporal jitter. The Journal of the Acoustical Society of America, 129(1):293–300](http://scitation.aip.org/content/asa/journal/jasa/129/1/10.1121/1.3514422) 