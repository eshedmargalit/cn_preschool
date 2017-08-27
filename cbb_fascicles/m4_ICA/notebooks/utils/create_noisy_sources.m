function sources = create_noisy_sources(n_sources, len, noise)

	sources = zeros(n_sources, len);
	for i = 1:n_sources
		template = create_noiseless_source(len);
		sources(i,:) = template + rand([len,1]) .* noise;
	end

end

function template = create_noiseless_source(len)
	
	hrf_x = 0:20;
	HRF = hrf_x .* exp(-hrf_x/6) - 2 * hrf_x .* exp(-hrf_x/.4);

	impulse_train = randi([0,1],len,1);
	template = conv(impulse_train, HRF,'same');

end
