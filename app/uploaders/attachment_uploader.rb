class AttachmentUploader < CarrierWave::Uploader::Base
  storage :aws

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def size_range
    0.megabytes..20.megabytes
  end
  
  def extension_whitelist
    %w(jpg jpeg gif png pdf xls xlsx csv docx)
  end
end
