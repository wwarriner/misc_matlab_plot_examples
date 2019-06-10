ideal = 1200;
ix = 40;
iy = ideal / ix;
ideal_im = true( ix, iy );

curr = 165;
cy = 15;
curr_im = false( cy, iy );
curr_im( 1 : curr ) = true;

thresh = 150;
ty = 15;
tx = 10;

prev = 16;
py = 4;
prev_im = false( py, iy );
prev_im( 1 : prev ) = true;

fh = figure();
fh.Color = 'w';
fh.Position = [ 50 50 720 540 ];

axh = axes( fh );
axh.XLim = [ 0 ix + 1 ];
axh.YLim = [ 0 iy + 1];
axh.DataAspectRatio = [ 1 1 1 ];
axh.PlotBoxAspectRatio = [ 1 1 1 ];
hold( axh, 'on' );
axis( axh, 'off' );

cc = Colors();
cmap = [ ...
    cc.LIGHT_GRAY; ...
    cc.LIGHT_GRAY; ...
    cc.ORANGE; ...
    cc.BLUE;
    ];
colormap( axh, cmap );

[ x, y ] = size( ideal_im );
im = double( ideal_im ).';
X = linspace( 0, x - 1, x ) + 0.5;
Y = linspace( 0, y - 1, y ) + 0.5;
imh = imagesc( X, Y, 0 * im );
imh.AlphaData = im;
th = text( 0, iy, sprintf( 'Last Year: %i', prev ) );
th.VerticalAlignment = 'bottom';
th.FontSize = 18;
th.FontName = 'calibri';

[ x, y ] = size( curr_im );
im = flipud( double( curr_im ).' );
X = linspace( 0, x - 1, x ) + 0.5;
Y = linspace( 0, y - 1, y ) + 0.5;
imh = imagesc( X, Y, 1 * im );
imh.AlphaData = im;
th = text( 0, iy - ceil( curr / cy ), sprintf( 'Current: %i', curr ) );
th.VerticalAlignment = 'top';
th.FontSize = 18;
th.FontName = 'calibri';

[ x, y ] = size( prev_im );
im = flipud( double( prev_im ).' );
X = linspace( 0, x - 1, x ) + 0.5;
Y = linspace( 0, y - 1, y ) + 0.5;
imh = imagesc( X, Y, 2 * im );
imh.AlphaData = im;
th = text( 0, 0, sprintf( 'Ideal: %i', ideal ) );
th.VerticalAlignment = 'top';
th.FontSize = 18;
th.FontName = 'calibri';

% d = 0.1;
% dx = [ 1 1 -1 -1 ] * d;
% dy = [ 1 -1 -1 1 ] * d;
% ph = patch( [ 0 ty ty 0 ] + dy, iy - [ 0 0 tx tx ] - dx, 'k' );
% ph.EdgeColor = 'k';
% ph.LineStyle = ':';
% ph.LineWidth = 2;
% ph.FaceAlpha = 0;

[ x, y ] = size( ideal_im );
x = x + 1;
y = y + 1;
im = zeros( x, y ).';
X = linspace( 0, x - 1, x );
Y = linspace( 0, y - 1, y );
[ X, Y ] = meshgrid( X, Y );
ph = pcolor( X, Y, im );
ph.FaceColor = 'none';
ph.EdgeColor = 'k';
ph.EdgeAlpha = 0.5;
ph.LineStyle = ':';


% pcolor( [ 0 ix ], [ 0 cy ], curr_im );
% pcolor( [ 0 ix ], [ 0 py ], curr_im );
