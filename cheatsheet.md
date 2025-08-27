# Cheatsheet for stuff I find practical

Run command with environment variables for that run with:

```bash
env $(cat .env | xargs) my_command
```

For colima and running test containers you will sometimes need to do this:

```bash
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock
export DOCKER_HOST="unix://${HOME}/.colima/docker.sock"
```
