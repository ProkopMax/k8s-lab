openssl genrsa -out /tmp/gitlab.k8s.lab.key 2048
chmod 600 /tmp/gitlab.k8s.lab.key

cat > /tmp/gitlab-openssl.cnf <<'EOF'
[req]
default_bits = 2048
prompt = no
distinguished_name = dn
req_extensions = req_ext

[dn]
CN = gitlab.k8s.lab

[req_ext]
subjectAltName = @alt_names

[alt_names]
DNS.1 = gitlab.k8s.lab
EOF

openssl req \
  -new \
  -key /tmp/gitlab.k8s.lab.key \
  -out /tmp/gitlab.k8s.lab.csr \
  -config /tmp/gitlab-openssl.cnf