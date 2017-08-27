function [data, sources, source_coords, measurement_coords] = make_data(...
	n_sources, len, noise, n_measurements)

	% generate 2-dimensional sources and their positions
	sources = create_noisy_sources(n_sources, len, noise);

	% generate positions for sources
	source_coords = rand(n_sources, 3);

	% generate positions for measurements
	measurement_coords = snap_to_sphere(rand(n_measurements,3));

	% create measured data 
	data = measure_sources(sources, source_coords, measurement_coords);

end

function data = measure_sources(sources, source_coords, measurement_coords)
% assume linear falloff and additive influence (stupidest model)
% input is a series of localized source timeseries and measurement positions

	n_sources = size(source_coords,1);
	n_measurements = size(measurement_coords,1);

	% add up influence of sources
	data = zeros(n_measurements, size(sources,2));

	for m = 1:n_measurements
		for s = 1:n_sources
			distance = norm(source_coords(s,:) - measurement_coords(m,:),2);
			data(m,:) = data(m,:) + sources(s,:) * (1 / distance);
		end
	end

end
