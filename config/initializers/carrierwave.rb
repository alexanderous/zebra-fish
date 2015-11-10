#S3_CONFIG = YAML.load_file(Rails.root.join('config', 'amazon_s3.yml'))[Rails.env]

#CarrierWave.configure do |config|
#  config.storage              = :s3
#  config.s3_access_policy     = :public_read
#  config.s3_access_key_id     = S3_CONFIG['[redacted]']
#  config.s3_secret_access_key = S3_CONFIG['[redacted]']
#  config.s3_bucket            = S3_CONFIG['[redacted]']
#  config.fog_public = false
#end

CarrierWave.configure do |config|
	config.fog_credentials = {
		provider: "AWS",
		aws_access_key_id: "[redacted]",
		aws_secret_access_key: "[redacted]"
	}
	config.fog_directory = "[redacted]"
	config.fog_public = false
end
