while STATE=$(aws ec2 describe-instances --instance-ids $2 --output text --query 'Reservations[*].Instances[*].State.Name'); test "$STATE" != "running"; do
    sleep 1;
done;

READY=false
until $READY; do
    echo "- Waiting for connection"
    sleep $3
    set +e
    OUT=$(ssh -o ConnectTimeout=1 -o StrictHostKeyChecking=no -o BatchMode=yes ubuntu@$1 2>&1 | grep 'Permission denied' )
    [[ $? = 0 ]] && READY=true
    set -e
done
