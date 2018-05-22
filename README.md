This was the repo I put together for Kubernetes-Canada's Waterloo May 2018 Meetup

It was intended to be presented as I went through it, but if you want to look at it for reference you can.
Essentially I talked about how StatefulSets do what they do, and why you might want that.

The examples folder contains the k8s parts:
0-dep
  This is a normal deployment.
  I showed how you can load-balance across them, but you can't be sure that you'll get the same data twice, etc.
  There's also no persistence.

1-raw
  This is a pod. It has uses a PersistentVolumeClaim built just for it, and a Headless service (where it sets the hostname and subdomain to match) to provide it a stable internal name it can be reached at.

2-multi
  This is a template (using jq) that generates a cluster of pods such as the above.
  They each have a different hostname, and a different PersistentVolumeClaim.

  This is great, but it doesn't get restarted when they die, etc.

3-stateful
  This is doing the same thing finally with the StatefulSet.
  This is the official k8s way and gives us a lot of useful benefits, but under the covers it's just doing the above.


Other things discussed in the room (as far as I recall):
- If you want an external service for each pod (like for exposing kafka to outside clients, etc) then you'll still need something like a loop that generates a service for each entry.
  We have a thing internally that runs as an operator that watches for changes and generates services based on a template.
  - To facilitate that, in newer versions of k8s each pod from a statefulset is given a distinguishing label you can use
- Stateful thing often need to do migrations, upgrades, etc. We talked a bit about techniques.
  - Using an init container to see, on each container, if it needs to perform some activity before it starts up
  - Just changing the startup script of the container to do something
  - A rolling technique where we first roll a cluster out entirely, then turn the feature on / make the config change once everything is out with another roll-out.
- Some sketchy thing involving taking elements out of the statefulset and manually mounting the PVCs in a raw pod that does some offline operation (probably not the right solution these days)
