from kubernetes import client, config
import os

def connect_to_cluster():
    """Connect to the Kubernetes cluster."""
    try:
        config.load_kube_config()  # Load kubeconfig from the default location
    except Exception as e:
        print(f"Failed to connect to the cluster: {e}")
        exit(1)

def list_running_pods(namespace):
    """List all pods in the specified namespace and check their statuses."""
    v1 = client.CoreV1Api()
    try:
        pods = v1.list_namespaced_pod(namespace)
        for pod in pods.items:
            pod_name = pod.metadata.name
            pod_status = pod.status.phase

            if pod_status != "Running":
                print(f"Pod '{pod_name}' is not running (Status: {pod_status}). Fetching logs...")
                fetch_and_save_logs(namespace, pod_name)
            else:
                print(f"Pod '{pod_name}' is running.")
    except client.exceptions.ApiException as e:
        print(f"Error listing pods: {e}")

def fetch_and_save_logs(namespace, pod_name):
    """Fetch logs for the specified pod and save them to a file."""
    v1 = client.CoreV1Api()
    try:
        logs = v1.read_namespaced_pod_log(name=pod_name, namespace=namespace)
        log_file = f"{pod_name}-logs.txt"
        with open(log_file, "w") as f:
            f.write(logs)
        print(f"Logs for pod '{pod_name}' saved to '{log_file}'.")
    except client.exceptions.ApiException as e:
        print(f"Failed to fetch logs for pod '{pod_name}': {e}")

if __name__ == "__main__":
    namespace = input("Enter the namespace to check (default: 'default'): ") or "default"

    # Connect to the Kubernetes cluster
    connect_to_cluster()

    # List running pods and check statuses
    list_running_pods(namespace)
    