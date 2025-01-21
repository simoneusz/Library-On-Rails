class BookPreviewUploader < CarrierWave::Uploader::Base
  # Include RMagick, MiniMagick, or Vips support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  # include CarrierWave::Vips
  storage :file
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_allowlist
    %w[jpg jpeg png]
  end

  def size_range
    1.byte..50.megabytes
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename
  end

  protected

  def secure_token
    @secure_token ||= SecureRandom.uuid
  end
end
