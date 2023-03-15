#!/bin/bash -x
#	./bin/cluster-kubernetes-leader.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x                                ;
#########################################################################
ip_leader=10.168.1.100                                                  ;
kube=kube-apiserver                                                     ;
log=/tmp/kubernetes-install.log                                         ;
sleep=10                                                                ;
#########################################################################
calico=https://docs.projectcalico.org/v3.14/manifests                   ;
cidr=192.168.0.0/16                                                     ;
kubeconfig=/etc/kubernetes/admin.conf                                   ;
#########################################################################
while true                                                              ;
do                                                                      \
        sudo systemctl                                                  \
                is-enabled                                              \
                        kubelet                                         \
        |                                                               \
                grep enabled                                            \
                && break                                                \
                                                                        ;
done                                                                    ;
#########################################################################
echo $ip_leader $kube | sudo tee --append /etc/hosts                    ;
sudo kubeadm init                                                       \
        --upload-certs                                                  \
        --control-plane-endpoint                                        \
                "$kube"                                                 \
        --pod-network-cidr                                              \
                $cidr                                                   \
        --ignore-preflight-errors                                       \
                all                                                     \
        2>&1                                                            \
|                                                                       \
tee --append $log                                                       \
                                                                        ;
#########################################################################
sudo kubectl apply                                                      \
        --filename                                                      \
                $calico/calico.yaml                                     \
        --kubeconfig                                                    \
                $kubeconfig                                             \
        2>&1                                                            \
|                                                                       \
tee --append $log                                                       \
                                                                        ;
#########################################################################
mkdir -p $HOME/.kube                                                    ;
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config                   ;
sudo chown -R $(id -u):$(id -g) $HOME/.kube/config                      ;
echo                                                                    \
        'source <(kubectl completion bash)'                             \
|                                                                       \
tee --append $HOME/.bashrc                                              \
                                                                        ;
#########################################################################
while true                                                              ;
do                                                                      \
        kubectl get node                                                \
        |                                                               \
        grep Ready                                                      \
        |                                                               \
        grep --invert-match NotReady                                    \
        &&                                                              \
        break                                                           \
                                                                        ;
        sleep $sleep                                                    ;
done                                                                    ;
#########################################################################
sudo sed --in-place                                                     \
        /$kube/d                                                        \
        /etc/hosts                                                      ;
sudo sed --in-place                                                     \
        /localhost4/s/$/' '$kube/                                       \
        /etc/hosts                                                      ;
#########################################################################
token="                                                                 \
        $(                                                              \
                grep --max-count 1                                      \
                        certificate-key                                 \
                        $log                                            \
        )                                                               \
"                                                                       ;
token_certificate=$(                                                    \
        echo -n $token                                                  \
        |                                                               \
        sed 's/\\/ /'                                                   \
        |                                                               \
        base64                                                          \
                --wrap 0                                                \
                                                                        ;
)                                                                       ;
#########################################################################
token="                                                                 \
        $(                                                              \
                grep --max-count 1                                      \
                        discovery-token-ca-cert-hash                    \
                        $log                                            \
        )                                                               \
"                                                                       ;
token_discovery=$(                                                      \
        echo -n $token                                                  \
        |                                                               \
        sed 's/\\/ /'                                                   \
        |                                                               \
        base64                                                          \
                --wrap 0                                                \
                                                                        ;
)                                                                       ;
#########################################################################
token="                                                                 \
        $(                                                              \
                grep --max-count 1                                      \
                        kubeadm.*join                                   \
                        $log                                            \
        )                                                               \
"                                                                       ;
token_token=$(                                                          \
        echo -n $token                                                  \
        |                                                               \
        sed 's/\\/ /'                                                   \
        |                                                               \
        base64                                                          \
                --wrap 0                                                \
                                                                        ;
)                                                                       ;
#########################################################################
echo YOU WILL NEED THE FOLLOWING TOKENS TO COMPLETE THE INSTALL         ;
echo FIRST IN THE MASTERS AND THEN IN THE WORKERS                       ;
echo export token_certificate=$token_certificate                        ;
echo export token_discovery=$token_discovery                            ;
echo export token_token=$token_token                                    ;
echo export ip_leader=$ip_leader                                        ;
echo export kube=$kube                                                  ;
echo export log=$log                                                    ;
#########################################################################




