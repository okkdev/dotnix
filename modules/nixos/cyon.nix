{ ... }:
{
  security.pki.certificates = [
    # cyon.lan
    ''
      -----BEGIN CERTIFICATE-----
      MIIDgjCCAmqgAwIBAgIBATANBgkqhkiG9w0BAQsFADAzMREwDwYDVQQKDAhDWU9O
      LkxBTjEeMBwGA1UEAwwVQ2VydGlmaWNhdGUgQXV0aG9yaXR5MB4XDTE5MDMwNTE4
      MDAzM1oXDTM5MDMwNTE4MDAzM1owMzERMA8GA1UECgwIQ1lPTi5MQU4xHjAcBgNV
      BAMMFUNlcnRpZmljYXRlIEF1dGhvcml0eTCCASIwDQYJKoZIhvcNAQEBBQADggEP
      ADCCAQoCggEBAKcyIqPRhJnOn4QbOpk+ZgEEArrZPCeVPr7sNzWpyjSON4xSPPk/
      oGUOuaIpQxWF++84sCD/4f8MPG+0wY4qK1Sgsmi7SVQD5IPEryz51OezaDJ6AJoi
      M0Wg9ftmkxPZQKVuuDRKV7xW6CJ921nsjq71ieaC1QDTbce3+fbCOeMgUXFrslUs
      lrsV0RBw1Hdg64y454jW6DpXDowPYU8Ou2nSMgzuM/4wXovsR0IlMtv/QTerKqC9
      8SdiMbvC2w81y0P0ybio5ZWaL9bhEaLlS4IxnQAvNW/hBHC3HPF8KBsnJuHdl0h4
      rvqtH3ER6tAO1KOUt8Fl06g/wAQBdcisqDMCAwEAAaOBoDCBnTAfBgNVHSMEGDAW
      gBSIt7pkEzy7+ca+XOZ2bqCxhTI99TAPBgNVHRMBAf8EBTADAQH/MA4GA1UdDwEB
      /wQEAwIBxjAdBgNVHQ4EFgQUiLe6ZBM8u/nGvlzmdm6gsYUyPfUwOgYIKwYBBQUH
      AQEELjAsMCoGCCsGAQUFBzABhh5odHRwOi8vaXBhLWNhLmN5b24ubGFuL2NhL29j
      c3AwDQYJKoZIhvcNAQELBQADggEBAGO14vdtM0ReRybAHjDHB2Spk9mj2+17pXSN
      c+GTf4CX0TLYb3o9KAapflYGHFK4dQaQbJLjlX5vl5Kkrx9hQzx+54fupA4Wu9dj
      LCh4BxHH8V/bHsYYg9pCYmnVOVujrcfIUAwVh79J5kML/6IbdfF7yBojrfB+s0a8
      nuSLt9SI4kzNdbLVIHsH+ehSM7vLiva3T0NAN7ZfANY49KRITxZvwHkC1AH29+VC
      dmROPByWuk7NIEv4GNE62CfBO5CB+T49q2JwLkBqbh3X+27/ENbtZd0BQcxt49rI
      VGg2TagVpHxE5+ZAi2HyWMkLQscdx6iOeBhwWxWgJ5TY6mUy7KE=
      -----END CERTIFICATE-----
    ''
  ];

  networking.hosts = {
    "127.0.0.1" = [
      "my.cyon.tld"
      "order.cyon.tld"
      "froox.cyon.tld"
    ];
  };
}
