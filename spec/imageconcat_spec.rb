require 'minitest/autorun'
require 'minitest/spec'
require 'imageconcat'


describe ImageConcat do
  before do
    @concatenator = ImageConcat.new
  end

  it "loads an image file" do
    @concatenator.load_image("spec/resources/ruby.png").must_be_instance_of Magick::Image
  end

  it "loads more than one image file" do
    @concatenator.add_image("spec/resources/ruby.png")
    @concatenator.add_image("spec/resources/ruby.png")
    
    @concatenator.images.count.must_equal 2
    
  end
  
  it "writes a new image with the width of all the loaded images" do
    @concatenator.add_image("spec/resources/ruby.png")
    @concatenator.add_image("spec/resources/go.png")
    @concatenator.add_image("spec/resources/php.png")    
    @concatenator.concatenate.must_be_instance_of Magick::Image
    @concatenator.concatenate.columns.must_equal 384
    @concatenator.concatenate.rows.must_equal 128
  end
  
  it "the resulting image has the size of the biggest image" do
    @concatenator.add_image("spec/resources/ruby.png")
    @concatenator.add_image("spec/resources/mariadb_irregular.png")
    @concatenator.add_image("spec/resources/php.png")    
    @concatenator.concatenate.rows.must_equal 175
  end

  
  
end

