if Rails.env.development? && defined?(MrVideo)
  MrVideo.configure do |config|
    config.cassette_library_dir = '/home/dima/code/cerner/health_tracker/tmp/vcr/'
  end
end
