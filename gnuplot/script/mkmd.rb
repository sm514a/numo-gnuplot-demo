require 'fileutils'

RAW_BASE = "https://raw.githubusercontent.com/ruby-numo/numo-gnuplot-demo/master/gnuplot/md"
DOC_BASE = "https://github.com/ruby-numo/numo-gnuplot-demo/blob/master/gnuplot"
GITHUB_URL = "https://github.com/ruby-numo/numo-gnuplot-demo/tree/master/gnuplot"

def put_code(f,base,img,code)
  f.puts <<EOL

### #{img.to_i}

```ruby
#{code.join}
```
![#{base}/#{img}](#{RAW_BASE}/#{base}/image/#{img}.png)
EOL
end

contents = []

(Dir.glob("[0-9]*.rb").map.sort).each do |rb|
  base = File.basename(rb,".rb")
  FileUtils.mkdir_p("../md/"+base)
  chap = base[0].to_i
  list = (contents[chap] ||= [])

  img = "001"
  gpl = false
  code = []
  r = open(rb,"rt")
  #p s = r.gets.strip
  r.gets
  if /^#+(.*)$/ =~ r.gets
    title = $1.strip
  else
    title = base
  end
  if /^#+(.*)$/ =~ r.gets
    url = $1.strip
  else
    url = nil
  end
  list << [base,title,url]

  while /^require_relative "gpl"/ !~ r.gets
  end

  open("../md/#{base}/README.md","wt") do |w|
    w.puts "## #{title}"
    w.puts "[Original Demo](#{url})" if url
    r.each do |line|
      case line
      when /^gpl do$/
        code << "\nNumo.gnuplot do\n"
      when /^end$/
        code << "end"
        put_code(w,base,img,code)
        gpl = false
        code = []
        img = img.succ
      else
        if !line.strip.empty?
          code << line
        end
      end
    end
  end
end


titles = [
  "Basic 2D plot styles",
  "Math functions and curve fitting",
  "3D plots and surfaces",
  "Coordinate and axis transforms",
  "Binary and Image data",
  "Colors",
  "Sample Applications",
  "Text options",
  "Page Layout",
  "Styles"
]

nimg = `ls ../md/*/image/*.png|wc -w`.strip

open("../README.md","wt") do |w|
  w.puts <<EOL
# Ruby Numo::Gnuplot Demo
Translated from [Gnuplot Demo](http://gnuplot.sourceforge.net/demo_4.6/).

*  [Single page (contains #{nimg} plots!)](#{DOC_BASE}/single.md)

EOL

  contents.each_with_index do |list,i|
    w.print "\n## #{titles[i]}\n\n"
    list.each do |base,title,url|
      w.puts "* [#{title}](#{DOC_BASE}/md/#{base}/README.md)"
    end
  end
end

open("../single.md","wt") do |w|
  w.puts <<EOL
# Ruby Numo::Gnuplot Demo in single page
Translated from [Gnuplot Demo](http://gnuplot.sourceforge.net/demo_4.6/)

* [GitHub](#{GITHUB_URL})

EOL

  Dir.glob("../md/*/README.md").sort.each do |fn|
    w.write open(fn,"r").read
    w.write "\n\n"
  end
end
