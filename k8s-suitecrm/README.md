# Resize my EC2 EBS volume instance fot ext 4 file type

Increase the EBS volume on the AWS console then run the commands

1. Check
```df -hT```
2. Check the block size
```sudo lsblk```
3. ```df -hT```
4. ```sudo growpart /dev/nvme0n1 1```
5. ```sudo lsblk```
6. ```df -hT```
7. ```sudo resize2fs /dev/nvme0n1p1```
8. ```df -hT```