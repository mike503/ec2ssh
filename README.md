## ec2ssh

### Why?

Having to lookup IPs by instance name in the AWS UI or CLI is annoying. This tries to automate it as much as possible, including selecting the right SSH key.

### Requirements

* AWS CLI installed and usable

    * `pip install awscli`
    * "aws configure" needs to be ran and keys setup, or
    * the instance in which this runs needs to be in an IAM role with (at minimum) `"ec2:Describe*"`

* jq (https://stedolan.github.io/jq/)

    * `apt-get install jq`

### Optional

* Bash completion

     * `sudo cp ec2ssh.bash_completion.sh /etc/bash_completion.d/ec2ssh`
     * `source /etc/bash_completion.d/ec2ssh` (or logout and log back in)

Assumptions:

* You're actually leaving the ubuntu or ec2-user accounts alone and the authorized_keys they're supposed to have (I've been guilty of this. Not anymore!)
* Security groups allow the SSH traffic from the source to the destination.
* Peering connections between different VPCs are setup (if applicable.)

### Notes

* This should work inside and outside of a VPC. If the destination is in a VPC, we try the private IP, otherwise it will fall back to the public IP.
* Tries to determine which user to use based on AMI information (and a little hardcoded hint)
* I've tried my best to make it as failsafe as I can. Bash scripting is annoying, so there might be edge cases where it still breaks.
* A major caveat currently is each tab completion request is an API hit. Investigating a microcaching solution.

### TODO

* Add in some microcaching. Easiest to use a flatfile like /tmp/ec2ssh.$username.$minute and a glob remove to remove old files?
* If there are multiple instance matches, we could prompt the user for which to connect to.
* If the user leaves a fragment, prompt for the possible options (this would be neat)
