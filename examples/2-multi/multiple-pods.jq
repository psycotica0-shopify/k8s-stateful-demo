range(3) | . as $i | (
{
  "apiVersion": "v1",
  "kind": "Pod",
  "metadata": {
    "labels": {
      "app": "test"
    },
    "name": "raw-pod-\($i)"
  },
  "spec": {
    "hostname": "raw-pod-\($i)",
    "subdomain": "headless-service",
    "containers": [
      {
        "image": "k8s-stateful-test:latest",
        "imagePullPolicy": "Never",
        "name": "app",
        "volumeMounts": [
          {
            "mountPath": "/saved",
            "name": "claim"
          }
        ]
      }
    ],
    "volumes": [
      {
        "name": "claim",
        "persistentVolumeClaim": {
          "claimName": "volume-claim-\($i)"
        }
      }
    ]
  }
},
{
  "kind": "PersistentVolumeClaim",
  "apiVersion": "v1",
  "metadata": {
    "name": "volume-claim-\($i)"
  },
  "spec": {
    "accessModes": [
      "ReadWriteOnce"
    ],
    "resources": {
      "requests": {
        "storage": "5Mi"
      }
    },
    "storageClassName": "standard"
  }
}
)
