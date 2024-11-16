FROM fedora:latest

COPY --chmod=0644 files/kubernetes.repo /etc/yum.repos.d/kubernetes.repo

RUN yum update -y
RUN yum install -y containerd autofs vim systemd jq kubelet kubeadm kubectl --disableexcludes=kubernetes

RUN find /lib/systemd/system/sysinit.target.wants/ -name "systemd-tmpfiles-setup.service" -delete && \
    rm -f /lib/systemd/system/multi-user.target.wants/* && \
    rm -f /etc/systemd/system/*.wants/* && \
    rm -f /lib/systemd/system/local-fs.target.wants/* && \
    rm -f /lib/systemd/system/sockets.target.wants/*udev* && \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl* && \
    rm -f /lib/systemd/system/basic.target.wants/* && \
    rm -f /lib/systemd/system/anaconda.target.wants/* && \
    echo "ReadKMsg=no" >> /etc/systemd/journald.conf && \
    useradd labuser -m -s /bin/bash



COPY --chmod=0755 files/startup.sh /usr/local/bin/startup.sh

RUN echo "Ensuring /etc/kubernetes/manifests" \
    && mkdir -p /etc/kubernetes/manifests

# RUN apt-get update && \
#     apt-get install -y curl && \
#     curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
#     apt-get install -y nodejs vim build-essential apt-transport-https ca-certificates curl gnupg systemd init jq autofs && \
#     curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
#     chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
#     echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list && \
#     chmod 644 /etc/apt/sources.list.d/kubernetes.list && \
#     apt-get update && \
#     apt-get install -y kubectl kubelet kubeadm containerd \
#     && 
#     && rm -f /lib/systemd/system/multi-user.target.wants/* \
#     && rm -f /etc/systemd/system/*.wants/* \
#     && rm -f /lib/systemd/system/local-fs.target.wants/* \
#     && rm -f /lib/systemd/system/sockets.target.wants/*udev* \
#     && rm -f /lib/systemd/system/sockets.target.wants/*initctl* \
#     && rm -f /lib/systemd/system/basic.target.wants/* \
#     && echo "ReadKMsg=no" >> /etc/systemd/journald.conf 

# COPY --chmod=0644 files/etc/* /etc/
# COPY --chmod=0644 files/etc/containerd/* /etc/containerd/
# COPY --chmod=0644 files/etc/default/* /etc/default/
# COPY --chmod=0644 files/etc/sysctl.d/* /etc/sysctl.d/
# COPY --chmod=0644 files/etc/systemd/system/* /etc/systemd/system/
# COPY --chmod=0644 files/etc/systemd/system/kubelet.service.d/* /etc/systemd/system/kubelet.service.d/
# COPY --chmod=0755 files/startup.sh /usr/local/bin/startup.sh

# RUN echo net.ipv4.ip_forward = 1 >> /etc/sysctl.d/k8s.conf
# RUN echo "Enabling / Disabling services ... " \
#     && systemctl enable kubelet.service \
#     && systemctl enable containerd.service \
#     && systemctl enable undo-mount-hacks.service \
#     && systemctl mask systemd-binfmt.service




RUN systemctl enable containerd autofs kubelet
CMD ["sh", "-c", "/usr/local/bin/startup.sh"]