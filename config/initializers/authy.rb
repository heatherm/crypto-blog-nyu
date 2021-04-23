# Authy.api_key = ENV["AUTHY_API_KEY"]
Authy.api_key = Rails.application.credentials.authy[:api_key]
Authy.api_uri = "https://api.authy.com/"
