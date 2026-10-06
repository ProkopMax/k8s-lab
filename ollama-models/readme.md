curl -fsSL https://ollama.com/install.sh | sh
sudo systemctl enable --now ollama
sudo systemctl status ollama --no-pager
curl -s http://localhost:11434/api/tags

ollama pull qwen2.5-coder:14b-instruct-q4_K_M
ollama pull qwen3-coder:30b-a3b-q4_K_M
ollama pull nomic-embed-text

cat > Modelfile.qwen25-14b-16k <<'EOF'
FROM qwen2.5-coder:14b-instruct-q4_K_M
PARAMETER num_ctx 16384
EOF

cat > Modelfile.qwen3-30b-16k <<'EOF'
FROM qwen3-coder:30b-a3b-q4_K_M
PARAMETER num_ctx 16384
EOF

cat > Modelfile.qwen3-30b-32k <<'EOF'
FROM qwen3-coder:30b-a3b-q4_K_M
PARAMETER num_ctx 32768
EOF

ollama create qwen25-coder-14b-16k \
  -f Modelfile.qwen25-14b-16k

ollama create qwen3-coder-30b-16k \
  -f Modelfile.qwen3-30b-16k

ollama create qwen3-coder-30b-32k \
  -f Modelfile.qwen3-30b-32k