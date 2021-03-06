## image data
[Original Demo](http://gnuplot.sourceforge.net/demo_4.6/image.html)

### 1

```ruby
# # demo for plotting images using pixels and binary 2d data
# #
# # This demo can be used for terminals supporting image display.
# # Currently supported are:  X11, Aqua, postscript, png, pdf, svg,
# # (e)pslatex, pstex, emf, wxt.
#
# # Prepared by Dan Sebald
# # History:
# #	- Nov   2006 EAM: split into two files
# #	- 9.23. 2003 ds: redone in response to discussion list feedback
# #	- 5. 3. 2003 ds: 1st version
#
# if ((GPVAL_VERSION == 4.3 || GPVAL_VERSION == 4.2) \
# &&  (!strstrt(GPVAL_COMPILE_OPTIONS,"+IMAGE"))) \
#     print ">>> Skipping demo <<<\n" ; \
#     print "This copy of gnuplot was built without support for plotting images" ; \
#     exit ;
#
# print ""
# print "The plotting styles \`image\` and \`rgbimage\` are intended for plotting"
# print "images described in a data file either in the convential ASCII format or"
# print "in a binary format described by the qualifiers \`binary\` and \`using\`."
# print "All pixels have an (x,y) or (x,y,z) coordinate.  These values can be"
# print "included in the data file or implicitly determined with the sampling"
# print "\'array\' key word and sampling periods \'dx\' and \'dy\'.  The key words"
# print "\'rotate\' and, for 3d plots, \'perpendicular\' control orientation."
# print "\nThe data for this image was stored as RGB triples, one byte per channel,"
# print "without (x,y) coordinate information.  This yields a most compact file."
# print "The plotting command is displayed on the graph."
# print ""
# reset
# set title "Larry Ewing's GIMP penguin on vacation basking in\nthe balmy waters off the coast of Murmansk"
# set xrange [-10:137]
# set yrange [-10:157]
# set label "\"I flew here... by plane.  Why?  For the halibut.\"" at 64,135 center
# plot 'blutux.rgb' binary array=(128,128) flipy format='%uchar' with rgbimage

Numo.gnuplot do
  reset
  set title:"Larry Ewing's GIMP penguin on vacation basking in\nthe balmy waters off the coast of Murmansk"
  set xrange:-10..137
  set yrange:-10..157
  set label:"\"I flew here... by plane.  Why?  For the halibut.\"", at:[64,135], center:true
  plot "'blutux.rgb'", binary:'array=(128,128) flipy format="%uchar"', with:"rgbimage"
end
```
![402image/001](https://raw.githubusercontent.com/ruby-numo/numo-gnuplot-demo/master/gnuplot/md/402image/image/001.png)

### 2

```ruby
# reset
#
# print ""
# print "Images are typically stored in a file with the first datum being the"
# print "top, left pixel.  Without the ability to translate coordinates, the"
# print "the result would be an upside down image."
# print ""
# print "The key word \'array\' means an implied sample array is applied"
# print "to generate the locations of file data using the sampling periods"
# print "dx, dy and dz.  The x-dimension is always the contiguous points in"
# print "a binary file.  The y-dimension is the line number which is incremented"
# print "upon the x-dimension reaching the line length.  The z-dimension is"
# print "the plane number which is incremented upon the y-dimension reaching"
# print "the number of lines per plane."
# print ""
# print "To alter the location of the binary data when displayed via the \'plot\'"
# print "command, use the key word \'rotate\' along with changing the sign of dx, dy"
# print "and dz."
# print ""
# set title "Translations of position variables via 'using'"
# set xrange [-10:275]
# set yrange [-10:300]
# unset key
# set label "\"Time for a dip...\"" at 132,285 center
# plot 'blutux.rgb' binary array=(128,128) flipy center=( 64,201 ) format='%uchar' with rgbimage, \
#      'blutux.rgb' binary array=(128,128) flipy rotation=-90d center=(201,201) format='%uchar' with rgbimage, \
#      'blutux.rgb' binary array=(128,128) flip=y rotate=3.1415 center=(201,64) format='%uchar' with rgbimage, \
#      'blutux.rgb' binary array=(128,128) flip=y rot=0.5pi center=(64,64) format='%uchar' using 1:2:3 with rgbimage

Numo.gnuplot do
  reset
  set title:"Translations of position variables via 'using'"
  set xrange:-10..275
  set yrange:-10..300
  unset :key
  set label:"\"Time for a dip...\"", at:[132,285], center:true
  plot ["'blutux.rgb'", binary:'array=(128,128) flipy center=( 64,201 ) format="%uchar"', with:"rgbimage"],
    ["'blutux.rgb'", binary:'array=(128,128) flipy rotation=-90d center=(201,201) format="%uchar"', with:"rgbimage"],
    ["'blutux.rgb'", binary:'array=(128,128) flip=y rotate=3.1415 center=(201,64) format="%uchar"', with:"rgbimage"],
    ["'blutux.rgb'", binary:'array=(128,128) flip=y rot=0.5pi center=(64,64) format="%uchar"', using:[1,2,3], with:"rgbimage"]
end
```
![402image/002](https://raw.githubusercontent.com/ruby-numo/numo-gnuplot-demo/master/gnuplot/md/402image/image/002.png)

### 3

```ruby
# reset
#
# print ""
# print "There is the ability to plot both color images and palette based"
# print "images.  This is controlled by the styles \`image\`, which derives"
# print "color information from the current palette, and \`rgbimage\`,"
# print "which requires three components representing the red, blue and"
# print "green primary color scheme."
# print ""
# print "By the way, if you have a mouse active, click the right button"
# print "inside the image to isolate a portion of the image and see what"
# print "happens."
# print ""
# unset key
# set xrange [-10:137]
# set yrange [-10:157]
# set label 1 "\"I am the penguin, GOO GOO GOO JOOB.\"" at 63,140 center
# set title "Palette mode 'image' used to produce psychedelic bird"
# unset colorbox
# plot 'blutux.rgb' binary array=(128,128) flipy format='%uchar%uchar%uchar' using ($1+$2+$3) with image

Numo.gnuplot do
  reset
  unset :key
  set xrange:-10..137
  set yrange:-10..157
  set :label, 1, "\"I am the penguin, GOO GOO GOO JOOB.\"", at:[63,140], center:true
  set title:"Palette mode 'image' used to produce psychedelic bird"
  unset :colorbox
  plot "'blutux.rgb'", binary:'array=(128,128) flipy format="%uchar%uchar%uchar"', using:'($1+$2+$3)', with:"image"
end
```
![402image/003](https://raw.githubusercontent.com/ruby-numo/numo-gnuplot-demo/master/gnuplot/md/402image/image/003.png)

### 4

```ruby
# reset
#
# print ""
# print "Naturally, as with 3d color surfaces, the palette may be changed."
# print "This is an example of gray scale."
# print ""
# print "Also, notice in the plot command the key word \'flipy\'.  This"
# print "means to change the direction of the sample along the y dimension"
# print "and is useful for the situation where images or other data are"
# print "stored in some direction other than that of the Cartesion system."
# print "Alone, \'flipD\' means do flipping in the D (x y or z) direction"
# print "for all records.  Individual records can be controlled using the"
# print "syntax \'flipD=#,...,#\', where # is \'0\' or \'1\'."
# print ""
# unset key
# set xrange [-10:137]
# set yrange [-10:157]
# set tics out
# set label 1 "\"This picture was taken by my friend Ansel Adams.\"" at 63,140 center
# set title "The palette can be changed from color to gray scale"
# set palette gray
# unset colorbox
# plot 'blutux.rgb' binary array=(128,128) flipy format='%uchar%uchar%uchar' using ($1+$2+$3)/3 with image

Numo.gnuplot do
  reset
  unset :key
  set xrange:-10..137
  set yrange:-10..157
  set :tics, :out
  set :label, 1, "\"This picture was taken by my friend Ansel Adams.\"", at:[63,140], center:true
  set title:"The palette can be changed from color to gray scale"
  set :palette, "gray"
  unset :colorbox
  plot "'blutux.rgb'", binary:'array=(128,128) flipy format="%uchar%uchar%uchar"', using:'($1+$2+$3)/3', with:"image"
end
```
![402image/004](https://raw.githubusercontent.com/ruby-numo/numo-gnuplot-demo/master/gnuplot/md/402image/image/004.png)

### 5

```ruby
# unset label 1
#
# print ""
# print "Also, similar to 3d color surface plots, a color box showing the"
# print "palette mapping scheme can be added to the plot.  The default"
# print "location is the right edge of the plot.  The location can be set"
# print "manually using \`set colorbox\` and \`set margin\`."
# print ""
# print "As a prelude to the next graph, resize the plot window to judge"
# print "the refresh speed of the image drawing routine.  Notice that when"
# print "the window is smaller, the image refresh is faster.  There is more"
# print "decimation in the data of the original image and less data to plot."
# print "Furthermore, the window continues to refresh at a reasonable rate"
# print "even when the input image size becomes large (e.g., 1024 x 1024)"
# print "because the number of pixels on the screen remains about the same"
# print "while much of the hi resolution data is decimated."
# print ""
# unset key
# set pm3d map
# set xrange [10:117]
# set yrange [10:117]
# set tics out
# set colorbox
# set cbrange [0:255]
# set title "As with 3d color surfaces, a color box may be added to the plot"
# splot 'blutux.rgb' binary array=(128,128) flipy format='%uchar%uchar%uchar' using ($1+$2+$3)/3 with image

Numo.gnuplot do
  unset label:1
  unset :key
  set :pm3d, :map
  set xrange:10..117
  set yrange:10..117
  set :tics, :out
  set :colorbox
  set cbrange:0..255
  set title:"As with 3d color surfaces, a color box may be added to the plot"
  splot "'blutux.rgb'", binary:'array=(128,128) flipy format="%uchar%uchar%uchar"', using:'($1+$2+$3)/3', with:"image"
end
```
![402image/005](https://raw.githubusercontent.com/ruby-numo/numo-gnuplot-demo/master/gnuplot/md/402image/image/005.png)

### 6

```ruby
# print ""
# print "The \'rotation\' key word works not only with angles of integer"
# print "multiples of 90 degrees but also arbitrary rotations.  When"
# print "constructing an image, Gnuplot verifies that pixel locations"
# print "form a valid grid.  Pixel widths are based upon the grid"
# print "spacing.  If the image orientation is aligned with the view"
# print "axes, Gnuplot uses an efficient image driver routine.  Otherwise,"
# print "individual pixels are drawn using polygon shapes."
# print ""
# print "Resize this window and compare the plot's refresh rate to that of"
# print "the previous and next plot.  Notice how in this example if the"
# print "window is small the image refresh does not speed up.  Unlike the"
# print "image routine where image data is decimated, all color rectangles"
# print "must be redrawn no matter the size of the output image."
# print ""
# print "Also notice how the center of the image matches the tuple specified"
# print "with the key word \'center\' in the plot command.  Before doing the"
# print "rotation, the image's natural center is subtracted, and after doing"
# print "the rotation, the specified center is added."
# print ""
# set key
# set xrange [-10:138]
# set yrange [-10:138]
# set tics out
# set title "Polygons used to draw pixels for rotated images\nNotice the slower refresh rate than for the next plot"
# unset colorbox
# plot 'blutux.rgb' binary array=(128,128) dx=0.70711 dy=0.70711 flipy rotation=45d center=(63.5,63.5) format='%uchar' using ($1+$2+$3)/3 with image

Numo.gnuplot do
  set :key
  set xrange:-10..138
  set yrange:-10..138
  set :tics, :out
  set title:"Polygons used to draw pixels for rotated images\nNotice the slower refresh rate than for the next plot"
  unset :colorbox
  plot "'blutux.rgb'", binary:'array=(128,128) dx=0.70711 dy=0.70711 flipy rotation=45d center=(63.5,63.5) format="%uchar"', using:'($1+$2+$3)/3', with:"image"
end
```
![402image/006](https://raw.githubusercontent.com/ruby-numo/numo-gnuplot-demo/master/gnuplot/md/402image/image/006.png)

### 7

```ruby
# reset
#
# print ""
# print "The image of this plot is rotated 90 degrees and can utilize the"
# print "efficient image functions of terminal drivers.  The plot refresh"
# print "is faster than the previous plot."
# print ""
# print "Furthermore, the image location in this case is specified via the"
# print "\'origin\' key word.  As such, the rotation is done about the origin"
# print "as opposed to the center of the image.  Notice the difference in"
# print "axis ranges."
# print ""
# unset key
# set xrange [-138:10]
# set yrange [-10:138]
# set tics out
# set title "Terminal image routine used to draw plot rotated about origin\nNotice the faster refresh rate than for the previous plot"
# unset colorbox
# plot 'blutux.rgb' binary array=(128,128) dx=1 flip=y rotation=0.5pi origin=(0,0) format='%uchar' using ($1+$2+$3)/3 with image

Numo.gnuplot do
  reset
  unset :key
  set xrange:-138..10
  set yrange:-10..138
  set :tics, :out
  set title:"Terminal image routine used to draw plot rotated about origin\nNotice the faster refresh rate than for the previous plot"
  unset :colorbox
  plot "'blutux.rgb'", binary:'array=(128,128) dx=1 flip=y rotation=0.5pi origin=(0,0) format="%uchar"', using:'($1+$2+$3)/3', with:"image"
end
```
![402image/007](https://raw.githubusercontent.com/ruby-numo/numo-gnuplot-demo/master/gnuplot/md/402image/image/007.png)

### 8

```ruby
# reset
#
# print ""
# print "Algebraic manipulation of the input variables can select various"
# print "components of the image.  Here are three examples where two"
# print "channels--or analogous to the ASCII file, data \"columns\"--are ignored"
# print "This is done by using \`*\` in the format to indicate that a variable"
# print "of a certain size should be discarded.  For example, to select the"
# print "green channel, \`%*uchar%uchar%*uchar\` is one alternative."
# print ""
# set size 1.0, 1.0
# set origin 0.0, 0.0
# set multiplot
# set size 0.5,0.48
# set origin 0.0,0.47
# unset key
# set xrange [-0.5:127.5]
# set yrange [-0.5:127.5]
# set tics out
# set label 1 "Selection of the input channels via \`using\`" at 140,160 center
# set title '"I do impersonations..."' offset 0,-0.5
# plot 'blutux.rgb' binary array=(128,128) flip=y format='%uchar' using 1:2:3 with rgbimage
# unset label 1
# set size 0.5,0.48
# set origin 0.5,0.47
# set title '"A cardinal."'
# plot 'blutux.rgb' binary array=(128,128) flip=y format='%uchar%*uchar%*uchar' using 1:(0):(0) with rgbimage
# set size 0.5,0.48
# set origin 0.0,0.0
# set title '"A parrot."'
# plot 'blutux.rgb' binary array=(128,128) flipy format='%*uchar%uchar%*uchar' using (0):1:(0) with rgbimage
# set size 0.5,0.48
# set origin 0.5,0.0
# set title '"A bluebird."'
# plot 'blutux.rgb' binary array=(128,128) flipy format='%*uchar%*uchar%uchar' using (0):(0):1 with rgbimage
# unset multiplot

Numo.gnuplot do
  reset
  set size:[1.0,1.0]
  set origin:[0.0,0.0]
  set :multiplot
  set size:[0.5,0.48]
  set origin:[0.0,0.47]
  unset :key
  set xrange:-0.5..127.5
  set yrange:-0.5..127.5
  set :tics, :out
  set :label, 1, "Selection of the input channels via 'using'", at:[140,160], center:true
  set title:'"I do impersonations..."', offset:[0,-0.5]
  plot "'blutux.rgb'", binary:'array=(128,128) flip=y format="%uchar"', using:[1,2,3], with:"rgbimage"
  unset label:1
  set size:[0.5,0.48]
  set origin:[0.5,0.47]
  set title:'"A cardinal."'
  plot "'blutux.rgb'", binary:'array=(128,128) flip=y format="%uchar%*uchar%*uchar"', using:'1:(0):(0)', with:"rgbimage"
  set size:[0.5,0.48]
  set origin:[0.0,0.0]
  set title:'"A parrot."'
  plot "'blutux.rgb'", binary:'array=(128,128) flipy format="%*uchar%uchar%*uchar"', using:'(0):1:(0)', with:"rgbimage"
  set size:[0.5,0.48]
  set origin:[0.5,0.0]
  set title:'"A bluebird."'
  plot "'blutux.rgb'", binary:'array=(128,128) flipy format="%*uchar%*uchar%uchar"', using:'(0):(0):1', with:"rgbimage"
  unset :multiplot
end
```
![402image/008](https://raw.githubusercontent.com/ruby-numo/numo-gnuplot-demo/master/gnuplot/md/402image/image/008.png)

### 9

```ruby
# reset
#
# print ""
# print "The range of valid pixel values can be set via \`cbrange\`.  If the"
# print "\`cbrange\` is in autoscale mode, gnuplot will set the color scale"
# print "range of RGB images to [0:255] (8 bits of color info per channel)."
# print "This is the case in the upper left image.  However, the image can be"
# print "saturated by choosing a smaller range, as done in the upper right image."
# print "Expanding the colorbox range will darken the image as in the bottom examples."
# print ""
# set size 1.0, 1.0
# set origin 0.0, 0.0
# set multiplot
# set size 0.5,0.48
# set origin 0.0,0.47
# unset key
# set xrange [-0.5:127.5]
# set yrange [-0.5:127.5]
# set tics out
# set label 1 "Luminance adjustment via \`cbrange\`" at 140,160 center
# set title 'Lake Mendota, "or Wonk-sheck-ho-mik-la!"' offset 0,-0.5
# set cbrange [*:*]
# plot 'blutux.rgb' binary array=(128,128) flipy format='%uchar' using 1:2:3 with rgbimage
# unset label 1
# set size 0.5,0.48
# set origin 0.5,0.47
# set title '"Lucky I brought sunscreen."'
# set cbrange [0:200]
# plot 'blutux.rgb' binary array=(128,128) flip=y format='%uchar' using 1:2:3 with rgbimage
# set size 0.5,0.48
# set origin 0.0,0.0
# set title 'Sunset on the Terrace'
# set cbrange [0:400]
# plot 'blutux.rgb' binary array=(128,128) flip=y format='%uchar' using (1.5*$1):2:3 with rgbimage
# set size 0.5,0.48
# set origin 0.5,0.0
# set title 'Sultry evening'
# set cbrange [0:400]
# plot 'blutux.rgb' binary array=(128,128) flipy format='%uchar' using 1:2:3 with rgbimage, '-' w points pt 7 ps 6 lt -2, '-' w points pt 7 ps 0.65 lt -2
# 110 100
# e
# 10 95
# 38 120
# 82 102
# 26 82
# 93 108
# 41 99
# 123 84
# e
# unset multiplot

Numo.gnuplot do
  reset
  set size:[1.0,1.0]
  set origin:[0.0,0.0]
  set :multiplot
  set size:[0.5,0.48]
  set origin:[0.0,0.47]
  unset :key
  set xrange:-0.5..127.5
  set yrange:-0.5..127.5
  set :tics, :out
  set :label, 1, "Luminance adjustment via 'cbrange'", at:[140,160], center:true
  set title:'Lake Mendota, "or Wonk-sheck-ho-mik-la!"', offset:[0,-0.5]
  set cbrange:"[*:*]"
  plot "'blutux.rgb'", binary:'array=(128,128) flipy format="%uchar"', using:[1,2,3], with:"rgbimage"
  unset label:1
  set size:[0.5,0.48]
  set origin:[0.5,0.47]
  set title:'"Lucky I brought sunscreen."'
  set cbrange:0..200
  plot "'blutux.rgb'", binary:'array=(128,128) flip=y format="%uchar"', using:[1,2,3], with:"rgbimage"
  set size:[0.5,0.48]
  set origin:[0.0,0.0]
  set title:'Sunset on the Terrace'
  set cbrange:0..400
  plot "'blutux.rgb'", binary:'array=(128,128) flip=y format="%uchar"', using:'(1.5*$1):2:3', with:"rgbimage"
  set size:[0.5,0.48]
  set origin:[0.5,0.0]
  set title:'Sultry evening'
  set cbrange:0..400
  run <<EOL
plot 'blutux.rgb' binary array=(128,128) flipy format='%uchar' using 1:2:3 with rgbimage, '-' w points pt 7 ps 6 lt -2, '-' w points pt 7 ps 0.65 lt -2
110 100
e
10 95
38 120
82 102
26 82
93 108
41 99
123 84
e
EOL
  unset :multiplot
end
```
![402image/009](https://raw.githubusercontent.com/ruby-numo/numo-gnuplot-demo/master/gnuplot/md/402image/image/009.png)
