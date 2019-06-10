%% set seed
rng( 314159 )

%% generate random gaussian data
counts = [ 10000 2000 1500 ];
means = [ ...
    8 -3 0; ...
    3 -5 -10; ...
    ];
sigmas = [ ...
    1 2 1; ...
    3 0.67 1.5 ...
    ];
angles = [ pi/3 -15*pi/17 -pi/2 ];
vals = cell( numel( counts ), 1 );
for i = 1 : numel( counts )
    
    sample = [ ...
        normrnd( means( 1, i ), sigmas( 1, i ), [ counts( i ) 1 ] ) ...
        normrnd( means( 2, i ), sigmas( 2, i ), [ counts( i ) 1 ] ) ...
        ];
    t = angles( i );
    r = [ ...
        cos( t ) -sin( t ); ...
        sin( t ) cos( t ) ...
        ];
    vals{ i } = sample * r;
    
end

x = vertcat( vals{ : } );

%% append uniform random
anom_count = round( 0.01 * sum( counts ) );
sample = [ ...
    unifrnd( min( x( :, 1 ) ), max( x( :, 1 ) ), [ anom_count 1 ] ) ...
    unifrnd( min( x( :, 2 ) ), max( x( :, 2 ) ), [ anom_count 1 ] ) ...
    ];
x = [ x; sample ];

%% setup colors
gray = [ 0.7 0.7 0.7 ];
blue = [ 0.3 0.5 0.75 ];
orange = [ 0.95 0.55 0.20 ];

step = 5;

%% plot raw data
fh = figure();
fh.Color = 'w';
axh = axes( fh );
hold( axh, 'on' );
sh = scatter( axh, x( :, 1 ), x( :, 2 ) );
sh.Marker = '.';
sh.SizeData = 12;
sh.CData = blue;
axis( 'square', 'off' );
axh.DataAspectRatio = [ 1 1 1 ];

%% develop model
gmm = fitgmdist( x, 3 );

%% plot pdf
X = linspace( axh.XLim( 1 ), axh.XLim( 2 ), 100 );
Y = linspace( axh.YLim( 1 ), axh.YLim( 2 ), 100 );
[ XX, YY ] = meshgrid( X, Y );
gmm_pdf = reshape( pdf( gmm, [ XX( : ) YY( : ) ] ), size( XX ) );
fh = figure();
fh.Color = 'w';
axh = axes();
axh.FontName = 'calibri';
axh.FontSize = 18;
imagesc( axh, X, Y, flipud( gmm_pdf ) );
colormap( axh, viridis );
axis( 'square', 'off' );
axh.DataAspectRatio = [ 1 1 1 ];

%% find alpha quantile value by bisection
alpha = 0.2;
bracket = [ 0 1 ];
current = 0.01;
TOL = 0.001;
while true
    
    pvals = pdf( gmm, [ XX( : ) YY( : ) ] );
    pvals( pvals > current ) = 0;
    s = sum( pvals, 'all' );
    d = s - alpha;
    if abs( d ) < TOL
        break;
    end
    if d > 0
        bracket( 2 ) = current;
        current = ( current - bracket( 1 ) ) ./ 2 + bracket( 1 );
    else
        bracket( 1 ) = current;
        current = ( bracket( 2 ) - current ) ./ 2 + current;
    end
    
end

%% plot alpha contour and anomalous data
fh = figure();
fh.Color = 'w';
axh = axes();
axh.FontName = 'calibri';
axh.FontSize = 18;
hold( axh, 'on' );

pvals = pdf( gmm, [ XX( : ) YY( : ) ] );
im = reshape( pvals, size( XX ) );
im = im > current;
[ ~, ch ] = contour( axh, X, Y, im, 1 );
ch.Color = 'k';

gmm_pdf = pdf( gmm, [ x( :, 1 ) x( :, 2 ) ] );
normal = current < gmm_pdf;
shn = scatter( axh, x( normal, 1 ), x( normal, 2 ) );
shn.Marker = '.';
shn.SizeData = 12;
shn.CData = gray;
anomalous = gmm_pdf <= current;
sha = scatter( axh, x( anomalous, 1 ), x( anomalous, 2 ) );
sha.Marker = 'x';
sha.SizeData = 50;
sha.CData = orange;
axis( 'square', 'off' );
axh.DataAspectRatio = [ 1 1 1 ];

