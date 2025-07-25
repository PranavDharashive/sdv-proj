# K8s Cluster and Application Deployment Automation

## Goal

Create automation to install and configure the following with a single command or minimal steps using Ansible and bash. The automation should also include cleanup scripts. The target operating system is Ubuntu 22.04 LTS.

## Features

1.  **Kubernetes Prerequisites:** Setup `kubeadm` k8s prerequisites.
2.  **Kubernetes Cluster:** Setup a `kubeadm` single-node cluster. The user will be prompted for the cluster endpoint IP.
3.  **Kubernetes Verification:** Verify the k8s setup.
4.  **Monitoring Stack:**
    *   Install Prometheus Node Exporter on the VM.
    *   Deploy a monitoring stack which includes Prometheus and Grafana on k8s in the `monitoring` namespace.
5.  **Node Exporter Verification:** Verify the Node Exporter setup.
6.  **Prometheus Deployment:** Deploy Prometheus on the same k8s cluster.
7.  **Grafana Deployment:** Deploy Grafana on the same k8s cluster.
8.  **Monitoring Verification:** Verify the monitoring stack deployment.
9.  **Redis Deployment:**
    *   Create an `sdv` namespace.
    *   Deploy a single-pod Redis service with its corresponding Kubernetes service.
10. **Redis Verification:** Verify the Redis setup.
11. **MySQL Prerequsites:** Create the `/mnt/mysql-db-data/` directory on the VM.
12. **MySQL Deployment:**
    *   Create a local storage class named `sdv-local-storage` in the `sdv` namespace.
    *   Deploy MySQL on the same k8s cluster in the `sdv` namespace.
    *   Use a PersistentVolume (PV) and PersistentVolumeClaim (PVC) for MySQL data, utilizing the `sdv-local-storage` class.
13. **MySQL Verification and Configuration:**
    *   Verify the MySQL setup.
    *   Create a database named `sdv_data`.
    *   Create a MySQL user `sdvuser` with password `abcd1234` and grant all privileges.
14. **SDV App Deployment:**
    *   In the `sdv` namespace, deploy an application named `sdv-app` using the `nginx:latest` image and a Kubernetes service.
15. **SDV App Verification:** Verify the `sdv-app` deployment.
16. **SDV Frontend Deployment:**
    *   In the `sdv` namespace, deploy an Nginx frontend app named `sdv-nginx-frontend` using the `nginx:latest` image and a `NodePort` service.
17. **SDV Frontend Verification:** Verify the `sdv-nginx-frontend` deployment.
18. **MinIO Prerequisites:** Create the `/mnt/minio-storage/` directory on the VM.
19. **MinIO Deployment:**
    *   Create a `minio` namespace.
    *   Deploy MinIO on k8s with a local volume and a Kubernetes service.
20. **Logging:** Store all execution logs into a single file in the project directory.
21. **Documentation:** This `README.md` file will serve as documentation for prerequisites and execution steps.
