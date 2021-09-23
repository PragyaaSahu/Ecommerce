# frozen_string_literal: true
# :Stripe Configuration:
Rails.configuration.stripe = {
              publishable_key: 'pk_test_51JAxb5SCyiDBRZbt0PJ9w6bKfcFDNe40ku4IGAH2gdmqwPr8q45NSRErYEJ20TKcZ3OKksBsEDrxwXHdkvyps9SC00ao96ovIz',
              secret_key: 'sk_test_51JAxb5SCyiDBRZbt4lKJl31cRILleGhNNcIXQ3vXqPzh4LBhNsZ8NV5f1PFnkrWrNoxA3fIenUHkN5v7AWqMyhCf00pJkH9YEK'
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]