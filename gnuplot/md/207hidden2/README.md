## pm3d hidden surfaces
[Original Demo](http://gnuplot.sourceforge.net/demo_4.6/hidden2.html)

### 1

```ruby
# # PM3D surfaces are not fully included in the calculation of hidden line removal.
# # Older versions of gnuplot allowed you to approximate the correct occlusion
# # by drawing the surface twice, once "with pm3d" to produce the surface you
# # want to show, and once "with lines lt -2" to include the same surface in
# # hidden3d calculations but drawn with invisible lines.
# # Current gnuplot does the approximation for you so the extra copy of the
# # surface is no longer necessary.
# #
# set isosamples 25,25
# set xyplane at 0
# unset key
#
# set palette rgbformulae 31,-11,32
# set style fill solid 0.5
# set cbrange [-1:1]
#
# set title "Mixing pm3d surfaces with hidden-line plots"
#
# f(x,y) = sin(-sqrt((x+5)**2+(y-7)**2)*0.5)
#
# set hidden3d front
# splot f(x,y) with pm3d, x*x-y*y with lines lc rgb "black"

Numo.gnuplot do
  set isosamples:[25,25]
  set :xyplane, at:0
  unset :key
  set :palette, rgbformulae:[31,-11,32]
  set :style, fill_solid:0.5
  set cbrange:-1..1
  set title:"Mixing pm3d surfaces with hidden-line plots"
  run "f(x,y) = sin(-sqrt((x+5)**2+(y-7)**2)*0.5)"
  set :hidden3d, :front
  splot ["f(x,y)", with:"pm3d"],
    ["x*x-y*y", with:"lines", lc_rgb:"black"]
end
```
![207hidden2/001](https://raw.githubusercontent.com/ruby-numo/numo-gnuplot-demo/master/gnuplot/md/207hidden2/image/001.png)

### 2

```ruby
# reset
#
# #
# # Another example of pm3d hidden surface removal,
# # this time using pm3d depth-ordering
# #
# set multiplot title "Interlocking Tori"
# set title "PM3D surface\nno depth sorting"
#
# set parametric
# set urange [-pi:pi]
# set vrange [-pi:pi]
# set isosamples 50,20
#
# set origin -0.02,0.0
# set size 0.55, 0.9
#
# unset key
# unset xtics
# unset ytics
# unset ztics
# set border 0
# set view 60, 30, 1.5, 0.9
# unset colorbox
#
# set pm3d scansbackward
# splot cos(u)+.5*cos(u)*cos(v),sin(u)+.5*sin(u)*cos(v),.5*sin(v) with pm3d, \
#       1+cos(u)+.5*cos(u)*cos(v),.5*sin(v),sin(u)+.5*sin(u)*cos(v) with pm3d
#
# set title "PM3D surface\ndepth sorting"
#
# set origin 0.40,0.0
# set size 0.55, 0.9
# set colorbox vertical user origin 0.9, 0.15 size 0.02, 0.50
# set format cb "%.1f"
#
# set pm3d depthorder
# splot cos(u)+.5*cos(u)*cos(v),sin(u)+.5*sin(u)*cos(v),.5*sin(v) with pm3d, \
#       1+cos(u)+.5*cos(u)*cos(v),.5*sin(v),sin(u)+.5*sin(u)*cos(v) with pm3d
#
# unset multiplot

Numo.gnuplot do
  reset
  set :multiplot, title:"Interlocking Tori"
  set title:"PM3D surface\nno depth sorting"
  set :parametric
  set urange:"[-pi:pi]"
  set vrange:"[-pi:pi]"
  set isosamples:[50,20]
  set origin:[-0.02,0.0]
  set size:[0.55,0.9]
  unset :key
  unset :xtics
  unset :ytics
  unset :ztics
  set border:0
  set view:[60,30,1.5,0.9]
  unset :colorbox
  set pm3d:"scansbackward"
  splot "cos(u)+.5*cos(u)*cos(v)",
    "sin(u)+.5*sin(u)*cos(v)",
    [".5*sin(v)", with:"pm3d"],
    "1+cos(u)+.5*cos(u)*cos(v)",
    ".5*sin(v)",
    ["sin(u)+.5*sin(u)*cos(v)", with:"pm3d"]
  set title:"PM3D surface\ndepth sorting"
  set origin:[0.40,0.0]
  set size:[0.55,0.9]
  set :colorbox, :vertical, "user", origin:[0.9,0.15], size:[0.02,0.50]
  set format_cb:"%.1f"
  set pm3d:"depthorder"
  splot "cos(u)+.5*cos(u)*cos(v)",
    "sin(u)+.5*sin(u)*cos(v)",
    [".5*sin(v)", with:"pm3d"],
    "1+cos(u)+.5*cos(u)*cos(v)",
    ".5*sin(v)",
    ["sin(u)+.5*sin(u)*cos(v)", with:"pm3d"]
  unset :multiplot
end
```
![207hidden2/002](https://raw.githubusercontent.com/ruby-numo/numo-gnuplot-demo/master/gnuplot/md/207hidden2/image/002.png)
