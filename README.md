# Description
This is a test module that creates creates several aws instances and then runs an ansible playbook that installs nginx on each instance and creates an http configuration with an [upstream](https://nginx.org/ru/docs/http/ngx_http_upstream_module.html) section containing the hostnames of all the other instances 

# TODO
- [ ] readme
- [ ] manage ssh key using backend
- [x] add servers' ips to upstream section
- [x] parameterize configuration with variables
- [ ] create folders for different environments
- [ ] Hook up github actions/circle ci to run linter and terraform plan on commits
- [x] turn into modules
