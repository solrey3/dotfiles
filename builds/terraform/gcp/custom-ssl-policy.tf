resource "google_compute_ssl_policy" "custom_ssl_policy" {
  name               = "custom-ssl-policy"
  profile            = "MODERN"
  min_tls_version    = "TLS_1_2"
  custom_features    = ["TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256", "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384"]
}
