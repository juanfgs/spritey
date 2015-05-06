require 'rmagick'
require 'pathname'

class Spritey
  attr_accessor :images,:max_height
  
  def initialize
    @images = []
    @max_height = 0
  end
  


  def add_image(filename)
    image = load_image(filename)
    @max_height = image.rows unless image.rows < @max_height
    @images.push image
  end



  def save_css(filename)
    concatenate
    css_file = File.open(filename, "w")
    css_file.write generate_sprites_css
    css_file.close
  end


  
  def load_image(filename)
    Magick::Image::read(filename)[0]    
  end

  def concatenate
    raise RuntimeError unless @images.any?

    new_image = Magick::Image.new(total_width,@max_height){
      self.format = 'png'
      self.background_color = 'none'
    }
    
    last_width = 0

    @images.each do |img|
      img.alpha Magick::BackgroundAlphaChannel
      new_image.composite!(img,last_width, 0, Magick::OverCompositeOp )
      last_width += img.columns      
    end
    puts "Total image size #{total_width},#{@max_height}"    
    new_image.write("composite.png")
  end

  def generate_sprites_css
    last_width = 0
    dest_css = ""
    @images.each do |img|
      image_name = Pathname.new(img.filename).basename.to_s.split(".")
      dest_css += "##{image_name[0]} {"
      dest_css += "display:block;"
      dest_css += "width:#{img.columns}px;"
      dest_css += "height:#{img.rows}px;"      
      dest_css += "background-image:url(composite.png);"
      dest_css += "background-repeat:no-repeat;"      
      dest_css += "background-position: -#{last_width}px 0px ;"      
      dest_css += "}\n"
      last_width += img.columns
    end
    dest_css
  end
  
  def total_width
    width = 0
    @images.each do |image|
      width += image.columns
    end
    width
  end
  

  
end
