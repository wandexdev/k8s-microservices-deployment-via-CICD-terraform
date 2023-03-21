## steps for usage
- manually:
	- cd into this folder and ensure its your pwd
	- ```terraform init```
	- ```terraform plan```
	- (optional) ```terraform graph -type plan  | dot -Tsvg > graph.svg```
	- ```terraform apply -auto-approve```
- get the the public ipv4 outputed and access the server by a browser
