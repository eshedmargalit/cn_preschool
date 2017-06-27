%% CONVOLUTION -- Designed to work through a convolution tutorial for
% cbb meeting
% TGoodroeFisher
%================================%
%fuckit; clear all;
%% conv basics
	% establish sqare wave
	wv = ones(1,50);
	wv(20:30) = 2;
	k = [2 1 0 -1 -2]; % in wavelet analysis later we will have kernels with zero mean
	k = [5 4 3 2 1];
	% convolution
	conv_k_wv = conv(k,wv);
	
	% establish figure
	fh = figure();
	sh(1) = subplot(3,1,1,'parent',fh);
	sh(2) = subplot(3,1,2,'parent',fh);
	sh(3) = subplot(3,1,3,'parent',fh);
	% plot static
	lh(1) = line(1:numel(wv), wv, 'color', 'r','parent',sh(1));
	lh(2) = line(1:numel(k), k, 'color', 'b', 'parent', sh(2));
	lh(3) = line(1:numel(conv_k_wv), conv_k_wv, 'color', 'k', 'parent', sh(3));
	% pretty
	title(sh(1),'wave');
	title(sh(2),'kernel');
	title(sh(3),'convolution');
	axis(sh(1), [0 numel(wv) min(wv) max(wv)]);
	axis(sh(2), [0 numel(wv) min(k) max(k)]);
%% how long is the final product?

%% play through
	% convolution raw materials 
	pad = numel(k)-1;
	zpad_wv = [zeros(1,pad), wv, zeros(1,pad)];%pad wave
	% flick	figure
	fh2 = figure();
	sh2(1) = subplot(3,1,1,'parent',fh2);
	sh2(2) = subplot(3,1,2,'parent',fh2);
	sh2(3) = subplot(3,1,3,'parent',fh2);
	% pretty
	title(sh2(1),'zero padded wave');
	title(sh2(2),'kernel');
	title(sh2(3),'manual convolution');
	axis(sh2(1), [0 numel(zpad_wv) min(zpad_wv) max(zpad_wv)]);
	axis(sh2(2), [0 numel(zpad_wv) min(k) max(k)]);
	axis(sh2(3), [0 numel(zpad_wv) min(conv_k_wv) max(conv_k_wv)]);
	% conv_idx places dot product in correct position
	conv_idx = [1:numel(wv) + pad] + floor(numel(k)/2); % ESHED -- decided this was the clearest way but may not be

	for idx = 1:numel(wv)+pad
		% kernel is wrong way on purpose
		%fl_k = fliplr(k);
		fl_k = k;
		fl_k_position = idx:idx+pad;
		man_conv(idx) = dot(fl_k,zpad_wv(fl_k_position));
		lh2(1) = line(1:numel(zpad_wv), zpad_wv, 'color', 'r','parent',sh2(1));
		lh2(2) = line(fl_k_position, fl_k, 'color', 'b', 'parent', sh2(2));
		lh2(3) = line(conv_idx(1:numel(man_conv)), man_conv, 'color', 'k',...
		 'parent', sh2(3));
		pause(.5)
		delete(lh2(2));
		% did not trim result. remember to get the 'fit' convolution you must
		% take [numel(k)-1]/2 off each end. 
		% also, compare conv_k_wv (matlab convolution) to our man_conv (manual
		% convolution)
	end
			
		



