# 100-jokes

## First steps

1. Create ssh key in location `~/.ssh/scalac/id_rsa`
2. Deploy infrastructure `cd infrastructure && terraform apply`
3. Add ssh config from terraform output to file `~/.ssh/config`
4. Run ansible `cd ../ansible && ansible-playbook site.yaml`
5. Start ssh session to scalac host `ssh scalac`
6. In browser go to `http://localhost:8080/` and finish jenkins configuration

## Connect to Jenkins

1. Add ssh config from terraform output `cd infrastructure && tf output -json | jq '.main_vm_ssh_config.value' -r`
    Current config:
    ```
    Host scalac
        HostName 3.250.85.249
        User ubuntu
        IdentityFile ~/.ssh/scalac/id_rsa
        LocalForward 8080 localhost:8080
    ```
2. Add ssh key to proper location default: `~/.ssh/scalac/id_rsa`
3. Start ssh session to scalac host `ssh scalac`
4. In browser go to `http://localhost:8080/`
