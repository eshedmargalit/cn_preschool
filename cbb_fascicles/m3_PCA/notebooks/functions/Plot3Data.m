function [fh,axh] = Plot3Data(matrix_3d, varargin)
%% basic usage
% matrix_3d must be a three column matrix
% varargin is an axes handle 

if isempty(varargin)
	fh = figure();
	axh = axes('parent',fh);
elseif ishandle(varargin{1})
	if strcmp(class(varargin{1}),'matlab.graphics.axis.Axes')
		axh = varargin{1};
		fh = get(axh,'parent');
	else
		disp('varargin must be a axes handle')
	end
else
	disp('varargin must be an axes handle')
end


[m,n] = size(matrix_3d);

min_value = min(min(matrix_3d));
max_value = max(max(matrix_3d));
hold on

% show vertical lines to disambiguate 3-D
for row = 1:m;
    plot3(axh,[matrix_3d(row,1),matrix_3d(row,1)], [matrix_3d(row,2), matrix_3d(row,2)], [min_value,matrix_3d(row,3)],'r')
end

% give each sample its own point
plot3(axh,matrix_3d(:,1), matrix_3d(:,2), matrix_3d(:,3), 'bo','MarkerFaceColor','b');

hold off

b = gca;
b.XMinorGrid = 'on';
b.YMinorGrid = 'on';
axis(axh, [min_value, max_value, min_value, max_value, min_value, max_value])
view(axh, [-35,30])
end
