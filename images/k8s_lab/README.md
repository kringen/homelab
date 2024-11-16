# Build Image
```bash
docker build -t k8s_lab .
```

# Run Image
```bash
docker run -p 8080:8080 -p 6060:6060 k8s_lab
```

# Test in Browser
http://localhost:8080