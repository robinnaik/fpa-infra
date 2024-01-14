# Overview
This repo contains terraform config for creating required infrastructure for Financial Planning Application's Frontend and Backend. 
(The config is being restructured in modules)

# Cluster Information
- Two separate clusters are created for each frontend and backend
- Both clusters are created as private clusters with no External IP exposed from VMs
- Both cluster have no external ip exposed except for external ip of the GKE control plane

# Key Networking
- VPC Network for both clusters use one primary subnet with /21 range in aisa-south1 region
- Backend cluster services use ips from a separate subnet. While creating services, fixed ip addresses can be used
- Cloud NAT is required to be set up for backend service as backend service connects to Cloud Mongo server hosted by MongoDB.
- Cloud NAT is not set up for frontend so no connection from cluster nodes to internet are allowed
- Firewalls are currently are set up with 0.0.0.0/0 as source address (#TODO: This needs to be reviewed and updated to narrowdown source addresses)
- VPC Peerig is created between both clusters so that frontend can connect to backend using internal ip addresses. 

# Environments
fpa-be/dev - Development environment for Backend
fpa-fe/dev - Development environment for Frontend
