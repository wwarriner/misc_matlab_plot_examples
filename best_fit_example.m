m = exp( 1 );
b = pi;

count = 100;
x = unifrnd( -5, 5, [ count 1 ] );
noise_factor = 1;
y = m .* x + b + normrnd( 0, noise_factor .* b, [ count 1 ] );

% fh = figure();
% fh.Color = 'w';
% axh = axes( fh );
% ph = plot( x, y, 'kx' );
% axis( axh, 'square' );
% axh.DataAspectRatio = [ 1 1 1 ];

fh = figure();
fh.Color = 'w';
axh = axes( fh );
mdl = fitlm( x, y );
mph = plot( mdl );
axis( axh, 'square' );
axh.DataAspectRatio = [ 1 1 1 ];
legend( axh, 'off' );

axh.Title = [];
axh.XLabel = [];
axh.YLabel = [];
apply_axis_formats( axh, 'plain' );
dx = diff( axh.XLim );
dx = 0.025 * [ -dx dx ];
axh.XLim = [ min( x ) max( x ) ] + dx;
dy = diff( axh.YLim );
dy = 0.025 * [ -dy dy ];
axh.YLim = [ min( y ) max( y ) ] + dy;

cc = Colors();
axh.Children( 4 ).Color = cc.LIGHT_GRAY;
axh.Children( 3 ).Color = cc.BLUE;
axh.Children( 3 ).LineWidth = 2;
axh.Children( 2 ).Color = cc.BLUE;
axh.Children( 2 ).LineWidth = 1.5;
axh.Children( 1 ).Color = cc.BLUE;
axh.Children( 1 ).LineWidth = 1.5;