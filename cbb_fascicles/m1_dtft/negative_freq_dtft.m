function [fh,ah,lh] = negative_frequency_dtft(sample_number);
%% NEGATIVE_FREQUENCY_DTFT -- in the dtft you are taking the dot product
% between your signal and a bank of "filters" from frequency
% linearly spaced from 0 cycles per signal lenth to sample_count cycles per signal length.
% Remember, Harry Nyquist (and others... Whittaker, Kotelnikov, + Shannon). In terms of 
% samples, this means that our "filters" go from zero, past Nyquist, to 2*Nyquist.
% This fact, keeping aliasing in mind, allows for insight into negative frequencies, lets take a look. 
% Note: frequency is not in terms of any sampling rate (such as Hz) we are just
% going to look at this phenomenon in the 'sample number' domain...
% What you will notice -- the sampled frequency one larger than the nyquist is both traversed by the signal
% larger than that of the nyquist frequency and the negative of the frequency one less than the nyquist frequency.

%% set up different samplings for the same amount of 'time' 
	% first we will construct a signal that will be
	% above the resolution of our sample_number. 
	% this is for 'visualization' only. 
	true_bs = .01;
	true_sig_sr = 0:true_bs:1;
	% next we will construct a signal that will be
	% at the resolution of our sample_number. this is
	% the signal going into the dtft.
	samp_bs = 1/sample_number;
	samp_sig_sr = 0:samp_bs:1;
%% construct our example waves
	% nyquist limit
	nl = sample_number/2;

	% construct our signals
	amp = 1;
	freq = 1;
	offset = 0;
	phase = 0;
	true_sig = sf_sin_wv(true_sig_sr,amp,freq,offset,phase); % signal at a high resolution, the signal 'you' are 'sampling'
	samp_sig = sf_sin_wv(samp_sig_sr,amp,freq,offset,phase); % the signal at the 'sampled' resolution.
	                                                         % in this case you are sampling it <sample_number> times.
	sig_nl_full = sf_sin_wv(true_sig_sr, amp, nl, offset, phase); % the frequency at the nl
	sig_lnl = sf_sin_wv(samp_sig_sr,amp,nl-1,offset, phase); % the frequency one cycle less than nl
	sig_lnr = sf_sin_wv(samp_sig_sr,amp,nl+1,offset, phase); % the frequency one cycle larger than the nl
	sig_lnl_full = sf_sin_wv(true_sig_sr,amp,nl-1,offset, phase);	
	sig_lnr_full = sf_sin_wv(true_sig_sr,amp,nl+1,offset, phase);	
	samp_cmplx = sf_comp_wv(samp_sig_sr,amp,nl-1,offset, phase);	
	true_cmplx = sf_comp_wv(true_sig_sr,amp,nl-1,offset, phase);	

%% make the figure to drive the point home
	fh = figure();
	ah = axes();
	lh(1) = line(true_sig_sr, true_sig, 'linestyle', '-', 'marker', 'none', 'color', 'r', 'parent', ah);
	lh(2) = line(samp_sig_sr, samp_sig, 'linestyle', 'none', 'marker', '^', 'color', 'r', 'parent', ah);
	legend(lh(:),{'the signal we are sampling', 'the samples from the signal'});
	title('sampling a frequency');
	fh2 = figure();
	ah2 = axes('parent',fh2);
	% true resolution
	lh2(4) = line(true_sig_sr, real(sig_lnl_full), imag(sig_lnl_full),'linestyle', '-', 'marker', 'none', 'color', 'r');
	lh2(5) = line(true_sig_sr, real(sig_lnr_full), imag(sig_lnl_full),'linewidth', 1.5,'linestyle', '-', 'marker', 'none', 'color', 'b');
	lh2(6) = line(true_sig_sr, real(-sig_lnl_full), imag(-sig_lnl_full),'linewidth', 1.5, 'linestyle', '-', 'marker', 'none', 'color', 'g');
	% sampled resolution 
	lh2(1) = line(true_sig_sr, real(sig_nl_full), imag(sig_nl_full), 'linestyle', '-', 'marker', 'none', 'color', 'k');
	lh2(2) = line(samp_sig_sr, real(sig_lnl), imag(sig_lnl),'linestyle', 'none', 'marker', '^', 'markerfacecolor', 'r',...
	 'markersize',8, 'color', 'r');
	lh2(3) = line(samp_sig_sr, real(sig_lnr), imag(sig_lnl),'linestyle', 'none', 'marker', 'v', 'markerfacecolor', 'b',...
	 'markersize',8, 'color', 'b');
	% pretty
	legend(lh2(:), {'nyquist limit of this signal', 'sampled frequency, one less than nyquist',...
	 'sampled frequency, one larger than nyquist', 'complete frequency less than ny',...
	 'complete frequency one larger than  ny', 'negative of the frequency less the nyquist limit'});
	axis(ah2,[0 1 -amp amp*2]); %hacky get legend out of the way
%% now lets look at how this would operate in the dtft, aka dot product
	% dot product -- complex values
	comp_amp_lnl = (dot(sig_lnl,samp_cmplx));
	comp_amp_lnr = (dot(sig_lnr,samp_cmplx));
	% amplitude sqrt((real()^2+imag()^2)); 
	amp_lnl = abs(comp_amp_lnl);
	amp_lnr = abs(comp_amp_lnr);
	% print a useful blurb.
	fprintf(['the dot product of the frequency one frequency one larger than the',...
	 'nyquist limit is %s, its amplitude is %2.2d\n'],num2str(comp_amp_lnl),amp_lnl);
	fprintf(['the dot product of the frequency one frequency to the left of the',...
	 'nyquist limit is %s, its amplitude is %2.2d\n'],num2str(comp_amp_lnr),amp_lnr);
% negative_frequency_dtft end
end

% =========== subfunctions =========== %
function wv = sf_sin_wv(evaluate_points,amp,freq,offset,phase);
wv = amp * sin(2*pi * freq * (evaluate_points + phase)); 
end
function wv = sf_cos_wv(evaluate_points,amp,freq,offset,phase);
wv = amp * cos(2*pi * freq * (evaluate_points + phase)); 
end
function cwv = sf_comp_wv(evaluate_points, amp, freq, offset, phase);
cwv = amp * exp(-j * 2*pi * (evaluate_points + phase));
end
