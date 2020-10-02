This project will help you deploy a Docker cluster in AWS.

You will be able to choose the orchestrator to control your Docker cluster:
* Swarm
* Kubernetes.

The cluster will be highly available (HA) with 3 masters and 3 workers evenly distributed in 3 different availability zones located in the same AWS region.

You may choose deploying manually or with the help of a fully automated script:
* Automated installation in AWS (you may choose between a fully automated installation or a partial automated installation where you choose the steps to follow):
  * [Fully automated installation](README-auto-full.md)
  * [Partial automated installation](README-auto-partial.md)
* [Manual installation in AWS](README-manual.md)
