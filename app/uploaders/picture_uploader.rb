class PictureUploader < CarrierWave::Uploader::Base
 
  
  include Cloudinary::CarrierWave

  process :convert => 'png'
  process :tags => ['product_picture']

  version :standard do
    process :resize_to_fill => [100, 150, :north]
  end

  version :thumbnail do
    resize_to_fit(50, 50)
  end
 
  #storage :file

  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end
  
  # def public_id
  #   return model.short_name
  # end  
  
end
