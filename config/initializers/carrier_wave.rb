if Rails.env.development?
	CarrierWave.configure do |config|
		config.fog_credentials = {
			:provider => 'AWS',
			:aws_access_key_id => ENV['AWS_access_key_id'],
			:aws_secret_access_key => ENV['AWS_secret_access_key'],
			:region                => 'us-west-1'
		}

		config.fog_directory = ENV['AWS_BUCKET']
	end
end