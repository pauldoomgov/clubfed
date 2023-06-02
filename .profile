# Set HTTPS proxy if available
export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
export https_proxy=$(echo "$VCAP_SERVICES" | jq --raw-output '.[][] | select(.name == "https-proxy-creds") | .credentials.uri')
[[ $https_proxy == "null" ]] && unset https_proxy:
