function snapped_coords = snap_to_sphere(coords)
% SNAP_TO_SPHERE takes 3d coordinates and finds the nearest point such that 
% the L2-norm of the vector is 1 (on the sphere's surface)
%
% Inputs
%	coords: n x 3 matrix of coordinates, each row is a coordinate to be
% 	snapped separately

	assert(size(coords,2)==3); % could be relaxed at some point

	n_coords = size(coords,1);

	% easily legible solution
	snapped_coords = zeros(n_coords,3);
	for row = 1:n_coords
		snapped_coords(row,:) = coords(row,:)./norm(coords(row,:),2);
	end

	% equivalent vectorized solution 
	%snapped_coords = arrayfun(@(row) coords(row,:)./norm(coords(row,:),2),...
		%1:size(coords,1),'UniformOutput',false);
	%snapped_coords = vertcat(snapped_coords{:})
end
