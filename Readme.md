Sidecar container to mount an s3 bucket and share it with another container in
the same pod.

Create secret with:

`kubectl create secret generic awssecret --from-literal=AWSACCESSKEYID='MYACCESSKEYIDXXXXX' --from-literal=AWSSECRETACCESSKEY='mySecretKeyDontTellAnyone`


Example pod config:

```
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: mountconfig
data:
  BUCKET: 'mybucketname'
  MOUNTPOINT: '/test'

---
apiVersion: v1
kind: Pod
metadata:
  name: two-containers
spec:

  restartPolicy: Never

  volumes:
  - name: shared-data
    emptyDir: {}

  containers:

  - name: s3sidecar
    image: signaleleven/s3fs-sidecar
    imagePullPolicy: Always
    securityContext:
      privileged: true
      capabilities:
        add:
          - SYS_ADMIN
    env:
      - name: AWSACCESSKEYID
        valueFrom:
          secretKeyRef:
            name: awssecret
            key: AWSACCESSKEYID
      - name: AWSSECRETACCESSKEY
        valueFrom:
          secretKeyRef:
            name: awssecret
            key: AWSSECRETACCESSKEY
      - name: BUCKET
        valueFrom:
         configMapKeyRef:
          name: mountconfig
          key: BUCKET
      - name: MOUNTPOINT
        valueFrom:
         configMapKeyRef:
           name: mountconfig
           key: MOUNTPOINT

    volumeMounts:
    - name: shared-data
      mountPath: /test
      mountPropagation: Bidirectional

  - name: debian-container
    image: debian
    volumeMounts:
    - name: shared-data
      mountPath: /pod-data
      mountPropagation: HostToContainer

    command: ["/bin/sh"]
    args: ["-c", "echo running... && trap : TERM INT; (while true; do sleep 10; done) & wait"]

```
