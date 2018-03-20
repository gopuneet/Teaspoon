require 'dotenv'
require 'json'
Dotenv.load

out = {
    'type': ENV['FIREBASE_TYPE'],
    'project_id': ENV['FIREBASE_PROJECT_ID'],
    'private_key_id': ENV['FIREBASE_PRIVATE_KEY_ID'],
    'private_key': File.read('p_key').gsub("\\n", "\n"),
    'client_email': ENV['FIREBASE_CLIENT_EMAIL'],
    'client_id': ENV['FIREBASE_CLIENT_ID'],
    'auth_uri': ENV['FIREBASE_AUTH_URI'],
    'token_uri': ENV['FIREBASE_TOKEN_URI'],
    'auth_provider_x509_cert_url': ENV['FIREBASE_X509_AUTH_URL'],
    'client_x509_cert_url': ENV['FIREBASE_CLIENT_X509_CERT_URL']
}

puts JSON.generate(out)

File.write('tests/firebase_key.json', JSON.generate(out))