require 'dotenv'
require 'json'
Dotenv.load

out = {
    'type': 'service_account',
    'project_id': ENV['FIREBASE_PROJECT_ID'],
    'private_key_id': ENV['FIREBASE_PRIVATE_KEY_ID'],
    'private_key': "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCqSl8P5fxOm2Uw\n7I9B7sZRiBfQEmURC69/FqshaQWZJZ9ax3U3nfnvhtx89Frg5lslxjMLFX70yQB2\nhwpM+rx+eT/tKAk2KdpUtTC+P+jmwgbfuoup0VjCl+62krhd/mla2DFX/U6ZooDA\nleSXojtX1tEcAp5t+8fRMyhXlLh3iAN4uSKashbQRhKnhgZomiQbq2Vxgx1Q4Fvb\nuKuNyfQUIjqFU+i/fXof53tpt+1OCarXlsDmoz0nAVtWaovC9BJbepofYee/tLUH\nidv/zrrls1fHZ6nqYEUicwfR3yXSQ2VO6spHSN1m9hY8A+CAMWKS53ZG70UBr9XF\npP5J0YXJAgMBAAECggEACyNTJWiPAJs0WqdWVWMnMIT8vby+RIelomParJRAa/xk\neF0MYydfhhWljTy0Rvp6IrXcd9CfnaYZ9Cav+0n5EzKeBkZ0l8jUAW9acU8fzhwJ\ntA9w/Bn3ur6SO/nLukYeIPV8ALvOLMlOr4n+Shav1/ZydekL8LijoKC+dkABcrvk\nuyKe+cdliby/P6k1u7j1JQx3we1EE0brMwz6tkRM6k1v3dpS0yOFsYwP3faqNW5v\nDBHFHdHHXNjq8jlMyVOQc7/EGK0eSvGIir4a6UU51BDhXc+ZNDzPwEO+KHc6uLTl\nJfuS7jgSaNjvqCyhaal3U2s9YevFXitxU8MDLV1Q4wKBgQDoCcnMaax3KP67X8WW\nhezMAFpbW2otfJTqejFNQJCC3fqGP/v7H3q97NtXlNfhvGnPPn/e3a0UhlYu3Y+Q\nN9YHbsy3vdms1Fql8A8Rp5nZXkU3WvMf53kH/qGh4r9hcHWNVl0sMK92OIPH3tym\n+wcLsgp2ba3LhusyFV81KShyRwKBgQC74DUOUlMne+c39h0aRwd5If+t4ZmbzBzz\nTxBbF4Db/TBS75nC9KV9GTtqVRE/A5D1VpHPdLyimmGMYLZ92aGf0tYWMY/vqlq3\nfgtHj1ocqqdniqWhSHL1xGHIGu/rFgJoclf99H9i4uCGBL82hD82i6pWOjxZ3C/I\nE7/zkVO/bwKBgAXHOJ8+gmz1OGKyH9l/vEXYPGfJ/vri/1JXeKLT2MVpgbOWJFA8\nmHHiVBP6QOX+KyReChEitAyuy7afDdQpj8rfl3l74M/M+fTn5XgrFEm1b0PRn/xL\nZ1grnxrI6rsiccrzO56+F6B6B84SXqxJ1AMWi+wnDwzibzjwD07jl35BAoGAUN0/\n+NoWUHhUHRIhlJ3d6ZVopz7jDtvb2h29vHdxTz66/feDBxal5CJoIGxc7/JpAjAw\nskpcpuAr/G/kHGb/2fq1ivfqLA323eOylypsbspFI5vZjoHQeVf9flOZ0GW4w5vz\no6sI6VcdrJF+e8iQLLoQpuyJ7WOIbWWSyRNUKKECgYEAwphW6Z5aLcSNeXP6j85k\nDLt8sRljzNoI/b3R88/Xq0lWYICFRI3EXo9VWmvsvtV/p7H+ls6Nfkl75kBTy2Gg\nRavgnIphgab4NHJ+Pmbk5qmpifINV8nVXONsq2CFx8Z6X2n+7T4d8M7ThGpfsrC7\nu9SC5i9FpcmHNL/bVToJoWk=\n-----END PRIVATE KEY-----\n",
    'client_email': ENV['FIREBASE_CLIENT_EMAIL'],
    'client_id': ENV['FIREBASE_CLIENT_ID'],
    'auth_uri': 'https://accounts.google.com/o/oauth2/auth',
    'token_uri': 'https://accounts.google.com/o/oauth2/token',
    'auth_provider_x509_cert_url': 'https://www.googleapis.com/oauth2/v1/certs',
    'client_x509_cert_url': ENV['FIREBASE_CLIENT_X509_CERT_URL']
}

File.write('tests/firebase_key.json', JSON.generate(out))