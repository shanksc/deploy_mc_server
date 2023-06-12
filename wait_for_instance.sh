while STATE=$(aws ec2 describe-instances --instance-ids $1 --output text --query 'Reservations[*].Instances[*].State.Name'); test "$STATE" != "running"; do
    sleep 1;
done;

