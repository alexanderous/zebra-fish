# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  #include CarrierWaveDirect::Uploader
  include ::CarrierWave::Backgrounder::Delay 

  include CarrierWave::RMagick
  # Include RMagick or MiniMagick support:
  # include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog #carrierwave direct takes care of this. 
  include CarrierWave::MimeTypes
  process :set_content_type

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:

# random try --- delete later...
  #def root 
  #  Rails.root.join 'public/'
  #end

  # carrierwave direct takes care of this below!
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  #  process :scale => [200, 300]
  #
  #  def scale(width, height)
    #  do something
  #  end

  # Create different versions of your uploaded files:

  version :gallery do
    process :resize_to_limit => [1000, 210]
  end

  version :grande do
    process :resize_to_limit => [400, 700]
  end
  
  version :mega do
    process :resize_to_limit => [600, 1000]  
  end
    
  %w[none].each do |color|
    version(color) { process portrait: color }
  end  
  
  def portrait(color)
    manipulate! format: "png" do |source| 

    source = source.resize_to_fill(132,132)
    circle = Magick::Image.new 132, 132
    gc = Magick::Draw.new
    gc.fill 'black'
    gc.circle(66,66,2,66)
    gc.draw circle
   
    mask = circle.blur_image(0,1).negate

    mask.matte = false
    source.matte = true
    source.composite!(mask, Magick::CenterGravity, Magick::CopyOpacityCompositeOp)
    end  
  end  
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  #def extension_white_list
  #   %w(jpg jpeg gif png)
  #end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
  #compute = Fog::Compute.new(:provider => 'AWS', :aws_access_key_id => '[redacted]', :aws_secret_access_key => '[redacted]')
  #storage = Fog::Storage.new(:provider => 'AWS', :aws_access_key_id => '[redacted]', :aws_secret_access_key => '[redacted]')
end
