#!/bin/bash

CERT_DIR="./tls"
CONTROL_PLANE_ROLE="kubernetes_control"
CONTROL_PLANE_NODES_JSON=$(ansible-inventory -i hosts --list | jq ".${CONTROL_PLANE_ROLE}.hosts")

echo "[san]" > ${CERT_DIR}/ca.conf
echo "subjectAltName = @alt_names" >> ${CERT_DIR}/ca.conf
echo "[alt_names]" >> ${CERT_DIR}/ca.conf

NODE_NUM=1

function add_control_plane() 
{
    CONF_FILE=$1
    NODE_LIST=$(echo ${CONTROL_PLANE_NODES_JSON} | jq -r -c '.[]')

    for i in ${NODE_LIST}
        do
            echo "DNS.${NODE_NUM} = ${i}" >> ${CONF_FILE}
            echo "IP.${NODE_NUM} = $( nslookup ${i} | tail -2 | head -1 | awk '{print $2}')" >> ${CONF_FILE}
            ((NODE_NUM=NODE_NUM+1))
        done

    echo "IP.${NODE_NUM} = 127.0.0.1" >> ${CONF_FILE}

}

add_control_plane ${CERT_DIR}/ca.conf

# Create private key for CA
openssl genrsa -out ${CERT_DIR}/ca.key 2048

# Create CSR using the private key
openssl req -new -key ${CERT_DIR}/ca.key -subj "/CN=KUBERNETES-CA/O=Kubernetes" -out ${CERT_DIR}/ca.csr

# Self sign the csr using its own private key
openssl x509 \
    -req \
    -in ${CERT_DIR}/ca.csr \
    -signkey ${CERT_DIR}/ca.key \
    -CAcreateserial  \
    -extensions "san" \
    -extfile ${CERT_DIR}/ca.conf \
    -out ${CERT_DIR}/ca.crt \
    -days 1000

# Below is from https://github.com/mmumshad/kubernetes-the-hard-way/blob/master/docs/04-certificate-authority.md
###############################
# Admin Certificate
###############################
  # Generate private key for admin user
  openssl genrsa -out ${CERT_DIR}/admin.key 2048

  # Generate CSR for admin user. Note the OU.
  openssl req -new -key ${CERT_DIR}/admin.key -subj "/CN=admin/O=system:masters" -out ${CERT_DIR}/admin.csr

  # Sign certificate for admin user using CA servers private key
  openssl x509 -req -in ${CERT_DIR}/admin.csr -CA ${CERT_DIR}/ca.crt -CAkey ${CERT_DIR}/ca.key -CAcreateserial  -out ${CERT_DIR}/admin.crt -days 1000

###############################
# kube-controller Certificate
###############################
  openssl genrsa -out ${CERT_DIR}/kube-controller-manager.key 2048

  openssl req -new -key ${CERT_DIR}/kube-controller-manager.key \
    -subj "/CN=system:kube-controller-manager/O=system:kube-controller-manager" -out ${CERT_DIR}/kube-controller-manager.csr

  openssl x509 -req -in ${CERT_DIR}/kube-controller-manager.csr \
    -CA ${CERT_DIR}/ca.crt -CAkey ${CERT_DIR}/ca.key -CAcreateserial -out ${CERT_DIR}/kube-controller-manager.crt -days 1000

###############################
# kube-proxy Certificate
###############################
  openssl genrsa -out ${CERT_DIR}/kube-proxy.key 2048

  openssl req -new -key ${CERT_DIR}/kube-proxy.key \
    -subj "/CN=system:kube-proxy/O=system:node-proxier" -out ${CERT_DIR}/kube-proxy.csr

  openssl x509 -req -in ${CERT_DIR}/kube-proxy.csr \
    -CA ${CERT_DIR}/ca.crt -CAkey ${CERT_DIR}/ca.key -CAcreateserial  -out ${CERT_DIR}/kube-proxy.crt -days 1000

###############################
# kube-scheduler Certificate
############################### 
  openssl genrsa -out ${CERT_DIR}/kube-scheduler.key 2048

  openssl req -new -key ${CERT_DIR}/kube-scheduler.key \
    -subj "/CN=system:kube-scheduler/O=system:kube-scheduler" -out ${CERT_DIR}/kube-scheduler.csr

  openssl x509 -req -in ${CERT_DIR}/kube-scheduler.csr -CA ${CERT_DIR}/ca.crt -CAkey ${CERT_DIR}/ca.key -CAcreateserial  -out ${CERT_DIR}/kube-scheduler.crt -days 1000

###############################
# kube-scheduler Certificate
############################### 
cat > ${CERT_DIR}/kube-api.cnf <<EOF
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[v3_req]
basicConstraints = critical, CA:FALSE
keyUsage = critical, nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names
[alt_names]
EOF

NODE_NUM=1
add_control_plane ${CERT_DIR}/kube-api.cnf

((NODE_NUM=NODE_NUM+1))

CONF_FILE=${CERT_DIR}/kube-api.cnf 
NODE_LIST="kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster kubernetes.default.svc.cluster.local"

    for i in ${NODE_LIST}
        do
            echo "DNS.${NODE_NUM} = ${i}" >> ${CONF_FILE}
            ((NODE_NUM=NODE_NUM+1))
        done


  openssl genrsa -out ${CERT_DIR}/kube-apiserver.key 2048

  openssl req -new -key ${CERT_DIR}/kube-apiserver.key \
    -subj "/CN=kube-apiserver/O=Kubernetes" -out ${CERT_DIR}/kube-apiserver.csr -config ${CERT_DIR}/kube-api.cnf

  openssl x509 -req -in ${CERT_DIR}/kube-apiserver.csr \
  -CA ${CERT_DIR}/ca.crt -CAkey ${CERT_DIR}/ca.key -CAcreateserial  -out ${CERT_DIR}/kube-apiserver.crt -extensions v3_req -extfile ${CERT_DIR}/kube-api.cnf -days 1000

###############################
# kubelet Certificate
############################### 
cat > openssl-kubelet.cnf <<EOF
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[v3_req]
basicConstraints = critical, CA:FALSE
keyUsage = critical, nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = clientAuth
EOF


