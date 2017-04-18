class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

    def self.aws_s3_credentials
      {
        access_key_id: ENV["AWS_KEY"],
        secret_access_key: ENV["AWS_SECRET"],
        bucket: ENV["AWS_BUCKET"],
        s3_region: ENV["AWS_REGION"]
      }
    end
end
