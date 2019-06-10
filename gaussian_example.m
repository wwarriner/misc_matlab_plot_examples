rng( 1 );

x = normrnd( 0, 1, [ 250, 1 ] );
pd = fitdist( x, 'normal' );
mu = pd.mu;
x = x - mu;
pd = fitdist( x, 'normal' );

fh = figure();
fh.Color = 'w';
axh = axes( fh );
hold( axh, 'on' );

axh.XLim = [ -3 3 ];
dx = diff( axh.XLim );
dx = 0.025 * [ -dx dx ];
axh.YLim = [ 0 0.5 ];

t = linspace( axh.XLim( 1 ), axh.XLim( 2 ), 1000 );
plot( t, pdf( pd, t ), 'k-' );

nci = -1.28;
pci = -nci;
inside = ( nci < x ) & ( x < pci );

plot( x( inside ), zeros( size( x( inside ) ) ), 'k.' );
plot( x( ~inside ), zeros( size( x( ~inside ) ) ), 'k.' );

plot( [ nci nci ], [ 0 pdf( pd, nci ) ], 'k-' );
plot( [ pci pci ], [ 0 pdf( pd, pci ) ], 'k-' );

axis( axh, 'square' );
apply_axis_formats( axh, 'plain', 'none' );

cc = Colors();
axh.Children( 1 ).Color = 'k';
axh.Children( 2 ).Color = 'k';
axh.Children( 3 ).Color = cc.ORANGE;
axh.Children( 3 ).MarkerSize = 12;
axh.Children( 3 ).LineWidth = 2;
axh.Children( end - 1 ).Color = cc.LIGHT_GRAY;
axh.Children( end - 1 ).MarkerSize = 12;
axh.Children( end - 1 ).LineWidth = 2;
axh.Children( end ).Color = cc.BLUE;
axh.Children( end ).LineWidth = 2;