require 'sidekiq'
require 'sidekiq-scheduler'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }

  # Charge la configuration du scheduler
  if Rails.env.development?
    config.on(:startup) do
      schedule_file = Rails.root.join('config/sidekiq.yml')
      schedule = YAML.load_file(schedule_file) if schedule_file.exist?
    end
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }
end
