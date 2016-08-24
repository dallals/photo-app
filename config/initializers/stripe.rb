Rails.configuration.stripe = {
  # :publishable_key => ENV['stripe_publishable_key'],
  # :secret_key      => ENV['SECRET_KEY']
  :publishable_key => 'pk_test_enCWKRnhWni6ogHcsJffmDo6',
  :secret_key      => 'sk_test_AkjvDFIdmQl5i6QiRVLNVwDc'
}
# :aws_secret_access_key => ENV['AWS_secret_access_key'],
Stripe.api_key = Rails.configuration.stripe[:secret_key]