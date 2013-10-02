if Rails.env.production?
	ENV['S3_BUCKET_NAME'] = 'memeosa'
	ENV['S3_BUCKET_URL'] = 'https://memeosa.s3.amazonaws.com/'
else
	ENV['S3_BUCKET_NAME'] = 'generated-memes'
	ENV['S3_BUCKET_URL'] = 'https://generated-memes.s3.amazonaws.com/'
end
AWS.config({
		:access_key_id => ENV['ACCESS_KEY_ID'],
		:secret_access_key => ENV['SECRET_ACCESS_KEY'],
		#:access_key_id => 'AKIAJPXWZ3CRDM7QWZEA',
		#:secret_access_key => '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',
})