require 'minitest/autorun'
require 'minitest/spec'
require 'spritey'
require 'w3c_validators'

include W3CValidators


describe Spritey do
  before (:each) do
    @concatenator = Spritey.new
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
    image = @concatenator.concatenate("composite.png")
    image.must_be_instance_of Magick::Image
    image.columns.must_equal 384
    image.rows.must_equal 128
  end
  
  it "the resulting image has the size of the biggest image" do
    @concatenator.add_image("spec/resources/ruby.png")
    @concatenator.add_image("spec/resources/mariadb_irregular.png")
    @concatenator.add_image("spec/resources/php.png")    
    @concatenator.concatenate("composite.png").rows.must_equal 175
  end

  it "raises error if called without images" do
    proc{@concatenator.concatenate("composite.png")}.must_raise RuntimeError
  end

  it "can create valid css files" do
    
    @val = CSSValidator.new
    
    @concatenator.add_image("spec/resources/ruby.png")
    @concatenator.add_image("spec/resources/mariadb_irregular.png")
    @concatenator.add_image("spec/resources/php.png")
    @val.validate_text(@concatenator.generate_sprites_css).errors.length.must_equal 0

  end

  it "saves the file" do
    @writer = Spritey.new    
    @writer.add_image("spec/resources/ruby.png")
    @writer.add_image("spec/resources/mariadb_irregular.png")
    @writer.add_image("spec/resources/php.png")
    @writer.save_css("sprites")
    File.open("sprites.css").must_be_instance_of File
  end
  
  
end

