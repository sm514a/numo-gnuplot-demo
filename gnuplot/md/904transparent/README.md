## transparency
[Original Demo](http://gnuplot.sourceforge.net/demo_4.6/transparent.html)

### 1

```ruby
# # Example of transparent fill areas
# # Ethan A Merritt - Aug 2006
# # NB:
# #    Not all terminal types support transparency
# #    Assumes UTF-8 support for plot titles
# #
# set style fill solid 1.0 noborder
# set style function filledcurves y1=0
# set clip two
#
# Gauss(x,mu,sigma) = 1./(sigma*sqrt(2*pi)) * exp( -(x-mu)**2 / (2*sigma**2) )
# d1(x) = Gauss(x, 0.5, 0.5)
# d2(x) = Gauss(x,  2.,  1.)
# d3(x) = Gauss(x, -1.,  2.)
#
# set xrange [-5:5]
# set yrange [0:1]
#
# unset colorbox
#
# set key title "Gaussian Distribution"
# set key top left Left reverse samplen 1
#
# #set obj 1 rect from graph 0,0 to graph 1,1
# #set obj 1 rect back fs solid 0.25 fc lt 4
#
# set title "Solid filled curves"
# plot d1(x) fs solid 1.0 lc rgb "forest-green" title "μ =  0.5 σ = 0.5", \
#      d2(x) lc rgb "gold" title "μ =  2.0 σ = 1.0", \
#      d3(x) lc rgb "red" title "μ = -1.0 σ = 2.0"

Numo.gnuplot do
  set :style, fill_solid:1.0, noborder:true
  set :style, function:'filledcurves y1=0'
  set clip:"two"
  run "Gauss(x,mu,sigma) = 1./(sigma*sqrt(2*pi)) * exp( -(x-mu)**2 / (2*sigma**2) )"
  run "d1(x) = Gauss(x, 0.5, 0.5)"
  run "d2(x) = Gauss(x, 2., 1.)"
  run "d3(x) = Gauss(x, -1., 2.)"
  set xrange:-5..5
  set yrange:0..1
  unset :colorbox
  set :key, title:"Gaussian Distribution"
  set :key, :top, :left, :Left, :reverse, samplen:1
  set title:"Solid filled curves"
  plot ["d1(x)", fs_solid:1.0, lc_rgb:"forest-green", title:"μ =  0.5 σ = 0.5"],
    ["d2(x)", lc_rgb:"gold", title:"μ =  2.0 σ = 1.0"],
    ["d3(x)", lc_rgb:"red", title:"μ = -1.0 σ = 2.0"]
end
```
![904transparent/001](https://raw.githubusercontent.com/ruby-numo/numo-gnuplot-demo/master/gnuplot/md/904transparent/image/001.png)

### 2

```ruby
# set style fill transparent solid 0.5 noborder
# set title "Transparent filled curves"
# replot

Numo.gnuplot do
  set :style, fill:"transparent", solid:0.5, noborder:true
  set title:"Transparent filled curves"
  replot
end
```
![904transparent/002](https://raw.githubusercontent.com/ruby-numo/numo-gnuplot-demo/master/gnuplot/md/904transparent/image/002.png)

### 3

```ruby
# set style fill pattern 4 bo
# set title "Pattern-filled curves"
# replot

Numo.gnuplot do
  set :style, :fill, pattern:4, bo:true
  set title:"Pattern-filled curves"
  replot
end
```
![904transparent/003](https://raw.githubusercontent.com/ruby-numo/numo-gnuplot-demo/master/gnuplot/md/904transparent/image/003.png)

### 4

```ruby
# set style fill transparent pattern 4 bo
# set title "Transparent pattern-filled curves"
# replot

Numo.gnuplot do
  set :style, fill:"transparent", pattern:4, bo:true
  set title:"Transparent pattern-filled curves"
  replot
end
```
![904transparent/004](https://raw.githubusercontent.com/ruby-numo/numo-gnuplot-demo/master/gnuplot/md/904transparent/image/004.png)
