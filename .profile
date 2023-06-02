# Set HTTPS proxy if available
export https_proxy=$(echo "$VCAP_SERVICES" | jq --raw-output '.[][] | select(.name == "https-proxy-creds") | .credentials.uri')
[[ $https_proxy == "null" ]] && unset https_proxy:
