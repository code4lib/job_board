module Classifier
  def self.instance
    @instance ||= begin
      backend = ClassifierReborn::BayesRedisBackend.new url: ENV['REDIS_URL']
      ClassifierReborn::Bayes.new 'Ham', 'Spam',
        backend: backend,
        enable_threshold: true,
        threshold: -10.0
    end
  end

  def self.classify(job)
    instance.classify category, [job.display_title, job.description].join("\n")
  rescue StandardError
    nil
  end

  def self.train(category, job)
    instance.train category, [job.display_title, job.description].join("\n")
  end
end
