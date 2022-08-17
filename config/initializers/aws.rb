Aws.config.update({
    region: 'ap-northeast-1',
    credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),
})


puts 'アプリの初期化ーーーーーーーーー'
S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['BUCKET'])