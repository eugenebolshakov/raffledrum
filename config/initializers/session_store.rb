# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rr09-team-41_session',
  :secret      => 'bc1bfb1d69994bc5424ce92461382af6f10ba94b00d329edf07b01865444826279b5d22a01141a30cc7aa410ac31a9fffbb970f22b300f60c6bf4e0d5611ec96'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
