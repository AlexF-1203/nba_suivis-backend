require 'firebase-admin-sdk'

FirebaseAdmin.configure do |config|
  # Le contenu du fichier JSON que vous avez téléchargé
  config.credentials = {
    type: "service_account",
    project_id: "stats-balls",
    private_key_id: "1716d837d7d1e2c2be22b40137770b9228448025",
    private_key: "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDZ0cSo3YZ3Yb42\nQsLqkoQAgVoXaC1llgRICnmAQOIdEMCRmaHDOKAEhAr6jTqkzymMURReDYCs6o/7\nPpvECBbesehOs8MXEoJWUj9qRH+3MfKnZdXh9PmZIWiJ7/u2CJ4aJt3QFf+MtyaZ\n1bYpU3WaYIj47QXgcPoOCAw27CHhpd8Vg64k/eOVeKSAx1JSiDgy50Nf49O9MKJk\njJ2Xo83HKbnUfgIjGnclCMbq1grccdb32TAouWKdTstmBnJBUD37/QXMWmzGWory\nYHd0lzOQ3BQxJHZwayxe3+8JjXQmBHreUKAnbmaDnJKzGo62Ip+ij/2M47t164yX\nYdgbjmtrAgMBAAECggEABbUrhTaMHKBHj5P7GAaSkZG64trzxH2+ooWLYZvAMRSy\nQI/tiubT0YYccBUmUhzPaDlgOanMGRMk+tA13PtOjnlu4v6GFLG9bLBHUwlSBLQh\nxPmiqkjMNh7kw7MaZqvGrv+RdK+T+ax7f1OmiUr2cHNkUIwYA1/T9Zu2eAs8/yNv\nl6Qr3IaVbdi+Bn+4x7rFXEs2gKwL8ZHwbj8oeMJkSz4rSobWvxP4zPad2x7LMO7x\nGfLvMVmn5Mv+c+0lQgZc+OKPZwwmu5li7GSgHGsU0rKvW2HsGUp1SEt/Z+OduH0q\ndrXpaMEtKiaTXcfZmpzivQhjIQ7L5zqzZ6yswT6YJQKBgQD3ejwp3+f6kpSHL1bd\ntR0AkiMvUU1JkcTbr6pC4gMXt2phwvYv14iVF7J5ud7fqfwbEjWdCztMKcieRgxe\nVruxvCrrI5AI2lbL0vWYpRS2dZvEa6CMODngcGEcALykwUsXN8VYj3m+/QnfJVru\niAlaY6TMX328MoGomExQvVV/BQKBgQDhUhEzYj5gM+4FBkO6Fq+lrCG3t/3XXsr/\nadWxBr30a5mlCKQ7k+5TBBEEkpV0YHSFzsyDiSE8MzXmIBx8REuc0eyp1pZsxI3s\nil/aJibIG5o0ucWOR47/DGqpyvt9GR9D3Ol8xC0Kt3WMiE1mvxIK3ryMwUQqA+9j\nuh7nUefrrwKBgFozbGBa4wO6j3Zic8flboe5vCdP+9qXzefAtE8ib7wiNx0g4Xh4\nl6i39W5Wp/xfyarYTUBLSras+BlwMKvl8w2KJx6DXMlNQ5uQ7cFQUida4IaML/1L\ntRSwAUUio59tcIAq7Lwlt1s8gW+a/vS4Eqimbveqynpg8k9QC2jWSaY9AoGABaDM\nJzFsB3Ekn+GBLZPFfWjoSrOA1rFadrjJCqv1cLaDVvj5STevu0kdt7SFoSuLnZAF\n0b9KIjvRO9dPftch4F/p/nAKv9rFBMSMEmHjlBoEZw7A3YXyD3La8zTLxVssScCp\n4GDyExN0DzeUX12kcLsRkJ5/OmFwyFfsz7BfD6cCgYEAwE8GnhnLdeuMkGvfYWBk\nWIWLA3Cc3yvi4RghbZYcLceJFW0PW4WaG/Kl/oEy0Uc66TjAeIUsk7EOtghCz9xa\nmF33fPu1AInWIEnSb8ZVAqktJPzIdHmRWQP8jcScTTAAjSII3cRsTSDsdNY71LH9\ncyLjAjQJSR6d602xLFtvXiE=\n-----END PRIVATE KEY-----\n",
    client_email: "firebase-adminsdk-fbsvc@stats-balls.iam.gserviceaccount.com",
    client_id: "114040476411211309299",
    auth_uri: "https://accounts.google.com/o/oauth2/auth",
    token_uri: "https://oauth2.googleapis.com/token",
    auth_provider_x509_cert_url: "https://www.googleapis.com/oauth2/v1/certs",
    client_x509_cert_url: "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40stats-balls.iam.gserviceaccount.com",
  }
end
