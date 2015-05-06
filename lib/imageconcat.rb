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
    Magick::Image.new(total_width,max_height)
    @images.each do |img|
      pixels = img.get_pixels(0,0,img.columns,img.rows)
    end
  end


  
  def total_width
    width = 0
    @images.each do |image|
      width += image.columns
    end
    width
  end
  

  
end
