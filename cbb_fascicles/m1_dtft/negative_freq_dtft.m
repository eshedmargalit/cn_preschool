function [fh,ah,lh] = negative_frequency_dtft(sample_number)
%% NEGATIVE_FREQUENCY_DTFT demonstrates negative frequency aliasing
% INPUTS
%	sample_number (scalar): how many samples to create a signal with
% OUTPUTS
%	fh (handle): the figure handle
%	ah (handle): the axes handle
%	lh (array of handles) : the line handles
% AUTHOR
%	Tucker Fisher
%	Eshed Margalit (edits)	
%
% NOTES
%{ 
	In the DTFT, you are taking the dot product between your signal and a 
	bank of "filters" (complex sinusoids) with frequencies linearly spaced
	from 0 cycles/signal_length to sample_number cycles/signal_length. 
	Scaling from [0, sample_number] to [0, 1] , this means that our "filters"
	go from zero frequency to 2 times the Nyquist frequency.
	Due to aliasing, this fact allows for insight into negative frequencies. 
	Let's take a look.

	Note: frequency is not in terms of any sampling rate (such as Hz).
	We are just going to look at this phenomenon in the 'sample number' domain...
	What you will notice is that the frequency one higher than the Nyquist
	frequency aliases to the negative of the frequency one smaller than the
	Nyquist frequency.
%}
%% set up different samplings for the same amount of 'time' 
	% given then number of samples, create a time axis that spans [0,1]
	sampling_rate = 1/sample_number;
	samples = 0:sampling_rate:1;

	% for visualization, also create a time axis that is more densely 
	% sampled than our actual signal
	true_rate = .01;
	if sampling_rate <= true_rate
		warning(['You will now be aliasing the true signal,',...
		 ' lower your sample number!']);
	end
	true_samples = 0:true_rate:1;

%% construct our example waves
	% nyquist limit
	nyquist_limit = sample_number/2;

	% signal parameters 
	amp = 1;
	freq = 1;
	offset = 0;
	phase = 0;

	% signal at a high resolution, for visualization
	true_signal = sf_sin_wv(true_samples,...
		amp, freq, offset, phase);  

	% the signal at the sampled resolution
	signal = sf_sin_wv(samples,...
		amp, freq, offset, phase);

	% true and standard sine waves at the Nyquist frequency
	true_nyquist_wave = sf_comp_wv(true_samples,...
		amp, nyquist_limit, offset, phase);

	nyquist_wave = sf_comp_wv(samples,...
		amp, nyquist_limit, offset, phase);

	% true and standard sine waves at +/- 1 of the Nyquist frequency
	true_left_of_nyquist_wave = sf_comp_wv(true_samples,...
		amp, nyquist_limit-1, offset, phase);

	left_of_nyquist_wave = sf_comp_wv(samples,...
		amp, nyquist_limit-1, offset, phase);

	true_right_of_nyquist_wave = sf_comp_wv(true_samples,...
		amp, nyquist_limit+1, offset, phase);

	right_of_nyquist_wave = sf_comp_wv(samples,...
		amp, nyquist_limit+1, offset, phase);

	% complex wave at frequency one smaller than the Nyquist frequency
	complex = sf_comp_wv(samples,...
		amp, nyquist_limit-1, offset, phase);

%% make the figure to drive the point home
%% Figure 1: Comparison of real signal and our sampling of it
	fh = figure();
	ah = axes('parent',fh);

	% plot the true signal
	lh(1) = line(true_samples, true_signal, 'linestyle', '-',...
		'marker', 'none', 'color', 'r', 'parent', ah);

	% plot the signal
	lh(2) = line(samples, signal, 'linestyle', 'none',...
		'marker', '^', 'color', 'r', 'parent', ah);

	% create legend for this figure
	legend(lh(:),{'True Signal', 'Our Sampled Signal'});
	title('Sampling a Signal');

%% Figure 2: Looking at waves around the Nyquist frequency
	fh2 = figure();
	ah2 = axes('parent',fh2);

	% plot a wave at the nyquist frequency 
	lh2(1) = line(true_samples, real(true_nyquist_wave),...
		imag(true_nyquist_wave), 'linestyle', '-', 'marker', 'none',...
		'color', 'k', 'parent', ah2);

	% plot sine wave one freq lower than nyquist
	lh2(2) = line(samples, real(left_of_nyquist_wave),...
		imag(left_of_nyquist_wave),'linestyle', 'none', 'marker', '^',...
		'markerfacecolor', 'r', 'markersize',8, 'color', 'r',...
		'parent',ah2);

	% plot sine wave one freq higher than nyquist
	lh2(3) = line(samples, real(right_of_nyquist_wave),...
		imag(right_of_nyquist_wave),'linestyle', 'none', 'marker', 'v',...
		'markerfacecolor', 'b','markersize',8, 'color', 'b',...
		'parent',ah2);

	lh2(4) = line(true_samples, real(true_left_of_nyquist_wave),...
		imag(true_left_of_nyquist_wave),'linestyle', '-', 'marker',...
		'none', 'color', 'r','parent',ah2);

	lh2(5) = line(true_samples, real(true_right_of_nyquist_wave),...
		imag(true_right_of_nyquist_wave),'linewidth', 1.5,'linestyle',...
		'-', 'marker', 'none', 'color', 'b','parent',ah2);

	lh2(6) = line(true_samples, real(-true_left_of_nyquist_wave),...
		imag(-true_left_of_nyquist_wave),'linewidth', 1.5,...
		'linestyle', '-', 'marker', 'none', 'color', 'g','parent',ah2);
	xlabel('samples');
	ylabel('real');
	zlabel('imag');

	% create legend for this figure 
	legend(lh2(:), {'Nyquist limit of this signal',...
		'sampled frequency, one less than Nyquist',...
	 	'sampled frequency, one larger than Nyquist',...
		'complete frequency less than ny',...
		'complete frequency one larger than ny',...
		'negative of the frequency less the Nyquist limit'});

	% get legend out of the way
	axis(ah2,[0 1 -amp amp*2 -amp amp*2]); 
	
	% adjust view, rotate into samples, imag so that aliasing is clear
	view([0,0]);

%% now lets look at how this would operate in the dtft, aka dot product
	% dot product -- complex values
	comp_amp_lnyquist_limit = dot(left_of_nyquist_wave, complex);
	comp_amp_lnr = dot(right_of_nyquist_wave, complex);

	% amplitude = sqrt((real()^2+imag()^2)); 
	amp_lnyquist_limit = abs(comp_amp_lnyquist_limit);
	amp_lnr = abs(comp_amp_lnr);

	% print a useful blurb.
	fprintf(['The dot product of the frequency one larger than the ',...
		'Nyquist limit is %s, its amplitude is %2.2d\n'],...
		num2str(comp_amp_lnyquist_limit),amp_lnyquist_limit);

	fprintf(['The dot product of the frequency one smaller than the ',...
	 'Nyquist limit is %s, its amplitude is %2.2d\n'],...
	 num2str(comp_amp_lnr),amp_lnr);

% negative_frequency_dtft end
end

% =========== subfunctions =========== %
function wv = sf_sin_wv(evaluate_points,amp,freq,offset,phase);
	wv = amp * sin(2*pi * freq * (evaluate_points + phase)); 
end
function cwv = sf_comp_wv(evaluate_points, amp, freq, offset, phase);
	cwv = amp * exp(-j * 2*pi * freq * (evaluate_points + phase));
end
