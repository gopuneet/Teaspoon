require 'dotenv'
require 'json'
Dotenv.load

out = {
    'type': 'service_account',
    'project_id': ENV['FIREBASE_PROJECT_ID'],
    'private_key_id': ENV['FIREBASE_PRIVATE_KEY_ID'],
    'private_key': ENV['FIREBASE_PRIVATE_KEY'],
    'client_email': ENV['FIREBASE_CLIENT_EMAIL'],
    'client_id': ENV['FIREBASE_CLIENT_ID'],
    'auth_uri': 'https://accounts.google.com/o/oauth2/auth',
    'token_uri': 'https://accounts.google.com/o/oauth2/token',
    'auth_provider_x509_cert_url': 'https://www.googleapis.com/oauth2/v1/certs',
    'client_x509_cert_url': ENV['FIREBASE_CLIENT_X509_CERT_URL']
}

File.write('tests/firebase_key.json', JSON.generate(out))