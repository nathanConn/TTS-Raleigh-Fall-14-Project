if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Configuration for Amazon S3
      :provider              => 'AWS',
      :aws_access_key_id     => ENV['AKIAJKSCQBXRI5E3YZNQ'],
      :aws_secret_access_key => ENV['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']
    }
    config.fog_directory     =  ENV['ttsstack']
  end
end