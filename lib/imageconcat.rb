require 'rmagick'

class ImageConcat
  attr_accessor :images,:max_height
  
  def initialize
    @images = []
    @max_height = 0
  end
  
  def load_image(filename)
    Magick::Image::read(filename)[0]    
  end

  def add_image(filename)
    image = load_image(filename)
    @max_height = image.rows unless image.rows < @max_height
    @images.push image
  end

  def concatenate
    raise RuntimeError unless @images.any?
    new_image = Magick::Image.new(total_width,@max_height){
      self.format = 'png'
      self.background_color = 'none'
    }

    last_width = 0
    puts "Composing image..."
    @images.each_with_index do |img,idx|
      puts "Image ##{idx} starts at: #{last_width}"
      img.alpha Magick::BackgroundAlphaChannel
      new_image.composite!(img,last_width, 0, Magick::OverCompositeOp )
      last_width += img.columns      
    end
    puts "Total image size #{total_width},#{@max_height}"    
    new_image.write("composite.png")
  end

  def total_width
    width = 0
    @images.each do |image|
      width += image.columns
    end
    width
  end
  

  
end
