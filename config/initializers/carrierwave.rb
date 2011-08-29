CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider              => 'AWS',
    :aws_access_key_id     => ENV['S3_ACCESS_KEY'],
    :aws_secret_access_key => ENV['S3_SECRET_ACCESS']  
  }
  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.storage :fog
  config.fog_directory = ENV['S3_BUCKET']
end