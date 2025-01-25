require 'sidekiq'
require 'sidekiq-scheduler'

REDIS_URL = 'redis://default:iaHtm561lKMiaCQ7t0aJ3TjIepIQYE11@redis-18932.c3.eu-west-1-1.ec2.redns.redis-cloud.com:18932'|| 'redis://localhost:6379/0'

Sidekiq.configure_server do |config|

  config.redis = { url: REDIS_URL }

  # Charge la configuration du scheduler
  if Rails.env.development?
    config.on(:startup) do
      schedule_file = Rails.root.join('config/sidekiq.yml')
      schedule = YAML.load_file(schedule_file) if schedule_file.exist?
    end
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: REDIS_URL }
end
